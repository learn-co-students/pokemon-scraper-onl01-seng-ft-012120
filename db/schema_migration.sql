-- Write your sql commands to create your db schema here.
-- It should create a table in a new table in the db/ directory.
CREATE TABLE IF NOT EXISTS pokemon(id INTEGER PRIMARY KEY, name TEXT, type TEXT);
-- sqlite3 path/to/database.db < source_of_sql_data
-- sqlite3 ./db/pokemon.db < ./db/schema_migration.sql