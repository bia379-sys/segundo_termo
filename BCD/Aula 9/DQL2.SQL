INSERT INTO cliente (nome,email, telefone,cidade,ativo) VALUES
('Edson Wladimir', 'edson@email.com', '19999888244', 'Paris', TRUE);

-- Exemplo de estrutura simples de SELECT
-- SELECT coluna
-- FROM tabela;

-- EX 1: SELECT PARA CONSULTAR TODAS AS COLUNAS
SELECT * FROM cliente;

-- EX 2: CONSULTANDO POR COLUNAS 
SELECT nome, email FROM cliente;

-- EX 3: INSERINDO APELIDO NAS COLUNAS -- ALIAS
SELECT nome AS Cliente
FROM cliente

SELECT nome AS Cliente, telefone AS Contato, ativo AS STATUS
FROM cliente;

SELECT nome, preco, preco*0.90 AS Preço_Promocional
FROM produto;

-- EX 4: DISTINCT - ELIMINAR REPETIÇÕES
SELECT cidade FROM cliente;

SELECT DISTINCT cidade AS Cidade
FROM cliente;
-- SEM DISTINCT O ITEM IRÁ APARECER VÁRIAS VEZES
-- COM DISTINCT O ITEM IRÁ APARECER UMA VEZ

-- EX 5: FILTRO EM REGISTROS
SELECT nome, preco 
FROM produto
WHERE preco > 10
-- RETORNA VALORES ACIMA DE 10 REAIS EM SEUS PREÇOS

SELECT nome, preco
FROM produto
WHERE ativo = TRUE
-- retorna produtos ativos

SELECT id_pedido, data_pedido, valor_total
FROM pedido
WHERE valor_total >= 25.00;
-- retorna pedidos acima de determinado valor 

-- operadores de comparação
-- = igual
-- <> ou != diferente
-- > maior que
-- >= maior ou igual 
-- < menor que 
-- <= menor ou igual

-- EX 6: USO DE AND, OR E NOT
-- AND - TODAS AS CONDIÇÕES PRECISAM SER VERDADEIRAS
SELECT nome, preco 
FROM produto
WHERE preco >= 8.00 AND preco <= 20.00;

-- OR - PELO MENOS UMA CONDIÇÃO VERDADEIRA
SELECT nome, cidade
FROM cliente
WHERE cidade = 'Limeira' OR cidade = 'Piracicaba';

-- NOT - NEGAR NÃO TRAZER RESULTADO QUE FOI APRESENTADO
SELECT nome, cidade
FROM cliente
WHERE NOT cidade = 'Limeira';

-- JUNTOS - AND E OR
SELECT nome, cidade, ativo AS Status 
FROM cliente
WHERE ativo = TRUE
AND (cidade = 'Limeira' OR cidade = 'Americana')


-- EX 7: PESQUISANDO POR INTERVALOS - BETWEEN
SELECT nome, preco
FROM produto
WHERE preco BETWEEN 8.00 AND 15.00;

SELECT id_pedido, data_pedido, valor_total
FROM pedido
WHERE data_pedido BETWEEN '2026-09-01 00:00:00' AND '2026-09-30 23:59:59';

-- EX 8: IN COM VÁRIAS POSSIBILIDADES
SELECT nome, cidade
FROM cliente
WHERE cidade IN ('Limeira', 'Americana', 'Piracicaba');

SELECT nome, cidade
FROM cliente
WHERE cidade NOT IN ('Limeira', 'Campinas');


-- EX 9: EXEMPLO COM TEXTO OU PESQUISAR POR TEXTOS - LIKE
-- CORINGAS
-- % VÁRIOS CARACTERES
-- _ EXATAMENTE UM CARACTER

SELECT nome
FROM produto
WHERE nome LIKE 'Café%'
-- RETORNAR PRODUTOS QUE POSSUEM A PALAVRA CAFÉ E QUE COMEÇAM COM ELA

SELECT nome
FROM produto
WHERE nome LIKE '%chocolate%';
-- RETORNAR PRODUTOS QUE POSSUEM A PALAVRA CHOCOLATE

SELECT nome
FROM produto
WHERE nome LIKE '%Silva';
-- RETORNAR NOMES QUE TERMINAM COM SILVA

SELECT nome 
FROM produto
WHERE nome LIKE '_afé%';

-- EX 10: NULL - AUSÊNCIA DE VALOR
SELECT nome, telefone
FROM cliente
WHERE telefone IS NULL;

SELECT nome, telefone
FROM cliente
WHERE telefone IS NOT NULL;

-- EX 11: ORDER BY - ORDENAR RESULTADOS
-- ASC SIGNIFICA CRESCENTE 
-- DESC SIGNIFICA DESCRESCENTE

SELECT nome, preco 
FROM produto
ORDER BY preco ASC;

SELECT nome, preco
FROM produto 
ORDER BY preco DESC;

SELECT cidade, nome
FROM cliente
ORDER BY cidade ASC, nome ASC;


-- EX 12: LIMIT - LIMITANDO A QUANTIDADE DE LINHA 
SELECT nome, preco
FROM produto
ORDER BY preco DESC
LIMIT 8;

SELECT nome, preco
FROM produto
ORDER BY nome
LIMIT 5 OFFSET 5;

-- EX 13: CÁLCULO DE COLUNAS
SELECT nome, preco 
FROM produto

SELECT id_item, quantidade, preco_unitario, quantidade * preco_unitario AS Total_Compra
FROM item_pedido;

-- EX 14: FUNÇÕES PARA CONSULTA
-- TEXTOS
SELECT UPPER(nome) AS Nome_Cliente, LOWER(email) AS Email
FROM cliente;

SELECT CONCAT(nome, ' - ', cidade) AS Cliente_Cidade
FROM cliente;

-- NÚMEROS
SELECT nome, preco, ROUND(preco* 0.90, 2) AS Preço_Desconto
FROM produto;

-- DATAS
SELECT id_pedido, data_pedido, DATE(data_pedido) AS DATAS, DAY (data_pedido) AS DIA, MONTH(data_pedido) AS MÊS, YEAR(data_pedido) AS ANO
FROM pedido

-- SUBSTITUINDO O NULL NO RESULTADO
SELECT nome, COALESCE(telefone, 'Não Informado') AS Contato
FROM cliente;

-- EX 15: FUNÇÕES DE AGREGAÇÃO - SUM, AVG, MIN, MAX, COUNT
-- COUNT - CONTAR QUANTIDADE DE REGISTROS
-- SUM - SOMA DE VALORES
-- AVG - MÉDIA DE VALORES
-- MIN - MENOR VALOR
-- MAX - MAIOR VALOR

SELECT COUNT(*) AS Total_Clientes
FROM cliente;
-- RESULTADO DE QUANTIDADE DE CLIENTES

SELECT AVG(preco) AS Média_Preços
FROM produto;
-- MÉDIA DO VALOR DOS PRODUTOS

SELECT MIN(preco) AS PROMOÇÃO, MAX(preco) AS REAJUSTE, AVG(preco) AS MÉDIA_PREÇOS
FROM produto;
-- RESUMO DE PREÇOS

SELECT SUM(valor_total) AS FATURAMENTO_MENSAL
FROM pedido
WHERE status = 'ABERTO'
-- TOTAL DE PEDIDOS FINALIZADOS


-- EX 16: GROUP BY - AGRUPAR DADOS
SELECT cidade, COUNT(*) AS QTDE_CIDADES
FROM cliente
GROUP BY cidade;
-- CONSULTA POR GRUPOS DE CIDADE

SELECT id_categoria, COUNT(*) AS QTDE_PRODUTOS
FROM produto
GROUP BY id_categoria;
-- QUANTIDADE DE PRODUTOS POR CATEGORIA


-- EX 17: HAVING - FILTRO POR GRUPOS
SELECT cidade, COUNT(*) AS QUANTIDADE_CLIENTES
FROM cliente
GROUP BY cidade
HAVING COUNT (*) >= 2;
-- DICA USAR O HAVING E NÃO ESQUECER O GROUP BY

---------------------------------------------------------------------------------
-- EX 18: CONSULTA COMPLETA
SELECT colunas
FROM tabela
WHERE condicao
GROUP BY colunas_agrupar
HAVING condicao
ORDER BY colunas
LIMIT quantidade;
-- dica para seguir em ordem lógica para uma consulta parcial ou completa
---------------------------------------------------------------------------------

SELECT COUNT(nome) AS Total_produtos
FROM produto;

--- PARTE II - RELACIONAMENTOS ENTRE TABELAS - JOINS - JUNÇÃO DE TABELAS

--EX 19: PEDIDOS COM O NOME DO CLIENTE
--INNER JOIN - RETORNA PEGISTROS QUE POSSUEM CORRESPONDÊNCIAS ENTRE TABELAS 
SELECT P.id_pedido, P.data_pedido, C.nome AS cliente, P.valor_total
FROM pedido AS P
INNER JOIN cliente AS C 
ON C.id_cliente = P.id_cliente
-- OBS: RELACIONE O CLIENTE CUJO ID_CLIENTE É IGUAL AP ID_CLIENTE GRAVADO NO PEDIDO
-- P E C SÃO APELIDOS OU ALIASES PARA DEIXAR MAIS CURTAS E LEGÍVEIS 
-- LEFT JOIN -- MANTÉM TODOS OS REGISTROS DA TABELA DA ESQUERDA MESMO QUANDO NÃO POSSUI CORRESPONDÊNCIA NA TABELA DIREITA 

-- EX 20: TODOS OS CLIENTES, INCLUSIVE QUEM NUNCA COMPROU OU QUEM NUNCA REALIZOU PEDIDO
SELECT C.nome, P.id_pedido, P.data_pedido
FROM cliente AS C
LEFT JOIN pedido AS P
ON P.id_cliente = C.id_cliente
ORDER BY C.nome;

-- EX 21: CLIENTES SEM PEDIDOS
SELECT C.id_cliente, C.nome
FROM cliente AS C
LEFT JOIN pedido AS P
ON P.id_cliente = C.id_cliente
WHERE P.id_pedido IS NULL;

-- JOIN COM TRÊS TABELAS
-- EX 22: ITENS DE PEDIDO COM NOME DO PRODUTO
SELECT P.id_pedido, PR.nome AS produto, IP.quantidade, IP.preco_unitario, IP.quantidade * IP.preco_unitario AS subtotal
FROM pedido AS P
INNER JOIN item_pedido AS IP
ON IP.id_pedido = P.id_pedido
INNER JOIN produto AS PR
ON PR.id_produto = IP.id_produto
ORDER BY P.id_pedido;

-- EX 23: AGREGAÇÃP + JOINS
-- QUANTIDADE DE PRODUTOS POR CATEGORIA
SELECT CA.nome AS categoria, COUNT (PR.id_produto) AS qtde_produtos
FROM categoria AS CA
LEFT JOIN produto AS PR
ON PR.id_categoria = CA.id_categoria
GROUP BY CA.id_categoria, CA.nome
ORDER BY qtde_produtos DESC;

-- EX 24: TOTAL COMPRADO POR CLIENTE
SELECT C.nome AS cliente, COUNT (P.id_pedido) AS qtde_pedidos, SUM(P.valor_total) AS total_comprado
FROM cliente AS C
INNER JOIN pedido AS P
ON P.id_cliente = C.id_cliente
 WHERE P.status = "Finalizado"
 GROUP BY C.id_cliente, C.nome
 ORDER BY total_comprado DESC;

 -- RELATÓRIO COMPLETO DO PEDIDO
 -- EX 25: COMBINAR VÁRIAS TABELAS EM UMA CONSULTA
 SELECT P.id_pedido, DATE_FORMAT (P.data_pedido, '%d %m %Y %H:%i') AS DATA, C.nome AS cliente, PR.nome AS produto, IP.quantidade, IP.preco_unitario, IP. quantidade * IP.preco_unitario AS SUBTOTAL
 FROM pedido AS P
 INNER JOIN cliente AS C
 ON C.id_cliente = P.id_cliente
 INNER JOIN item_pedido AS IP
 ON P.id_pedido = P.id_pedido
 INNER JOIN produto AS PR
 ON PR.id_produto = IP.id_produto
 ORDER BY P.id_pedido, PR.nome;
-- OBS: PADRÃO DE FORMATAÇÃO DE DATA NO BRASIL
-- DATE_FORMAT (P.data_pedido, '%d %m %Y %H:%i')

-- CRIANDO CLASSIFICAÇÕES
-- EX 26: - CASE - PERMITE CONSTRUIR UMA CLASSIFICAÇÃO BASEADA EM REGRAS 
select nome,preco,
CASE 
    WHEN preco < 8.00 THEN 'Econômico'
    WHEN preco <= 15.00 THEN 'Intermediário'  
    ELSE  'Premium'
END AS classificação
FROM produto
ORDER BY preco;


-- SUBCONSULTA 
-- É UMA CONSULTA DENTRO DE OUTRA CONSULTA
-- EX 27: PRODUTOS ACIMA DO PREÇO MÉDIO 
SELECT nome, preco
FROM produto
WHERE preco > (SELECT AVG(preco)
FROM produto
)
ORDER BY preco DESC;

-- DEMONSTRAÇÃO COMPLETA E FINAL
-- PASSO 1 - VISUALIZAR PRODUTOS
SELECT * FROM produto;
-- PASSO 2: SELECIONAR SOMENTE O NECESSÁRIO 
SELECT nome, preco FROM produto;
-- PASSO 3 - FILTRO
SELECT nome, preco FROM produto
WHERE preco >= 10;
-- PASSO 4 - ORDENAR INFORMAÇÕES
SELECT nome, preco FROM produto
WHERE preco >= 10.00
ORDER BY preco DESC;
-- PASSO 5 - MOSTRAR CATEGORIA
SELECT PR.nome AS produto, CA.nome AS categoria, PR.preco
FROM produto AS PR
INNER JOIN categoria AS CA 
ON CA.id_categoria = PR.id_categoria
WHERE PR.preco >= 10.00
ORDER BY PR.preco DESC;
-- PASSO 6 - PERGUNTA GERENCIAL
SELECT CA.nome AS categoria, COUNT(PR.id_produto) AS produtos, ROUND (AVG(PR.preco),2) AS preco_medio
FROM categoria AS CA
INNER JOIN produto AS PR
ON PR.id_categoria = CA.id_categoria
GROUP BY CA.id_categoria, CA.nome
ORDER BY preco_medio DESC