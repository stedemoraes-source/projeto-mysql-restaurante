
-- Agregação SQL: 

use informatica;

select * from pedidos limit 10;
select * from produtos limit 10;

SELECT COUNT(*) AS quantidade_pedidos
FROM pedidos;

SELECT COUNT(DISTINCT id_cliente) AS clientes_unicos
FROM pedidos;

SELECT AVG(preco) AS media_preco
FROM produtos;

select 
	min(preco) as preco_minimo,
	max(preco) as preco_maximo
from produtos;

SELECT *
FROM (
    SELECT 
        nome,
        preco,
        RANK() OVER (ORDER BY preco DESC) AS ranking
    FROM produtos
) AS ranking_produtos
WHERE ranking <= 5;

select 
	categoria,
    avg(preco) as media_preco
from produtos
group by categoria;

select * from infos_produtos;

SELECT 
    fornecedor,
    COUNT(*) AS id_produto
FROM infos_produtos
GROUP BY fornecedor;

select
	fornecedor,
    count(*) as quantidade_produtos
from infos_produtos
group by fornecedor
having count(*) >1;

SELECT 
    id_cliente,
    COUNT(*) AS quantidade_pedidos
FROM pedidos
GROUP BY id_cliente
HAVING COUNT(*) = 1;

