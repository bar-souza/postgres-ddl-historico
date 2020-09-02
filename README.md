# Log de DDL com event trigger - PostgreSQL

## 1. Criando a tabela

Os logs de DDL serão armazenados em uma tabela do banco de dados.

[tbl-ddl_historico.sql](https://github.com/bar-souza/postgres-ddl-historico/blob/master/tbl-ddl_historico.sql)

## 2. Criando as funções
Precisaremos de duas funções para inserir os logs de DDL na tabela criada anteriormente. Uma função fará os  logs de criação e alteração e outra fará os logs da exclusão dos objetos.

### 2.1 Função log_ddl()
[func-log_ddl.sql](https://github.com/bar-souza/postgres-ddl-historico/blob/master/func-log_ddl.sql)
### 2.2 Função log_ddl_drop()
[fun-log_ddl_drop.sql](https://github.com/bar-souza/postgres-ddl-historico/blob/master/func-log_ddl_drop.sql)

## 3. Criando as event triggers
Após a criação das duas funções, criamos as event triggers. Uma para cada função
[event-trigger_ddl.sql](https://github.com/bar-souza/postgres-ddl-historico/blob/master/event-trigger_ddl.sql)
