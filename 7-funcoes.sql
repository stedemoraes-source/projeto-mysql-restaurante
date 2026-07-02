-- FUNÇÕES

use loja_informatica;

select * from cliente limit 10;
select * from produto limit 10;
select * from pedido limit 20;

-- Função para retornar o nome do cliente com base no seu ID
Delimiter //
create function BuscaClienteNome(IDcliente int)
returns varchar(200)
reads sql Data
begin
	declare nomeCliente varchar(200);
    select nome into nomeCliente from cliente where id_cliente = IDcliente;
    return nomeCliente;
    end //
    delimiter ;
    
-- Usar a função em uma consulta:
Select BuscaClienteNome(76);

-- Função para calcular o total de vendas de um produto:
DELIMITER //
create function totalVendas(produtoID int)
returns decimal (10,2)
reads sql data
begin
	declare total decimal(10,2);
    select sum(preco * quantidade) into total
    from pedido
    join produto on pedido.id_produto = pedido.id_produto
    where produto.id_produto = produtoID;
    return total;
end //
DELIMITER ;

select nome, totalVendas(id_produto) as total_vendas from produto;

-- Função para classificar o desempenho de vendas de um produto
DELIMITER //
Create function classificaDesempenhoVendas(produtoID INT)
returns varchar(100)
reads sql data
begin
	declare totalVendas decimal (10,2);
	declare desempenho varchar(100);

	select coalesce(sum(p.preco * pe.quantidade), 0) into totalVendas
	from produto p
	left join pedido pe on p.id_produto = pe.id_produto
	where p.id_produto = produtoID;

	set desempenho =
	case
	When totalVendas = 0 then 'Sem Vendas'
	when totalVendas <= 1000 then 'Baixo'
	when totalVendas <= 5000 then 'Medio'
	else 'Alto'
	end;

Return desempenho;
END //
DELIMITER ;

SELECT nome, classificaDesempenhoVendas(id_produto) as desempenho_vendas from produto;
