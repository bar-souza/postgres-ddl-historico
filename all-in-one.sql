CREATE TABLE ddl_historico (
	id serial NOT NULL,
	ddl_data timestamptz NULL,
	usuario text NULL,
	ddl_tag text NULL,
	"schema" text NULL,
	nome_objeto text NULL,
	CONSTRAINT ddl_historico_pkey PRIMARY KEY (id)
);

CREATE OR REPLACE FUNCTION public.log_ddl()
 RETURNS event_trigger
 LANGUAGE plpgsql
AS $function$
DECLARE
  audit_query TEXT;
  r RECORD;
BEGIN
  IF tg_tag <> 'DROP TABLE'
  THEN
	FOR r IN SELECT * FROM pg_event_trigger_ddl_commands() 
	LOOP
      INSERT INTO ddl_historico (ddl_data, usuario, ddl_tag, schema, nome_objeto) VALUES (statement_timestamp(), CURRENT_USER, tg_tag, r.schema_name, r.object_identity);
	END LOOP;
  END IF;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.log_ddl_drop()
 RETURNS event_trigger
 LANGUAGE plpgsql
AS $function$
DECLARE
  audit_query TEXT;
  r RECORD;
BEGIN
  FOR r IN SELECT * FROM pg_event_trigger_dropped_objects() 
    LOOP
      INSERT INTO ddl_historico (ddl_data, usuario, ddl_tag, schema, nome_objeto) VALUES (statement_timestamp(), CURRENT_USER, tg_tag, r.schema_name, r.object_identity);
    END LOOP;
END;
$function$
;

CREATE EVENT TRIGGER log_ddl_info ON ddl_command_end EXECUTE PROCEDURE log_ddl();
CREATE EVENT TRIGGER log_ddl_drop_info ON sql_drop EXECUTE PROCEDURE log_ddl_drop();

CREATE TABLE testtable (id int, first_name text);
ALTER TABLE testtable ADD COLUMN last_name text;
ALTER TABLE testtable ADD COLUMN midlname text;
ALTER TABLE testtable RENAME COLUMN midlname TO middle_name;
ALTER TABLE testtable DROP COLUMN middle_name;

CREATE OR REPLACE VIEW public.testview
AS select * from testtable;

CREATE OR REPLACE VIEW public.testview
AS select * from testtable where id = 1;

drop view public.testview;

DROP TABLE testtable;

select * from ddl_historico dh ;