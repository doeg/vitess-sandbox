# lookup keyspace
create table cats_seq(id int, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';
insert into cats_seq(id, next_id, cache) values(0, 1000, 100);
