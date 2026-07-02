/*
Atividade
*/

use informatica;
-- 1.

CREATE VIEW resumo_pedido AS 
SELECT 
    pe.id_pedido,
    pe.quantidade,
    pe.data_pedido,
    c.nome AS nome_cliente,
    c.email,
    f.nome AS nome_funcionario,
    p.nome AS nome_produto,
    p.preco
FROM pedidos pe
JOIN clientes c ON pe.id_cliente = c.id_cliente
JOIN funcionarios f ON pe.id_funcionario = f.id_funcionario
JOIN produtos p ON pe.id_produto = p.id_produto;

select * from resumo_pedido;

-- 2.
select
	id_pedido,
    nome_cliente,
    (quantidade * preco) as total
from resumo_pedido;

-- 3.
CREATE or replace VIEW resumo_pedido AS 
SELECT 
    pe.id_pedido,
    pe.quantidade,
    pe.data_pedido,
    c.nome AS nome_cliente,
    c.email,
    f.nome AS nome_funcionario,
    p.nome AS nome_produto,
    p.preco,
    (pe.quantidade*p.preco) as total
FROM pedidos pe
JOIN clientes c ON pe.id_cliente = c.id_cliente
JOIN funcionarios f ON pe.id_funcionario = f.id_funcionario
JOIN produtos p ON pe.id_produto = p.id_produto;

select * from resumo_pedido;

-- 4.

SELECT 
    id_pedido,
    nome_cliente,
    total
FROM resumo_pedido;

-- 5.
explain
SELECT 
    id_pedido,
    nome_cliente,
    total
FROM resumo_pedido;

-- 6.

DROP FUNCTION IF EXISTS BuscaIngredientesProduto;

DELIMITER //

CREATE FUNCTION BuscaIngredientesProduto(idProduto INT)
RETURNS VARCHAR(500)
DETERMINISTIC
BEGIN

DECLARE ingredientesProduto VARCHAR(500);

SELECT GROUP_CONCAT(ingredientes SEPARATOR ', ')
INTO ingredientesProduto
FROM infos_produtos
WHERE id_produto = idProduto;

RETURN ingredientesProduto;

END //

DELIMITER ;

delimiter ;

-- 7.
SELECT BuscaIngredientesProduto(10);

DROP FUNCTION BuscaIngredientesProduto;

-- 8.

DELIMITER //

CREATE FUNCTION mediaPedido(idPedido INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN

DECLARE totalPedido DECIMAL(10,2);
DECLARE mediaPedidos DECIMAL(10,2);

SELECT quantidade * preco
INTO totalPedido
FROM pedidos
WHERE id_pedido = idPedido;

SELECT AVG(quantidade * preco)
INTO mediaPedidos
FROM pedidos;

IF totalPedido > mediaPedidos THEN
    RETURN 'Total do pedido está acima da média';

ELSEIF totalPedido < mediaPedidos THEN
    RETURN 'Total do pedido está abaixo da média';

ELSE
    RETURN 'Total do pedido é igual à média';

END IF;

END //cliente_pedido_totaltotal_pedidostotal_pedidos

DELIMITER ;

-- 9. 

SELECT mediaPedido(5);

SELECT mediaPedido(6);backup_pedidosclienteresumo_pedidoid_pedidodata_pedido