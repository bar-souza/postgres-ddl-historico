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
