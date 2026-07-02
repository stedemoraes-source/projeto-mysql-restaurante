-- Procedimentos armazendos

use loja_informatica;

select * from cliente limit 10;
select * from produto limit 10;
select * from pedido limit 20;

-- Procedimento armazenado para listar todos os clientes
create procedure listarclientes()
	select * from cliente;

-- chamar o procedimento armazenado
call listarclientes();

-- Procedimento armazenado para inserir um novo pedido (nas tabelas de pedido e backup_pedido)
DELIMITER //
CREATE procedure AdicionarPedido(IN pedidoID INT, IN clienteID INT, IN produtoID INT, IN qtd INT, IN dataPedido DATE)
begin
	insert into pedido(id_pedido, id_cliente, id_produto, quantidade, data) values (pedidoID, clienteID, produtoID, qtd, dataPedido);
    insert into backup_pedido(id_pedido, id_cliente, id_produto, quantidade, data) values (pedidoid, clienteid, produtoid, qtd, datapedido);
    end //
DELIMITER ;

CALL AdicionarPedido(201, 1, 2, 10, '2024-03-01');

delete from pedido where id_pedido = 201;
delete from backup_pedido where id_pedido = 201;

-- procedimento armazenado para visualizar novos preços sem alterar a tabela produto e visualizar a quantidade de registros
DELIMITER //
CREATE PROCEDURE PromocaoProdutos(in desconto float, out totalProdutos INT)
begin
	declare fator_desconto float;
    set fator_desconto = (1 - (desconto/100));
    
    select count(*) into totalProdutos
    from produto;
    
    select id_produto, nome, preco as preco_original, round(preco * fator_desconto, 2) as preco_com_desconto
    from produto;
end //
DELIMITER ;

call PromocaoProdutos(10, @totalprodutos);
Select @totalprodutos as total_produtos_alterados;

-- Mostrar todos os procedimentos:
show procedure status;

-- Deletar procedimeto:
drop procedure if exists AdicionarPedido;

