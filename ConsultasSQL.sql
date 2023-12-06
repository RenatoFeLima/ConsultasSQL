USE sucos_vendas;

SELECT * FROM tabela_de_produtos WHERE CODIGO_DO_PRODUTO = '1000889';

------------------------COMANDO LIKE SERVE PARA FILTRAR RESULTADOS CONTENDO O VALOR PASSADO NO PARAMETRO--------------------------
select * from tabela_de_produtos WHERE SABOR LIKE '%Maça%' 
AND EMBALAGEM = 'PET';

SELECT * FROM tabela_de_clientes WHERE NOME LIKE '%Mattos'
---------------------------------------------------------------------------------------------------------------------------------------
SELECT EMBALAGEM, TAMANHO from tabela_de_produtos;

------------------ESSA LINHA RETORNARÁ O RESULTADO SEM DADOS REPETIDOS-------------------------------------
SELECT distinct EMBALAGEM, TAMANHO from tabela_de_produtos;

SELECT DISTINCT BAIRRO FROM tabela_de_clientes WHERE CIDADE = 'Rio de Janeiro';
----------------------------------------------------------------------------------------------------------------------

SELECT * FROM tabela_de_produtos LIMIT 3,2;

----------------Quais foram os clientes que fizeram mais de 2000 compras em 2016?--------------------------
  SELECT CPF, COUNT(*) FROM notas_fiscais  
  WHERE YEAR(DATA_VENDA) = 2016
  GROUP BY CPF
  HAVING COUNT(*) > 2000
  -------------------------------------------------------------------------------------------------------------------
  
  -----------------------COMANDO CASE, QUE FUNCIONA COMO UM CONDICIONAL IF ELSE EM LINGUAGENS CONVENCIONAIS---------------------------
  
  SELECT NOME_DO_PRODUTO, PRECO_DE_LISTA,
	CASE 
		WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
		WHEN PRECO_DE_LISTA >= 7 AND PRECO_DE_LISTA <12 THEN 'PRODUTO EM CONTA'
		ELSE 'PRODUTO BARATO' 
	END AS STATUS_PRECO 
    FROM tabela_de_produtos;
  ----------------------------------------------------------------------------------
	 SELECT EMBALAGEM,
	CASE 
		WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
		WHEN PRECO_DE_LISTA >= 7 AND PRECO_DE_LISTA < 12 THEN 'PRODUTO EM CONTA'
		ELSE 'PRODUTO BARATO' 
	END AS STATUS_PRECO, AVG(PRECO_DE_LISTA) AS PRECO_MEDIO
	FROM tabela_de_produtos
    WHERE SABOR = 'MANGA'
	GROUP BY EMBALAGEM, 
	CASE 
		WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
		WHEN PRECO_DE_LISTA >= 7 AND PRECO_DE_LISTA < 12 THEN 'PRODUTO EM CONTA'
		ELSE 'PRODUTO BARATO' 
	END
    ORDER BY EMBALAGEM;
    
   
	SELECT NOME,
		CASE
			WHEN YEAR(data_de_nascimento) < 1990 THEN 'Velho'
			WHEN YEAR(data_de_nascimento) >= 1990 AND
			YEAR(data_de_nascimento) <= 1995 THEN 'Jovens' 
		ELSE 'Crianças' 
	END  AS "CLASSIFICAÇÃO POR IDADE"
	FROM tabela_de_clientes
    ORDER BY NOME;
    -------------------------------------------------------------------------------------------------------------------------------------
    
    -------------------------------------------------------------------------------------------------------------------------------------
    ---------------seleciona apenas as colunas embalagem e tamanho da tabela de produtos------------
    SELECT EMBALAGEM, TAMANHO FROM tabela_de_produtos;
    
    ---------------seleciona as mesmas colunas, porem, sem repetir os dados como na consulta anterior----------------
    SELECT DISTINCT EMBALAGEM, TAMANHO FROM tabela_de_produtos;
    
    ---------seleciona as mesmas colunas, porem, sem repetir os dados como na consulta anterior e filtrando apenas o sabor laranja----------------
    SELECT DISTINCT EMBALAGEM, TAMANHO FROM tabela_de_produtos
    WHERE SABOR = 'LARANJA';
	
    ---------seleciona as mesmas colunas, porem, sem repetir os dados como na consulta anterior e filtrando apenas o sabor laranja----------------
    SELECT DISTINCT EMBALAGEM, TAMANHO, SABOR FROM tabela_de_produtos;
    
    -------------Podemos limitar o número de linhas exibidas na saída.-----------------
    SELECT * FROM tabela_de_produtos LIMIT 5;
    
	-------------Podemos exibir os registros dentro de um intervalo de linhas..-----------------
	SELECT * FROM tabela_de_produtos LIMIT 2,3;
    
    --------------As saídas de uma comando SELECT podem ser apresentadas de forma ordenada-----------------
    SELECT * FROM tabela_de_produtos ORDER BY PRECO_DE_LISTA;
    SELECT * FROM tabela_de_produtos ORDER BY PRECO_DE_LISTA DESC;  ---DECRESCENTE
    SELECT * FROM tabela_de_produtos ORDER BY PRECO_DE_LISTA ASC;	---CRESCENTE
    
    ----Os valores podem vir ordenados alfabeticamente quando incluímos um campo texto no critério de ordenação-------------
    SELECT * FROM tabela_de_produtos ORDER BY NOME_DO_PRODUTO;
    SELECT * FROM tabela_de_produtos ORDER BY NOME_DO_PRODUTO DESC;	---DECRESCENTE
    SELECT * FROM tabela_de_produtos ORDER BY NOME_DO_PRODUTO ASC;	---CRESCENTE
    
    ---------------A ordenação em SQL pode variar para diferentes campos, conforme mostrado no exemplo--------------------
    SELECT * FROM tabela_de_produtos ORDER BY EMBALAGEM DESC, NOME_DO_PRODUTO ASC;
    
	-------------Os dados podem ser agrupados. 
				 Quando isso acontece, temos que aplicar um critério de agrupamento para os campos numéricos. 
				 Podemos usar SUM, AVG, MAX, MIN, e outros mais-----------------------------------------------
    
    SELECT ESTADO, LIMITE_DE_CREDITO FROM tabela_de_clientes; 
    SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS LIMITE_TOTAL FROM tabela_de_clientes GROUP BY ESTADO;
    
    ---------------Podemos usar outros critérios como o valor máximo----------------------
    SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO FROM tabela_de_Produtos GROUP BY EMBALAGEM;
    
    -----------------O comando COUNT conta o número de ocorrências na tabela---------------------
    SELECT EMBALAGEM, COUNT(*) AS CONTADOR FROM tabela_de_produtos GROUP BY EMBALAGEM;
    
    ------------O filtro pode ser aplicado sobre o agrupamento, como uma consulta qualquer-------------
    SELECT BAIRRO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabela_de_clientes
	WHERE CIDADE = 'Rio de Janeiro' GROUP BY BAIRRO;
    
    ------------Além disso, o agrupamento também pode ser feito por mais de um campo------------
    SELECT ESTADO, BAIRRO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabela_de_clientes
   	GROUP BY ESTADO, BAIRRO;
    
    -----------------Podemos mesclar agrupamento com ordenação.---------------------
    SELECT ESTADO, BAIRRO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabela_de_clientes
	WHERE CIDADE = 'Rio de Janeiro'
	GROUP BY ESTADO, BAIRRO
	ORDER BY BAIRRO;
    
				Veja a consulta abaixo:
	SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS SOMA_LIMITE FROM tabela_de_clientes
	GROUP BY ESTADO;  

--------------Queremos aplicar um filtro sobre o resultado desta consulta. Logo digite--------------------
SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS SOMA_LIMITE FROM tabela_de_clientes
WHERE SOMA_LIMITE > 900000
GROUP BY ESTADO;       

Veja que a consulta acima vai ocasionar um erro.

Usamos o HAVING para filtrar a saída de uma consulta usando como critério o valor agrupado.

SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS SOMA_LIMITE FROM tabela_de_clientes
GROUP BY ESTADO HAVING SUM(LIMITE_DE_CREDITO) > 900000;    

O critério usado no HAVING não precisa ser o mesmo usado no filtro. Veja o comando abaixo:

SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO,
MIN(PRECO_DE_LISTA) AS MENOR_PRECO FROM tabela_de_produtos
GROUP BY EMBALAGEM; 

Porém, na consulta abaixo, o critério do HAVING pede a soma. Digite:

SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO,
MIN(PRECO_DE_LISTA) AS MENOR_PRECO FROM tabela_de_produtos
GROUP BY EMBALAGEM HAVING SUM(PRECO_DE_LISTA) <= 80;

No HAVING podemos usar mais de um critério usando AND ou OR.

SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO,
MIN(PRECO_DE_LISTA) AS MENOR_PRECO FROM tabela_de_produtos
GROUP BY EMBALAGEM HAVING SUM(PRECO_DE_LISTA) <= 80 AND MAX(PRECO_DE_LISTA) >= 5;

-------------------------------------------------------------------------------------------------------------

O comando CASE permite que possa ser classificado cada registro da tabela. Digite o comando abaixo:

SELECT NOME_DO_PRODUTO, PRECO_DE_LISTA,
CASE
   WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
   WHEN PRECO_DE_LISTA >= 7 AND PRECO_DE_LISTA < 12 THEN 'PRODUTO EM CONTA'
   ELSE 'PRODUTO BARATO'
END AS STATUS_PRECO
FROM tabela_de_produtos;

Podemos usar o CASE como critério de agrupamento, Digite o comando abaixo

	SELECT EMBALAGEM,
	CASE
	   WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
	   WHEN PRECO_DE_LISTA >= 7 AND PRECO_DE_LISTA < 12 THEN 'PRODUTO EM CONTA'
	   ELSE 'PRODUTO BARATO'
	END AS STATUS_PRECO, AVG(PRECO_DE_LISTA) AS PRECO_MEDIO
	FROM tabela_de_produtos
	WHERE sabor = 'Manga'
	GROUP BY EMBALAGEM,
	CASE
	   WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
	   WHEN PRECO_DE_LISTA >= 7 AND PRECO_DE_LISTA < 12 THEN 'PRODUTO EM CONTA'
	   ELSE 'PRODUTO BARATO'
	END
	ORDER BY EMBALAGEM;
    