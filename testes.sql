CREATE TABLE testtable (id int, first_name text);
ALTER TABLE testtable ADD COLUMN last_name text;
ALTER TABLE testtable ADD COLUMN midlname text;
ALTER TABLE testtable RENAME COLUMN midlname TO middle_name;
ALTER TABLE testtable DROP COLUMN middle_name;

CREATE OR REPLACE VIEW public.testview
AS select * from testtable;

CREATE OR REPLACE VIEW public.testview
AS select * from testtable where id = 1;

drop view public.testview

DROP TABLE testtable;
