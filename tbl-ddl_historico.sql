CREATE TABLE ddl_historico (
	id serial NOT NULL,
	ddl_data timestamptz NULL,
	usuario text NULL,
	ddl_tag text NULL,
	"schema" text NULL,
	nome_objeto text NULL,
	CONSTRAINT ddl_historico_pkey PRIMARY KEY (id)
);