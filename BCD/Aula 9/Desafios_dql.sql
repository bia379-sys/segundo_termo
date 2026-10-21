-- ============================================================
-- AULA 09 - ATIVIDADE PRÁTICA DE DQL
-- Nome: Beatriz Santana Cordeiro
-- Turma: ______________________ Data: 07/10/2026
-- Base: smartcoffee_dql
-- ============================================================
USE smartcoffee_dql;

-- PARTE A - AQUECIMENTO

-- 1. Liste todos os clientes cadastrados.
SELECT * FROM cliente;

-- 2. Exiba apenas nome, cidade e e-mail dos clientes.
SELECT nome, cidade, email FROM cliente;

-- 3. Liste os nomes das cidades sem repetir valores.
SELECT DISTINCT cidade AS Cidade
FROM cliente;

-- 4. Liste todos os produtos em ordem crescente de preço.
SELECT nome, preco 
FROM produto
ORDER BY preco ASC;

-- 5. Mostre apenas os 5 produtos mais caros.
SELECT nome, preco
FROM produto
ORDER BY preco DESC
LIMIT 5;


-- PARTE B - FILTROS

-- 6. Liste os produtos com preço entre R$ 8,00 e R$ 15,00.
SELECT nome, preco
FROM produto
WHERE preco BETWEEN 8.00 AND 15.00;

-- 7. Liste os clientes das cidades Limeira ou Americana.
SELECT nome, cidade
FROM cliente
WHERE cidade IN ('Limeira', 'Americana');

-- 8. Localize os produtos cujo nome contém a palavra “Café”.
SELECT nome
FROM produto
WHERE nome LIKE '%Café%';

-- 9. Liste os clientes que não informaram telefone.
SELECT nome, telefone
FROM cliente
WHERE telefone IS NULL;


-- 10. Mostre os pedidos FINALIZADOS com valor acima de R$ 20,00,
--     do maior para o menor valor.
select * from pedido
where status = 'FINALIZADO' and valor_total > 20.00
order by valor_total desc;

-- PARTE C - CÁLCULOS E AGRUPAMENTOS

-- 11. Informe quantos produtos estão cadastrados.
SELECT id_categoria, COUNT(*) AS QTDE_PRODUTOS
FROM produto
GROUP BY id_categoria;


-- 12. Mostre menor preço, maior preço e preço médio dos produtos.
SELECT MIN(preco), MAX(preco), AVG(preco) AS MÉDIA_PREÇOS
FROM produto;


-- 13. Informe quantos clientes existem em cada cidade.
SELECT cidade, COUNT(*) AS QTDE_CIDADES
FROM cliente
GROUP BY cidade;


-- 14. Mostre somente as cidades que possuem dois ou mais clientes.
SELECT cidade, COUNT(*) AS QUANTIDADE_CLIENTES
FROM cliente
GROUP BY cidade
HAVING COUNT (*) >= 2;

-- 15. Calcule o faturamento total considerando apenas pedidos FINALIZADOS.
SELECT SUM(valor_total) AS FATURAMENTO_MENSAL
FROM pedido
WHERE status = 'ABERTO'

--Parte D — Relacionamentos Intermediário

--16. Liste cada pedido exibindo: id do pedido, data, nome do cliente, status e valor total.
SELECT P.id_pedido, P.data_pedido, C.nome AS cliente, P.valor_total, P.status
FROM pedido AS P
INNER JOIN cliente AS C 
ON C.id_cliente = P.id_cliente

-- 17. Liste cada produto acompanhado do nome de sua categoria.
SELECT PR.nome AS produto, CA.nome AS categoria
FROM produto AS PR
INNER JOIN categoria AS CA 
ON CA.id_categoria = PR.id_categoria;

-- 18. Gere um relatório dos itens vendidos exibindo: pedido, produto, quantidade, preço unitário e subtotal.
SELECT P.id_pedido, PR.nome AS produto, IP.quantidade, IP.preco_unitario, IP.quantidade * IP.preco_unitario AS subtotal
FROM pedido AS P
INNER JOIN item_pedido AS IP
ON IP.id_pedido = P.id_pedido
INNER JOIN produto AS PR
ON PR.id_produto = IP.id_produto
ORDER BY P.id_pedido;

-- 19. Mostre todos os clientes, inclusive aqueles que nunca fizeram pedidos.
SELECT C.nome, P.id_pedido, P.data_pedido
FROM cliente AS C
LEFT JOIN pedido AS P
ON P.id_cliente = C.id_cliente
ORDER BY C.nome;

-- 20. Liste apenas os clientes que nunca fizeram pedidos.
SELECT C.id_cliente, C.nome
FROM cliente AS C
LEFT JOIN pedido AS P
ON P.id_cliente = C.id_cliente
WHERE P.id_pedido IS NULL;

-- Parte E — Desafio Gerencial Avançado

-- 21. Informe quantos pedidos FINALIZADOS cada cliente realizou e quanto cada cliente gastou. Ordene do maior gasto para o menor.
SELECT C.nome AS cliente, COUNT (P.id_pedido) AS qtde_pedidos, SUM(P.valor_total) AS total_comprado
FROM cliente AS C
INNER JOIN pedido AS P
ON P.id_cliente = C.id_cliente
 WHERE P.status = "Finalizado"
 GROUP BY C.id_cliente, C.nome
 ORDER BY total_comprado DESC;

-- 22. Mostre a quantidade de produtos e o preço médio de cada categoria.
SELECT CA.nome AS categoria, COUNT(PR.id_produto) AS produtos, ROUND (AVG(PR.preco),2) AS preco_medio
FROM categoria AS CA
INNER JOIN produto AS PR
ON PR.id_categoria = CA.id_categoria
GROUP BY CA.id_categoria, CA.nome
ORDER BY preco_medio DESC

-- 23. Descubra quais produtos possuem preço superior ao preço médio de todos os produtos.
SELECT nome, preco
FROM produto
WHERE preco > (SELECT AVG(preco)
FROM produto
)
ORDER BY preco DESC;

-- 24. Classifique os produtos como “Econômico”, “Intermediário” ou “Premium”, utilizando faixas de preço definidas por você.
select nome,preco,
CASE 
    WHEN preco < 8.00 THEN 'Econômico'
    WHEN preco <= 15.00 THEN 'Intermediário'  
    ELSE  'Premium'
END AS classificação
FROM produto
ORDER BY preco;

-- 25. Crie uma consulta autoral que responda a uma pergunta útil para a gestão da SmartCoffee. Escreva primeiro a pergunta de negócio e depois a consulta SQL.
-- Qual é o preço médio dos produtos de acordo com sua categoria? 
SELECT c.nome AS categoria,
COUNT(pr.id_produto) AS produtos,
ROUND(AVG(pr.preco), 2) AS preco_medio
FROM categoria AS c
INNER JOIN produto AS pr
ON pr.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nome
ORDER BY preco_medio DESC;