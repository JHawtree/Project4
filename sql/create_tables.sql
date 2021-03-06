DROP TABLE IF EXISTS users;

CREATE TABLE IF NOT EXISTS users (
    user_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lastname VARCHAR(50) NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    password CHAR(60) NOT NULL,
    active BOOLEAN NOT NULL
);

DROP TABLE IF EXISTS schedules;

CREATE TABLE IF NOT EXISTS schedules (
    schedule_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id SMALLINT NOT NULL,
    day SMALLINT NOT NULL CHECK (day >= 1 AND day <= 7),
    start_time timestamptz,
    end_time timestamptz CHECK (end_time > start_time),

    FOREIGN KEY(user_id) 
      REFERENCES users(user_id)
      ON DELETE CASCADE
);

DROP TABLE IF EXISTS email_confirmation;

CREATE TABLE IF NOT EXISTS email_confirmation (
    hash_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email VARCHAR(50) NOT NULL UNIQUE,
    hash CHAR(60) NOT NULL,

    FOREIGN KEY(email) 
      REFERENCES users(email)
      ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS password_reset (
    hash_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email VARCHAR(50) NOT NULL UNIQUE,
    hash CHAR(60) NOT NULL,

    FOREIGN KEY(email) 
      REFERENCES users(email)
      ON DELETE CASCADE
);