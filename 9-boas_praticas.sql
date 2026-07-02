/* Boas Praticas
*/

use loja_informatica;

-- Utilizar alias simples e facil de entender:

select pe.id_pedido, c.nome as nome_cliente, p.nome as nome_produto, round(coalesce(pe.quantidade*p.preco, 0), 2) as valor_total
from cliente c
join pedido pe on c.id_cliente = pe.id_cliente
join produto p on pe.id_produto = p.id_produto;

-- evitar o uso de select *
select nome, email from cliente;
select 
	c.nome,
    c.email
from cliente c;

-- Usar EXPLAIN para otimizar consultas e Indices

explain
select c.nome, c.email,
	(select sum(pe.quantidade*pr.preco)
    from pedido pe
    join produto pr on pe.id_produto = pr.id_produto
    where pe.id_cliente = c.id_cliente) as total_pedido
from cliente c
order by total_pedido desc;
    
explain
select c.nome, c.email, sum(pe.quantidade * pr.preco) as total_pedido
    from cliente c
    left join pedido pe on c.id_cliente = pe.id_cliente
    left join produto pr on pe.id_produto = pr.id_produto
group by c.id_cliente, c.nome, c.email
order by total_pedido desc;

explain
select c.nome, c.email, sum(pe.quantidade * pr.preco) as total_pedido
from cliente c
    join pedido pe on c.id_cliente = pe.id_cliente
    join produto pr on pe.id_produto = pr.id_produto
group by c.id_cliente, c.nome, c.email
order by total_pedido desc;

create index idx_pedido_produto on pedido(id_produto); -- Criação de indice
drop index idx_pedido_produto on pedido; -- feletar indice


-- Evitar funções em colunas no Where
select * from pedido where month (data) = 1; -- ineficiente

select * from pedido where data between '2023-01-01' and '2023-01-31'; -- Eficiente


