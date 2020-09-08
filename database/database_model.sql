/* Database model HandDoc */

CREATE DATABASE sesion;

CREATE TABLE IF NOT EXISTS "user" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL,
	"lastName"	TEXT NOT NULL,
	"personalIdentification"	INTEGER NOT NULL UNIQUE,
	"email"	TEXT NOT NULL UNIQUE,
	"loggedIn" INTEGER,
	"password"	TEXT NOT NULL,
	"birthday"	TEXT NOT NULL,
	"height"	REAL NOT NULL,
	"weight"	REAL NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);

