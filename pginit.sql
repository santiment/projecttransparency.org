--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: sanbase; Type: SCHEMA; Schema: -; Owner: sanbase
--
CREATE SCHEMA extensions;
CREATE EXTENSON IF NOT EXISTS uuid-ossp SCHEMA extensions;


CREATE SCHEMA sanbase;

CREATE USER sanbase WITH PASSWORD 'sanbase';
ALTER USER sanbase SET search_path to sanbase, extensions;

ALTER SCHEMA sanbase OWNER TO sanbase;

--
-- PostgreSQL database dump complete
--
