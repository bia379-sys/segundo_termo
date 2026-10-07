USE smartcoffee_dml_beatriz;

-- IMPORTANTE:
-- Para toda questão de UPDATE ou DELETE, escreva primeiro um SELECT
-- com o mesmo WHERE para validar os registros afetados.
SELECT * FROM cliente
-- PARTE A - INSERT

-- 1. Cadastre dois novos clientes com dados diferentes.
INSERT INTO cliente (nome,email,telefone,cidade,ativo) VALUES
('Brenda A', 'brenda@email.com', '19679999918', 'Caraguatatuba', TRUE),
('Fernanda S', 'fernanda@email.com', '19679099919', 'Capivari', TRUE);
SET @cliente = LAST_INSERT_ID();

-- 2. Cadastre a categoria 'Especiais da Casa'.
INSERT INTO categoria (nome) VALUES
('Especiais da Casa');


-- 3. Localize o id da categoria criada e cadastre três produtos nela.
INSERT INTO produto (nome, preco, ativo, id_categoria) VALUES
('Torta de Limão', 7.00, TRUE, 6),
('Cookies', 9.50, TRUE, 6), 
('Frapuccino cremoso', 15.50, TRUE, 6);

-- 4. Cadastre um terceiro cliente sem telefone.
INSERT INTO cliente (nome,email,telefone,cidade,ativo) VALUES
('Arabella Darwin', 'arabella@email.com', NULL, 'Limeira', TRUE);

-- 5. Crie um novo pedido para um dos clientes cadastrados.
INSERT INTO pedido (data_pedido, status, valor_total, id_cliente) VALUES
(NOW(), 'ABERTO', 0.00, 41);

-- 6. Use LAST_INSERT_ID() para guardar o id do pedido em @pedido_atividade
--    e insira pelo menos dois itens nesse pedido.
SET @pedido_atividade = LAST_INSERT_ID();
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario, observacao) VALUES
(@pedido_atividade, 49,1,43.75,''),
(@pedido_atividade, 50,1,16.00,'');

-- PARTE B - UPDATE

-- 7. Corrija o telefone de um dos clientes criados.
-- SELECT de validação:
-- UPDATE:
-- SELECT final:
UPDATE cliente
SET telefone = '19999897865'
WHERE id_cliente = 40;

-- 8. Altere cidade e telefone de outro cliente em um único UPDATE.
UPDATE cliente
SET telefone = '19956732126',
    cidade = 'Piracicaba'
WHERE id_cliente = 39;

-- 9. Aumente em 8% o preço dos produtos da categoria 'Especiais da Casa'.


-- 10. Altere o status do pedido criado para 'PREPARANDO'.


-- 11. Atualize valor_total do pedido de acordo com os itens cadastrados.
--     Você pode calcular previamente com SELECT SUM(quantidade * preco_unitario).


-- 12. Escolha um dos produtos criados e faça uma exclusão lógica (ativo = FALSE).


-- PARTE C - DELETE

-- 13. Crie um cliente de teste sem pedidos.
--     Depois localize e exclua apenas esse cliente.


-- 14. Tente excluir um cliente da base original que possua pedidos.
--     Deixe o DELETE comentado após o teste e descreva o erro abaixo.
-- Resultado observado:


-- 15. Explique em comentário por que a FK bloqueou a exclusão.
-- Resposta:


-- 16. Crie uma categoria temporária chamada 'Excluir Depois' e remova-a.