/*
Consultas avançadas
*/

use loja_informatica;

select * from cliente limit 10;
select * from produto limit 10;
select * from pedido limit 10;

-- View para simplificar a tabela cliente
Create view cliente_simples as
select id_cliente, nome, email
from cliente;

-- consultar a tabela
select * from cliente_simples;

-- Visualisar estrutura da View
Show create table cliente_simples;
Show create table cliente;

desc cliente_simples;

-- É possivel manipular dados igual tabelas (UPDATE, INSERT e DELETE)

-- Atualizar a view
create or replace view cliente_simples as 
select id_cliente, nome, cidade
from cliente;

-- Deletar View
drop view cliente_simples;
drop table cliente_simples; -- não permite que seja excluido pois é uma view e não uma tabela

-- View para calcular o total de pedidos feitos por cada cliente
create view cliente_pedido_total as
select c.nome, count(pe.id_pedido) as total_pedidos
from cliente c
left join pedido pe on c.id_cliente = pe.id_cliente
group by c.nome;

select * from cliente_pedido_total where total_pedidos > 15;

-- View para listar detalhes do cliente e total gasto:
create view cliente_gasto_total as
select c.nome, c.email, sum(p.preco * pe.quantidade) as total_gasto
from cliente c
join pedido pe on c.id_cliente = pe.id_cliente
join produto p on pe.id_produto = p.id_produto
group by c.nome, c.email;

select * from cliente_gasto_total where total_gasto > 500;