CREATE TABLE IF NOT EXISTS antwort (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL,
  fragebogen_id UUID NOT NULL,
  frage_id UUID NOT NULL,
  antwort TEXT NOT NULL,
  erstellt_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS antwort_template (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  frage_id UUID NOT NULL,
  antwort TEXT NOT NULL,
  punkte FLOAT,
  erstellt_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
