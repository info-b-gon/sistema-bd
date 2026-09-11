create database biblioteca;

create table leitor(
	id serial primary key,
	nome varchar(80) not null,
	email varchar(120));
-- criei a tabela leitor

create table livro(
	id serial primary key,
	titulo varchar(100) not null,
	autor varchar(80) not null);
-- criei a tabela livro

create table emprestimo(
	id serial primary key,
	data_emprestimo date not null,
	id_leitor int,
	id_livro int,
	foreign key (id_leitor) references leitor(id),
	foreign key (id_livro) references livro(id));
-- criei a tabela emprestimo usando chaves estrangeiras

alter table leitor add column telefone varchar(20);
-- adicionando telefone no leitor
alter table livro alter column titulo type varchar(150);
-- mudando o tipo da coluna titulo
alter table emprestimo add column status varchar(20);
-- adicionando status no emprestimo

select * from livro;
alter table livro add column observacao varchar(100);
alter table livro drop column observacao;
-- fazendo o pedido do pdf de adicionar uma coluna, checar, remover e checar denovo

insert into leitor (nome, email, telefone) values
	('Ana Souza','ana@email.com','24999990001'),
	('Bruno Lima', 'bruno@email.com','24999990002'),
	('Carla Silva', 'carla@email.com','24999990003');
	
insert into livro (titulo, autor) values
	('Banco de Dados','Carlos Almeida'),
	('Introdução ao Java','Maria Santos'),
	('Git e GitHub','Paulo Oliveira');

insert into emprestimo (id_leitor, id_livro, data_emprestimo, status) values
	(1,1,'2026-09-01', 'ATIVO'),
	(1,3,'2026-09-02', 'ATIVO'),
	(2,2,'2026-09-03', 'DEVOLVIDO'),
	(3,1,'2026-09-04', 'ATIVO'),
	(3,3,'2026-09-05', 'DEVOLVIDO');
-- FAZENDO MUITAS INSERÇÕES NAS TABELAS COM DADOS VARIADOS

update leitor set telefone='24988880001' where id=1;
update livro set autor='Paulo Souza' where titulo='Git e GitHub';
update emprestimo set status='ATIVO' where id_leitor=2;
-- atualizando dados equivocados usando where pra criar condições pra nao alterar tudo na tabela

select * from emprestimo;
delete from emprestimo where id_leitor=1 and id_livro=3;
-- deletando um emprestimo equivocado e checando sempre

select * from leitor;
select l.nome, l.email, l.telefone from leitor l;
select * from livro where id>=2;
select * from emprestimo where status='ATIVO';
select count(*) from leitor;
select count(*) from emprestimo where status='ATIVO';
-- todas as seleções pedidas no pdf, nao tenho muito oq explicar

select l.nome, e.data_emprestimo, e.status from leitor l join emprestimo e on l.id=e.id_leitor;
-- uma consulta que apresente nome do leitor, data do empréstimo e status, relacionando leitor e emprestimo	
select l.nome, li.titulo, e.data_emprestimo, e.status from leitor l join emprestimo e on l.id=e.id_leitor join livro li on e.id_livro=l.id;
-- uma consulta que apresente nome do leitor, título do livro, data do empréstimo e status, relacionando leitor, emprestimo e livro com INNER JOIN.

select l.nome, count(e) from leitor l join emprestimo e on l.id=e.id_leitor group by l.nome;
select l.nome, count(e) from leitor l join emprestimo e on l.id=e.id_leitor group by l.nome order by e.count desc;
-- Mostre a quantidade de empréstimos realizados por cada leitor. O resultado deverá apresentar
--nome do leitor e quantidade de empréstimos. Utilize COUNT(), INNER JOIN e GROUP BY.
-- Utilizando a consulta anterior, ordene do leitor com maior quantidade de empréstimos para o
-- menor utilizando ORDER BY ... DESC.

select l.nome, li.titulo, li.autor, e.data_emprestimo, e.status from leitor l join emprestimo e on l.id=e.id_leitor join livro li on e.id_livro=l.id where e.status='ATIVO' order by l.nome asc;
-- uma consulta que mostre: nome do leitor, título do livro, autor, data do empréstimo e status.
--Mostre apenas os empréstimos com status ATIVO e ordene o resultado pelo nome do leitor em ordem
--alfabética.
