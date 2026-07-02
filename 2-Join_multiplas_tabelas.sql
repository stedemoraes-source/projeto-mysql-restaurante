-- atividade multiplas_tabelas.sql

use informatica;

select * from cliente limit 10;
select * from produtos limit 10;
select * from pedidos limit 10;

-- Selecionar: produtos: id, nome e descrição, info_produtos:  ingredientes
SELECT 
    p.id_produto,
    p.nome,
    p.descricao,
    i.ingredientes
FROM produtos p
INNER JOIN infos_produtos i 
    ON p.id_produto = i.id_produto;

-- Selecionar: pedidos:  id, quantidade e data, clientes: nome e email

SELECT 
    pe.id_pedido,
    pe.quantidade,
    pe.data_pedido,
    c.nome,
    c.email
FROM pedidos pe
INNER JOIN clientes c 
    ON pe.id_cliente = c.id_cliente;

-- Selecionar: pedidos:  id, quantidade e data, clientes: nome e email, funcionarios: nome

SELECT 
    pe.id_pedido,
    pe.quantidade,
    pe.data_pedido,
    c.nome AS clientes,
    c.email,
    f.nome AS funcionarios
FROM pedidos pe
INNER JOIN clientes c 
    ON pe.id_cliente = c.id_cliente
INNER JOIN funcionarios f 
    ON pe.id_funcionario = f.id_funcionario;

-- Selecionar: pedidos:  id, quantidade e data, clientes: nome e email, funcionarios: nome, produtos: nome, preco

SELECT 
    pe.id_pedido,
    pe.quantidade,
    pe.data_pedido,
    c.nome AS cliente,
    c.email,
    f.nome AS funcionario,
    pr.nome AS produto,
    pr.preco
FROM pedidos pe
INNER JOIN clientes c 
    ON pe.id_cliente = c.id_cliente
INNER JOIN funcionarios f 
    ON pe.id_funcionario = f.id_funcionario
INNER JOIN produtos pr 
    ON pe.id_produto = pr.id_produto;
    
-- Selecionar o nome dos clientes com os pedidos com status ‘Pendente’ e exibir por ordem descendente de acordo com o id do pedido

SELECT 
    c.nome,
    pe.id_pedido,
    pe.status
FROM pedidos pe
INNER JOIN clientes c 
    ON pe.id_cliente = c.id_cliente
WHERE pe.status = 'Pendente'
ORDER BY pe.id_pedido DESC;

-- Selecionar clientes sem pedidos

SELECT 
    c.nome,
    c.email
FROM clientes c
LEFT JOIN pedidos pe 
    ON c.id_cliente = pe.id_cliente
WHERE pe.id_pedido IS NULL;

-- Selecionar o nome do cliente e o total de pedidos cada cliente

SELECT 
    c.nome,
    COUNT(pe.id_pedido) AS total_pedidos
FROM clientes c
LEFT JOIN pedidos pe 
    ON c.id_cliente = pe.id_cliente
GROUP BY c.nome
order by total_pedidos desc;

-- Selecionar o preço total (quantidade*preco) de cada pedido

SELECT 
    pe.id_pedido,
    pe.quantidade,
    pr.preco,
    (pe.quantidade * pr.preco) AS total_pedido
FROM pedidos pe
INNER JOIN produtos pr 
    ON pe.id_produto = pr.id_produto
order by quantidade desc;


