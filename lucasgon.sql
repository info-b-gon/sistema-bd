-- cada departamento pode ter várias pessoas. cada pessoa pode ter um departamento. 
-- cada pessoa pode ter vários relatórios. cada relatório pode ter uma pessoa.

create database lucasgon;
create table departamento (id serial primary key, nome varchar(50) not null, area varchar(50) not null);
create table pessoa (id serial primary key, nome varchar(50) not null, endereco text not null, departamento_id int not null, foreign key (departamento_id) references departamento(id));
create table relatorio (id serial primary key, titulo varchar(50) not null, data date not null, pessoa_id int not null, foreign key (pessoa_id) references pessoa(id));
alter table departamento add column contato char(9) not null unique;
alter table departamento add column metas text not null;
insert into departamento (nome, area, contato, metas) values ('tesoureiros','finanças','993355999','aumentar o lucro'),('marketing','publicidade','996677888','ganhar novos clientes'),('produção','manufatura','997788777','dobrar a produção');
insert into pessoa (nome, endereco, departamento_id) values ('paulo','fonseca ramos',1),('roberta','carangola',2),('jorge','siméria',3);
insert into relatorio (titulo, data, pessoa_id) values ('agosto','2012-09-24',1),('setembro','2012-10-22',2),('dezembro','2012-12-29',3);
update departamento set nome='contabilidade' where id=1; -- trocando o nome de um departamento que estava equivocado
update relatorio set data='2012-12-01' where id=3; -- trocando a data errônea de um relatório
delete from relatorio * where id=1; -- excluindo um relatório de um funcionário que será demitido
delete from pessoa * where nome='paulo'; -- funcionário demitido
select pessoa.nome, departamento.nome from pessoa join departamento on pessoa.departamento_id = departamento.id;
select relatorio.titulo, pessoa.nome from relatorio join pessoa on relatorio.pessoa_id = pessoa.id;
select departamento.nome, relatorio.titulo from departamento join relatorio on departamento.id = relatorio.id;
select pessoa.endereco, departamento.contato from pessoa join departamento on pessoa.id = departamento.id;
select departamento.metas, pessoa.nome, relatorio.data from departamento join pessoa on departamento.id = pessoa.departamento_id join relatorio on pessoa.id = relatorio.pessoa_id