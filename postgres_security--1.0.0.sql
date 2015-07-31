-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION postgres_security" to load this file. \quit

CREATE SCHEMA postgres_security;

SET search_path TO postgres_security, pg_catalog, "$user", public;

CREATE TYPE text;

CREATE FUNCTION textin(cstring)
RETURNS text
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION textout(text)
RETURNS cstring
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION textrecv(internal)
RETURNS text
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION textsend(text)
RETURNS bytea
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE TYPE text (
	INPUT = textin,
	OUTPUT = textout,
	RECEIVE = textrecv,
	SEND = textsend,
	LIKE = pg_catalog.text,
  CATEGORY = "S"
);

RESET search_path;
