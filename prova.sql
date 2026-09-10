create database prova_passeios;

create table cliente(
	id serial primary key,
	nome varchar(80) not null,
	email varchar(120) not null unique,
	telefone varchar(20) not null unique);
-- criando a tabela cliente e seus atributos

create table passeio(
	id serial primary key,
	nome varchar(100) not null,
	data_passeio date not null,
	duracao_horas int not null,
	vagas int not null);
-- criando a tabela passeio e seus atributos


create table reserva(
	id serial primary key,
	data_reserva date not null,
	status varchar(20),
	id_cliente int,
	foreign key (id_cliente) references cliente(id));
-- criando a tabela reserva por ultimo (em razao da FK) e seus atributos

create table reserva_passeio(
	id_reserva int,
	id_passeio int,
	primary key (id_reserva, id_passeio),
	foreign key (id_reserva) references reserva(id),
	foreign key (id_passeio) references passeio(id));
-- criando a tabela de ligacao entre reserva e passeio (em razao do N para M)

select * from cliente;
select * from passeio;
select * from reserva;
select * from reserva_passeio;
-- as seleções obrigatorias

alter table passeio drop column data_passeio;
alter table passeio add column data_hora_saida timestamp;
alter table passeio add column data_hora_retorno timestamp;
-- sem alter de telefone pois ja deixei no começo. 
-- sem a adição do check para valores negativos pois nao me recordo disso
select * from passeio;
-- demais alters realizados com êxito

insert into cliente (nome, email, telefone) values
	('Mariana Costa', 'mariana@email.com', '24999991111'),
	('Rafael Martins', 'rafael@email.com', '24999992222'),
	('Juliana Alves', 'juliana@email.com', '24999993333'),
	('Felipe Rocha', 'felipe@email.com', '24999994444');
select * from cliente;
-- colocando dados na tabela cliente e verificando-os

insert into reserva (data_reserva, status, id_cliente) values
	('2026-09-10', 'CONFIRMADA', 1),
	('2026-09-11', 'CONFIRMADA', 2),
	('2026-09-12', 'PENDENTE', 1),
	('2026-09-13', 'CONFIRMADA', 3),
	('2026-09-14', 'PENDENTE', 4);
select * from reserva;
-- colocando dados na tabela reserva e verificando-os

insert into passeio (nome, data_hora_saida, data_hora_retorno, duracao_horas, vagas) values
	('Tour Histórico Imperial', '2026-10-10 08:00:00', '2026-10-10 13:00:00', 5, 30),
	('Trilha do Vale', '2026-10-15 07:00:00', '2026-10-15 16:00:00', 9, 20),
	('Circuito Cervejeiro', '2026-10-18 10:00:00', '2026-10-18 18:00:00', 8, 25),
	('Passeio Serra e Mirantes', '2026-10-25 06:30:00', '2026-10-25 18:30:00', 12, 18);
select * from passeio;
-- colocando dados na tabela passeio e verificando-os

insert into reserva_passeio values
	(1,1),(1,3),(2,1),(2,2),(3,2),(3,4),(4,1),(4,3),(4,4),(5,3),(5,4);
select * from reserva_passeio;
-- colocando associacoes na tabela de ligacao reserva_passeio e verificando-as

update cliente set telefone='24988881111' where id=1 and nome like 'Mariana%' and nome like '%Costa';
update reserva set status='CONFIRMADA' where id = 3 and data_reserva='2026-09-12' and status='PENDENTE';
update passeio set vagas=22 where id=4 and nome='Passeio Serra e Mirantes' and duracao_horas=12;
update passeio set duracao_horas=9 where id=3 and duracao_horas=8 and vagas=25;
select * from cliente;
select * from reserva;
select * from passeio;
-- fazendo atualizacoes nas tabelas de acordo com os requerimentos e verificando-as

select * from cliente;
select * from passeio;
select * from reserva_passeio;
delete from reserva_passeio where id_reserva=4 and id_passeio=3;
select * from reserva_passeio;
-- removendo felipe da viagem que desistiu, entretanto, nao consegui pensar em maneiras de usar duas condições AND nesse where

select * from cliente;	
select * from reserva where id >=3;
select count(*) from reserva where status='CONFIRMADA';
-- Parte 6 - DQL: consultas simples

select c.nome, r.id, r.status from cliente c join reserva r on c.id=r.id_cliente;
--Apresente nome do cliente, código da reserva e status da reserva relacionando cliente e reserva

select c.nome, r.id, r.status, p.nome, p.data_hora_saida, p.data_hora_retorno from cliente c 
join reserva r on c.id=r.id_cliente join reserva_passeio rp on r.id=rp.id_reserva join passeio p on rp.id_passeio=p.id;
-- Apresente nome do cliente, código da reserva, status, nome do passeio e data e hora de saída e retorno
-- relacionando cliente → reserva → reserva_passeio → passeio

select c.nome, r.id, p.nome from cliente c join reserva r on c.id=r.id_cliente join reserva_passeio rp on r.id=rp.id_reserva
join passeio p on rp.id_passeio=p.id where r.status='CONFIRMADA'and p.duracao_horas>=8 and r.id_cliente>=1;
-- Mostre nome do cliente, código da reserva e nome do passeio somente quando: status = CONFIRMADA,
-- duracao_horas >= 8 e id_cliente >= 1.

select c.nome, count(r) from cliente c join reserva r on c.id=r.id_cliente group by c.id order by c asc;
-- Mostre o nome de cada cliente e a quantidade de reservas realizadas por ele. 

select p.nome, count(c) from passeio p join reserva_passeio rp on p.id=rp.id_passeio join reserva r on rp.id_reserva=r.id join cliente c on r.id_cliente=c.id
group by p.nome order by c.count desc;
-- Mostre o nome de cada passeio e a quantidade de clientes associados a ele.

select c.nome, c.email, r.id, r.status, p.nome, p.data_hora_saida, p.data_hora_retorno, p.duracao_horas from cliente c 
join reserva r on c.id=r.id_cliente join reserva_passeio rp on r.id=rp.id_reserva join passeio p on rp.id_passeio=p.id
where r.status='CONFIRMADA' and p.duracao_horas>=8 order by (c.nome, p.data_Hora_saida);
--Crie uma consulta que apresente: nome do cliente, e-mail, código da reserva, status, nome do passeio, data e hora
--de saída, data e hora de retorno e duração em horas. Considere somente reservas CONFIRMADAS e passeios com
--duracao_horas >= 8. Ordene primeiro pelo nome do cliente e depois pela data e hora de saída do passeio.