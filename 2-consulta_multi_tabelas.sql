-- outer join

use loja_informatica;

select * from cliente limit 10;
select * from produto limit 10;
select * from pedido limit 20;

-- INNER JOIN: VISUALIZAR CLIENTES COM PEDIDO:
select c.nome, pe.id_pedido
from cliente c
inner join pedido pe on c.id_cliente = pe.id_cliente;

-- LEFT OUTER JOIN: VISUALIZAR TODOS OS CLIENTES, INCLUINDO AQUELES COM PEDIDOS:
select c.nome, pe.id_cliente
from cliente c
left join pedido pe on c.id_cliente = pe.id_cliente; 

-- RIGHT OUTER JOIN: VISUALIZAR TODOS OS CLIENTES, INCLUINDO AQUELES COM PEDIDOS:
select c.nome, pe.id_cliente
from cliente c
right join pedido pe on c.id_cliente = pe.id_cliente; 

-- LEFT OUTER JOIN: VISUALIZAR TODOS CLIENTES SEM PEDIDOS
select c.*
from cliente c
left join pedido pe on c.id_cliente = pe.id_cliente
where pe.id_pedido IS NULL;

-- LEFT JOIN: VISUALIZAR TODOS OS CLIENTES, COM SEUS PEDIDOS E PRODUTOS, INCLUINDO AQUELES SEM PEDIDO E PRODUTOS
select c.nome, pe.id_pedido, p.nome as produto
from cliente c
left join pedido pe on c.id_cliente = pe.id_cliente
left join produto p on pe.id_produto = p.id_produto;

-- Calcular o total gasto por cada cliente em seus pedidos:
select c.nome, sum(p.preco * pe.quantidade) as total_gasto
from cliente c
inner join pedido pe on c.id_cliente = pe.id_cliente
inner join produto p on pe.id_produto = p.id_produto
group by c.nome; 

-- Visualizar quais clientes não gastaram em seus pedidos (erro):
select c.nome, sum(p.preco * pe.quantidade) as total_gasto
from cliente c
left join pedido pe on c.id_cliente = pe.id_cliente
left join produto p on pe.id_produto = p.id_produto
where p.preco IS NULL
group by c.nome; 


-- full join > mysql não tem essa opção, por isso, é preciso juntar o Right e Left Join 
select c.nome, pe.id_pedido
from cliente c
left join pedido pe on c.id_cliente = pe.id_cliente
where pe.id_pedido IS NULL
union
select c.nome, pe.id_pedido
from cliente c
right join pedido pe on c.id_cliente = pe.id_cliente
where pe.id_pedido IS NULL;

select c.nome as cliente, p.nome as produto, pe.quantidade
from cliente c
left join pedido pe on c.id_cliente = pe.id_cliente
left join produto p on pe.id_produto = p.id_produto
union
select c.nome as cliente, p.nome as produto, pe.quantidade
from cliente c
right join pedido pe on c.id_cliente = pe.id_cliente
right join produto p on pe.id_produto = p.id_produto;

-- natural join >>>>> NÃO RECOMENDADO

select * 
from pedido
natural join produto;

-- Self join
-- para compara todos os clientes da mesma cidade, excluindo comparações do mesmo cliente

select
c1.nome as Cliente1,
c2.nome as Cliente2,
c1.cidade as CidadeComum
from
cliente c1
join
cliente c2 on c1.cidade = c2.cidade and c1.id_cliente != c2.id_cliente
order by 
c1.cidade, c1.nome, c2.nome;




