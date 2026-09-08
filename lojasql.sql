create database loja111;

create table cliente (
id serial primary key,
nome varchar(80) not null,
cpf char(11) not null unique
);

create table pedido (
id serial primary key,
data_hora timestamp not null,
cliente_id int,
foreign key (cliente_id) references cliente(id)
);

create table produto (
id serial primary key,
nome varchar(80) not null,
preco int not null
);

create table pedido_produto (
pedido_id int,
produto_id int,
primary key (pedido_id, produto_id),
foreign key (pedido_id) references pedido(id),
foreign key (produto_id) references produto(id)
);

alter table cliente add column telefone char(9) not null unique;

insert into cliente (nome, cpf, telefone)
values ('marcos', 11111111111, 99111111),
('joão', 22222222222, 99222222);

insert into pedido (data_hora, cliente_id)
values ('2026-08-01 13:30', 1),
('2026-01-03 16:58', 2);

insert into produto (nome, preco)
values ('moletom', 350),
('touca', 200);

insert into pedido_produto (pedido_id, produto_id)
values (1, 1),
(2, 2);

update cliente set nome = 'Paulo' where id = 1 and nome = 'marcos';

update pedido set data_hora = '2026-08-03 11:00'
where data_hora = '2026-01-03 16:58' and cliente_id = 2;

update produto set preco = 119
where nome = 'touca' and preco = 200;

delete from pedido_produto
where pedido_id = 1 and produto_id = 1;

select nome from cliente;

select data_hora from pedido
where id >= 2;

select count(*) from produto
where preco >= 100 and preco <= 1000;

select c.nome, ped.data_hora, pp.pedido_id, prod.nome
from cliente as c
inner join pedido as ped on c.id = ped.cliente_id
inner join pedido_produto as pp on ped.id = pp.pedido_id
inner join produto as prod on pp.produto_id = prod.id
where c.id = 2 and ped.id >= 1 and prod.id >= 1;
-- mostre nome, data e hora, id do pedido e nome do produto dos pedidos e produtos comprados pelo usuario de id 2 que estejam acima do id 1

select c.nome, c.cpf, pp.pedido_id
from cliente as c
inner join pedido as ped on c.id = ped.cliente_id 
inner join pedido_produto as pp on ped.id = pp.pedido_id 
where c.id = 2 and ped.id >=1;
-- mostre nome, cpf e o id do pedido da compra de id 1 do usuario de id 2 

select c.nome, ped.id
from cliente as c
inner join pedido as ped on c.id = ped.cliente_id 
where c.id>=1 and ped.id>=1
group by c.id, ped.id
order by ped.id desc;
-- debora, nem com IA eu consegui achar uma maneira de fazer isso como esta suposto a ser feito na folha...
-- o melhor que consegui foi desse jeito, alterando o group by pra ''group by c.______, ped.________''