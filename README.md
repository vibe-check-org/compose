## 🛠 PostgreSQL vorbereiten (einmalig)

### 0. Repository vorbereiten

📥 **Volumes-Repository klonen oder herunterladen:**

> Entweder über GitHub klonen oder als ZIP herunterladen. Wichtig sind die folgenden Ordner:
>
> * `keycloak`
> * `mongo`
> * `postgres template`

📁 **Ordner umbenennen:**

> Nach dem Download den Ordner `postgres template` in `postgres` umbenennen, damit `docker compose` korrekt funktioniert.

---

### 1. `postgres/compose.yml` temporär anpassen

🔧 **Folgende Zeilen auskommentieren:**

* Zeilen **7–10**: `command:`-Block mit TLS-Aktivierung (temporär deaktivieren)
* Zeile **25**: `read_only: true` bei `key.pem`
* Zeile **29**: `read_only: true` bei `certificate.crt`
* Zeile **42**: `user: "postgres:postgres"`

✅ Dadurch kann der Container mit Root-Rechten starten und die Dateiberechtigungen korrekt setzen.

---

### 2. PostgreSQL-Container starten

```bash
docker compose up -d
```

Dann in einem zweiten Terminal:

```bash
docker compose exec postgres bash
```

---

### 3. Berechtigungen im Container setzen

```bash
chown postgres:postgres /var/lib/postgresql/tablespace
chown postgres:postgres /var/lib/postgresql/tablespace/answer
chown postgres:postgres /var/lib/postgresql/tablespace/questionnaire
chown postgres:postgres /var/lib/postgresql/tablespace/user
chown postgres:postgres /var/lib/postgresql/tablespace/vibe-profile
chown postgres:postgres /var/lib/postgresql/key.pem
chown postgres:postgres /var/lib/postgresql/certificate.crt
chmod 600 /var/lib/postgresql/key.pem
chmod 600 /var/lib/postgresql/certificate.crt
exit
```

---

### 4. Container stoppen

```bash
docker compose down
```

---

### 5. `postgres/compose.yml` wiederherstellen

🔁 **Folgende Änderungen rückgängig machen:**

* Zeilen **7–10**: `command:`-Block zur TLS-Aktivierung wieder aktivieren
* Zeilen **25, 29**: `read_only: true` wieder hinzufügen
* Zeile **42**: `user: "postgres:postgres"` wieder aktivieren

---

### 6. SQL-Daten laden

```bash
docker compose up -d
```

Dann in einem zweiten Terminal:

```bash
docker compose exec postgres bash
```

```bash
psql -U postgres -d postgres -f /sql/answer/create-answer-db.sql
psql -U answer_db_user -d answer_db -f /sql/answer/create-answer-schema.sql

psql -U postgres -d postgres -f /sql/questionnaire/create-questionnaire-db.sql
psql -U questionnaire_db_user -d questionnaire_db -f /sql/questionnaire/create-questionnaire-schema.sql

psql -U postgres -d postgres -f /sql/user/create-user-db.sql
psql -U user_db_user -d user_db -f /sql/user/create-user-schema.sql

psql -U postgres -d postgres -f /sql/vibe-profile/create-vibe-profile-db.sql
psql -U vibe_profile_db_user -d vibe_profile_db -f /sql/vibe-profile/create-vibe-profile-schema.sql

exit
```

```bash
docker compose down
```

---

### 7. App starten

```bash
cd app
docker compose up -d
```
