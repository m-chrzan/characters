CREATE TABLE Character (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    race TEXT NOT NULL
);

CREATE TABLE ChAbility (
    name TEXT NOT NULL,
    character_id INTEGER REFERENCES Character(id),
    description TEXT,
    PRIMARY KEY (name, character_id)
);

CREATE TABLE ChAttribute (
    name TEXT NOT NULL,
    character_id INTEGER REFERENCES Character(id) ON DELETE CASCADE,
    value INTEGER NOT NULL,
    PRIMARY KEY (name, character_id)
);

CREATE TABLE Item (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    character_id INTEGER REFERENCES Character(id) ON DELETE CASCADE
);

CREATE TABLE ItAbility (
    name TEXT NOT NULL,
    item_id INTEGER REFERENCES Item(id) ON DELETE CASCADE,
    description TEXT,
    PRIMARY KEY (name, item_id)
);

CREATE TABLE ItAttribute (
    name TEXT NOT NULL,
    item_id INTEGER REFERENCES Item(id) ON DELETE CASCADE,
    value INTEGER NOT NULL,
    PRIMARY KEY (name, item_id)
);
