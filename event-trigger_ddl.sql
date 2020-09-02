CREATE EVENT TRIGGER log_ddl_info ON ddl_command_end EXECUTE PROCEDURE log_ddl();
CREATE EVENT TRIGGER log_ddl_drop_info ON sql_drop EXECUTE PROCEDURE log_ddl_drop();