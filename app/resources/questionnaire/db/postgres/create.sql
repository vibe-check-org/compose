CREATE TABLE IF NOT EXISTS kategorie (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT UNIQUE NOT NULL,
  beschreibung TEXT
);

CREATE TABLE IF NOT EXISTS fragebogen (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  titel TEXT NOT NULL,
  aktiv BOOLEAN DEFAULT TRUE,
  erstellt_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  aktualisiert_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS frage (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  text TEXT NOT NULL,
  typ TEXT NOT NULL,
  fragebogen_id UUID REFERENCES fragebogen(id) ON DELETE CASCADE,
  kategorie_id UUID REFERENCES kategorie(id) ON DELETE SET NULL
);
