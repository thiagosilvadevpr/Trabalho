SELECT
    MOV.CODIGO,
    MOV.IDMOV,
    MOV.DATAEMISSAO,
    MOV.CODCLIFORN,

	UPPER(LTRIM(CLI.RAZAO)) + ' / ' + 
        CASE 
            WHEN CLI.PESFISOUJUR LIKE '%FÍSICA%' THEN 
                'CPF: ' + CLI.CGCCFO
		    ELSE 'CNPJ: ' + CLI.CNPJ 
        END AS CLIFORN,

    CAST(CLI.CF_LIM_FAT AS FLOAT) AS LIM_FAT,
    MOV.VALORTOTAL     

FROM MOVIMENTACOES MOV
	INNER JOIN CLIFORN CLI
		ON CLI.CODIGO = MOV.CODCLIFORN

WHERE MOV.CODTIPOMOV IN ('2.2.02', '2.2.40')
AND MOV.STATUS NOT IN (6)
AND CLI.CF_LIM_FAT <> ''