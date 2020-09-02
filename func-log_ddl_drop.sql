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