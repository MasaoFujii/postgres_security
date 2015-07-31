-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION postgres_security" to load this file. \quit

CREATE SCHEMA postgres_security;

SET search_path TO postgres_security, pg_catalog, "$user", public;

CREATE TYPE int4;

CREATE FUNCTION int4in(cstring)
RETURNS int4
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION int4out(int4)
RETURNS cstring
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION int4recv(internal)
RETURNS int4
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION int4send(int4)
RETURNS bytea
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE TYPE int4 (
	INPUT = int4in,
	OUTPUT = int4out,
	RECEIVE = int4recv,
	SEND = int4send,
	LIKE = pg_catalog.int4,
  CATEGORY = "N"
);

CREATE CAST (int4 AS integer) WITH INOUT AS IMPLICIT;
CREATE CAST (integer AS int4) WITH INOUT AS IMPLICIT;
