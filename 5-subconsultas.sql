/*
SUBCONSULTAS
*/

use loja_informatica;

select * from cliente limit 10;
select * from produto limit 10;
select * from pedido limit 20;

-- Suconsulta Where:

select nome
from cliente
where id_cliente in (select id_cliente from pedido);

select distinct c.nome
from cliente c
join pedido pe on c.id_cliente = pe.id_cliente;

select nome, email
from cliente
where id_cliente in (select id_cliente from pedido where quantidade > 5);

-- Suconsulta select:

select nome, 
	(select count(*) from pedido where pedido.id_cliente = cliente.id_cliente) as total_pedido
from cliente;

select c.nome, c.email,
	(select sum(pe.quantidade * pr.preco)
    from pedido pe
    join produto pr on pe.id_produto = pr.id_produto
    where pe.id_cliente = c.id_cliente) as total_pedido
from cliente c order by total_pedido desc;

-- Suconsulta having:

select categoria, avg(preco) as media_preco 
from produto
group by categoria
having avg(preco) > (select avg(preco) from produto);
-- selecionando a categoria e media de preço, agrupando por categoria, 
-- a media do preço seja maior do que a media de produto, ou seja, somente será mostrado a categoria que a media do produto acima da média geral

-- Suconsulta from:
select cl.nome, pedidos_agregados.total_pedidos, pedidos_agregados.soma_quantidade
from cliente cl
join (
	select id_cliente, count(*) as total_pedidos, sum(quantidade) as soma_quantidade
    from pedido
    group by id_cliente
) as pedidos_agregados on cl.id_cliente = pedidos_agregados.id_cliente;

-- Suconsulta order by:

select c.nome, c.email
from cliente c
order by (
	select sum(pe.quantidade * pr.preco)
    from pedido pe join produto pr on pe.id_cliente = pr.id_produto where pe.id_cliente = c.id_cliente
) desc;
