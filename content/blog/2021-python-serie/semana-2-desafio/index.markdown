---
title: "Estudando Python - Semana 2, Desafio"
excerpt: "Este posts é uma forma de documentar alguns aprendizados na minha trajetória estudando Python. Estou fazendo o curso de [Python para inovação cívica](https://escoladedados.org/courses/python-para-inovacao-civica/), oferecido pela [Escola de Dados](https://escoladedados.org/). Imagem de [Towards Data Science](https://towardsdatascience.com/tidying-up-pandas-4572bfa38776)."
draft: true
author: "Beatriz Milz"
date: '2021-08-29'
categories: ["Portugues", "Python", "Estudo", "Reticulate"]
---




# Limpeza de dados e estatística descritiva

Neste desafio, iremos revisar alguns conceitos vistos nas aulas e ver algumas novidades. Os dados originais são do [repositório de dados eleitorais do Tribunal Superior Eleitoral](https://www.tse.jus.br/eleicoes/estatisticas/repositorio-de-dados-eleitorais-1). 

O CSV disponibilizado é formado pela conjunção de algumas tabelas do arquivo [orgao_partidario.zip](https://cdn.tse.jus.br/estatistica/sead/odsele/orgao_partidario/orgao_partidario.zip), localizado no menu Partidos > Órgão Partidário.

Preencha as lacunas abaixo para completar o desafio.

# Importe os pacotes necessários


```python
import pandas as pd
import numpy as np
```

# Leia o arquivo "receitas_orgaos_partidarios_2020_NORDESTE.csv" usando o Pandas

Na aula `1.10 - Outliers e valores faltantes`, vimos como utilizar o método `replace` para substituir valores em certos colunas do nosso dataframe e trocar o texto (string) `#NULO#` pela representação padrão do Pandas para valores nulos.

Aqui, vamos utilizar um outro método, onde definimos quais strings serão considerados valores nulos já na importação do arquivo.

Edite as células abaixo e inclua:

* O nome do arquivo que queremos importar
* O separador utilizado
* Insira uma lista no parâmetro `na_values` que contenha o texto a ser ignorado.

Experimente rodar os comandos primeiro sem e depois com o parâmetro `na_values`, então, compare a diferença. Observe, por exemplo, o campo `CD_CNAE_DOADOR`.


```python
df = pd.read_csv('receitas_orgaos_partidarios_2020_NORDESTE.csv',sep=';')

df.info()
```

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 12874 entries, 0 to 12873
Data columns (total 48 columns):
 #   Column                       Non-Null Count  Dtype 
---  ------                       --------------  ----- 
 0   DT_GERACAO                   12874 non-null  object
 1   HH_GERACAO                   12874 non-null  object
 2   ANO_ELEICAO                  12874 non-null  int64 
 3   CD_TIPO_ELEICAO              12874 non-null  int64 
 4   NM_TIPO_ELEICAO              12874 non-null  object
 5   TP_PRESTACAO_CONTAS          12874 non-null  object
 6   DT_PRESTACAO_CONTAS          12874 non-null  object
 7   SQ_PRESTADOR_CONTAS          12874 non-null  int64 
 8   CD_ESFERA_PARTIDARIA         12874 non-null  object
 9   DS_ESFERA_PARTIDARIA         12874 non-null  object
 10  SG_UF                        12874 non-null  object
 11  CD_MUNICIPIO                 12874 non-null  int64 
 12  NM_MUNICIPIO                 12874 non-null  object
 13  NR_CNPJ_PRESTADOR_CONTA      12874 non-null  int64 
 14  NR_PARTIDO                   12874 non-null  int64 
 15  SG_PARTIDO                   12874 non-null  object
 16  NM_PARTIDO                   12874 non-null  object
 17  CD_FONTE_RECEITA             12874 non-null  int64 
 18  DS_FONTE_RECEITA             12874 non-null  object
 19  CD_ORIGEM_RECEITA            12874 non-null  int64 
 20  DS_ORIGEM_RECEITA            12874 non-null  object
 21  CD_NATUREZA_RECEITA          12874 non-null  int64 
 22  DS_NATUREZA_RECEITA          12874 non-null  object
 23  CD_ESPECIE_RECEITA           12874 non-null  int64 
 24  DS_ESPECIE_RECEITA           12874 non-null  object
 25  CD_CNAE_DOADOR               12874 non-null  int64 
 26  DS_CNAE_DOADOR               12874 non-null  object
 27  NR_CPF_CNPJ_DOADOR           12874 non-null  int64 
 28  NM_DOADOR                    12874 non-null  object
 29  NM_DOADOR_RFB                12874 non-null  object
 30  CD_ESFERA_PARTIDARIA_DOADOR  12874 non-null  object
 31  DS_ESFERA_PARTIDARIA_DOADOR  12874 non-null  object
 32  SG_UF_DOADOR                 12874 non-null  object
 33  CD_MUNICIPIO_DOADOR          12874 non-null  int64 
 34  NM_MUNICIPIO_DOADOR          12874 non-null  object
 35  SQ_CANDIDATO_DOADOR          12874 non-null  int64 
 36  NR_CANDIDATO_DOADOR          12874 non-null  int64 
 37  CD_CARGO_CANDIDATO_DOADOR    12874 non-null  int64 
 38  DS_CARGO_CANDIDATO_DOADOR    12874 non-null  object
 39  NR_PARTIDO_DOADOR            12874 non-null  int64 
 40  SG_PARTIDO_DOADOR            12874 non-null  object
 41  NM_PARTIDO_DOADOR            12874 non-null  object
 42  NR_RECIBO_DOACAO             12874 non-null  object
 43  NR_DOCUMENTO_DOACAO          12874 non-null  object
 44  SQ_RECEITA                   12874 non-null  int64 
 45  DT_RECEITA                   12874 non-null  object
 46  DS_RECEITA                   12874 non-null  object
 47  VR_RECEITA                   12874 non-null  int64 
dtypes: int64(19), object(29)
memory usage: 4.7+ MB
```


```python
df = pd.read_csv('receitas_orgaos_partidarios_2020_NORDESTE.csv', sep=';', na_values='#NULO#')

df.info()
```

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 12874 entries, 0 to 12873
Data columns (total 48 columns):
 #   Column                       Non-Null Count  Dtype 
---  ------                       --------------  ----- 
 0   DT_GERACAO                   12874 non-null  object
 1   HH_GERACAO                   12874 non-null  object
 2   ANO_ELEICAO                  12874 non-null  int64 
 3   CD_TIPO_ELEICAO              12874 non-null  int64 
 4   NM_TIPO_ELEICAO              12874 non-null  object
 5   TP_PRESTACAO_CONTAS          12874 non-null  object
 6   DT_PRESTACAO_CONTAS          12874 non-null  object
 7   SQ_PRESTADOR_CONTAS          12874 non-null  int64 
 8   CD_ESFERA_PARTIDARIA         12874 non-null  object
 9   DS_ESFERA_PARTIDARIA         12874 non-null  object
 10  SG_UF                        12874 non-null  object
 11  CD_MUNICIPIO                 12874 non-null  int64 
 12  NM_MUNICIPIO                 11606 non-null  object
 13  NR_CNPJ_PRESTADOR_CONTA      12874 non-null  int64 
 14  NR_PARTIDO                   12874 non-null  int64 
 15  SG_PARTIDO                   12874 non-null  object
 16  NM_PARTIDO                   12874 non-null  object
 17  CD_FONTE_RECEITA             12874 non-null  int64 
 18  DS_FONTE_RECEITA             12874 non-null  object
 19  CD_ORIGEM_RECEITA            12874 non-null  int64 
 20  DS_ORIGEM_RECEITA            12874 non-null  object
 21  CD_NATUREZA_RECEITA          12874 non-null  int64 
 22  DS_NATUREZA_RECEITA          12874 non-null  object
 23  CD_ESPECIE_RECEITA           12874 non-null  int64 
 24  DS_ESPECIE_RECEITA           12874 non-null  object
 25  CD_CNAE_DOADOR               12874 non-null  int64 
 26  DS_CNAE_DOADOR               5977 non-null   object
 27  NR_CPF_CNPJ_DOADOR           12874 non-null  int64 
 28  NM_DOADOR                    12785 non-null  object
 29  NM_DOADOR_RFB                12784 non-null  object
 30  CD_ESFERA_PARTIDARIA_DOADOR  3233 non-null   object
 31  DS_ESFERA_PARTIDARIA_DOADOR  3233 non-null   object
 32  SG_UF_DOADOR                 5976 non-null   object
 33  CD_MUNICIPIO_DOADOR          12874 non-null  int64 
 34  NM_MUNICIPIO_DOADOR          3162 non-null   object
 35  SQ_CANDIDATO_DOADOR          12874 non-null  int64 
 36  NR_CANDIDATO_DOADOR          12874 non-null  int64 
 37  CD_CARGO_CANDIDATO_DOADOR    12874 non-null  int64 
 38  DS_CARGO_CANDIDATO_DOADOR    2743 non-null   object
 39  NR_PARTIDO_DOADOR            12874 non-null  int64 
 40  SG_PARTIDO_DOADOR            5976 non-null   object
 41  NM_PARTIDO_DOADOR            5976 non-null   object
 42  NR_RECIBO_DOACAO             10955 non-null  object
 43  NR_DOCUMENTO_DOACAO          9020 non-null   object
 44  SQ_RECEITA                   12874 non-null  int64 
 45  DT_RECEITA                   12874 non-null  object
 46  DS_RECEITA                   3301 non-null   object
 47  VR_RECEITA                   12874 non-null  int64 
dtypes: int64(19), object(29)
memory usage: 4.7+ MB
```

# Filtre apenas os registros que sejam da prestação de contas final


```python
# Primeiro vamos ver os valores únicos da coluna TP_PRESTACAO_CONTAS

df['TP_PRESTACAO_CONTAS'].unique()
```

```
array(['Final', 'Relatório Financeiro', 'Parcial',
       'Regularização da Omissão'], dtype=object)
```


```python
# O resultado deste comando nos diz que quantas linhas e colunas temos antes do filtro
df.shape
```

```
(12874, 48)
```


```python
# Preencha o campo os espaços abaixo com o nome da coluna e o valor desejado para nosso filtro
df_final = df[df['TP_PRESTACAO_CONTAS'] == 'Final'].copy()
```


```python
# Rode o comando shape no novo dataframe criado e confira se o número de linhas foi reduzido
df_final.shape
```

```
(12288, 48)
```

## Qual foi a maior doação de pessoa física e pessoa jurídica em cada estado?

Vamos usar o método `value_counts` para não só listar cada valor único da coluna `CD_CNAE_DOADOR`, como também mostrar quantos registros temos em cada um.


```python
# Preencha o nome da coluna abaixo
df_final['CD_CNAE_DOADOR'].value_counts()
```

```
-1        6509
 94928    5735
 94308      37
 14126       3
 17311       1
 94995       1
 84116       1
 62023       1
Name: CD_CNAE_DOADOR, dtype: int64
```


```python
# Para ver os resultados em percentuais é fácil! Basta falarmos para o value_counts que queremos os resultados normalizados
df_final['CD_CNAE_DOADOR'].value_counts(normalize=True)
```

```
-1        0.529704
 94928    0.466715
 94308    0.003011
 14126    0.000244
 17311    0.000081
 94995    0.000081
 84116    0.000081
 62023    0.000081
Name: CD_CNAE_DOADOR, dtype: float64
```

Se o doador for pessoa jurídica, temos seu respectivo código CNAE. Se for pessoa física, então temos o valor `-1`. 

Qual conclusão podemos tirar a respeito dos comandos acima?

Escreva um **comentário** na célula abaixo com a resposta.


```python
# Mais da metade dos registros são de pessoas físicas.
```

Agora, vamos duplicar a coluna `CD_CNAE_DOADOR` e deixar esta nova coluna apenas com 2 categorias: física (representada pelo valor -1) ou jurídica (que vamos representar inicialmente com 1).


```python
# Vamos criar uma nova coluna que seja uma cópia exata da coluna CD_CNAE_DOADOR
df_final['TIPO_DOADOR'] = df_final['CD_CNAE_DOADOR']
```

## Substituição condicional (conditional replacing)

Agora, vamos usar o método where do pacote NumPy (carinhosamente chamado de np abaixo).

Esta função recebe três parâmetros:

* Uma condição: no nosso caso, queremos que filtrar as coluna do CNAE onde os valores sejam -1
* Um valor: caso a condição acima seja verdadeira, qual valor deverá ser retornado?
* Outro valor: se a condição for falsa, então, qual outro valor deverá ser retornado?


```python
df_final['TIPO_DOADOR'] = np.where(df_final['CD_CNAE_DOADOR']== -1, 'fisica', 'juridica')
```

## Agrupando (group by)

Relembrando a pergunta: Qual foi a maior doação de pessoa física e pessoa jurídica em cada estado?


```python
# Preencha abaixo primeiro uma lista com as 3 colunas que precisamos utilizar para responder à pergunta. E depois o nome das 2 colunas que precisamos agrupar.

df_final[['SG_UF', 'TIPO_DOADOR', 'SQ_RECEITA', 'VR_RECEITA']].groupby(by=['SG_UF', 'TIPO_DOADOR']).max()
```

```
                   SQ_RECEITA  VR_RECEITA
SG_UF TIPO_DOADOR                        
AL    fisica         19948275       17665
      juridica       19936556     3900000
BA    fisica         19947578      200000
      juridica       19948219    11900000
CE    fisica         19943761      200000
      juridica       19946695     3900000
MA    fisica         19945291      100000
      juridica       19946062     3900000
PB    fisica         19930936       23000
      juridica       19942594     2169395
PE    fisica         19945629      150000
      juridica       19943769     4998000
PI    fisica         19944135       23708
      juridica       19946594     3900000
RN    fisica         19945017       25000
      juridica       19946285     3900000
SE    fisica         19936774       31000
      juridica       19948424     4000000
```


```python
# Para repetir o valor da coluna TIPO_DOADOR nas linhas, coloque o parâmetro as_index=False no método groupby do comando acima
df_final[['SG_UF', 'TIPO_DOADOR', 'SQ_RECEITA', 'VR_RECEITA']].groupby(by=['SG_UF', 'TIPO_DOADOR'], as_index=False).max()
```

```
   SG_UF TIPO_DOADOR  SQ_RECEITA  VR_RECEITA
0     AL      fisica    19948275       17665
1     AL    juridica    19936556     3900000
2     BA      fisica    19947578      200000
3     BA    juridica    19948219    11900000
4     CE      fisica    19943761      200000
5     CE    juridica    19946695     3900000
6     MA      fisica    19945291      100000
7     MA    juridica    19946062     3900000
8     PB      fisica    19930936       23000
9     PB    juridica    19942594     2169395
10    PE      fisica    19945629      150000
11    PE    juridica    19943769     4998000
12    PI      fisica    19944135       23708
13    PI    juridica    19946594     3900000
14    RN      fisica    19945017       25000
15    RN    juridica    19946285     3900000
16    SE      fisica    19936774       31000
17    SE    juridica    19948424     4000000
```

## Qual o total de doações recebidas por partido?


```python
df_final[['VR_RECEITA', 'SG_PARTIDO']].groupby(by='SG_PARTIDO').sum().sort_values(by = 'VR_RECEITA', ascending = False)
```

```
               VR_RECEITA
SG_PARTIDO               
PSD              55485632
PP               50241447
PT               43423701
MDB              39185338
PSB              38124175
PSL              32500228
PODE             15425546
PTB              13536876
PDT              13420365
SOLIDARIEDADE    13144797
REPUBLICANOS     13015752
PSOL             10307063
PROS              9186878
PV                6677278
CIDADANIA         5433420
REDE              4790577
PSDB              3410914
DEM               2521140
PC do B           2393497
PL                1620905
AVANTE            1555473
DC                1415608
PTC               1307068
PATRIOTA           946022
PSC                294951
UP                 281887
PCB                146072
NOVO               138588
PRTB                94798
PMN                 93731
PMB                 65117
PSTU                 4200
```

## Qual é o top 10?

Crie um novo dataframe com os 10 partidos com mais doações. Você precisa primeiro ordenar os resultados e depois selecionar apenas os 10 primeiros.



```python
df_final[['VR_RECEITA', 'SG_PARTIDO']].groupby(by='SG_PARTIDO').sum().sort_values(by='VR_RECEITA',ascending=False).head(10)
```

```
               VR_RECEITA
SG_PARTIDO               
PSD              55485632
PP               50241447
PT               43423701
MDB              39185338
PSB              38124175
PSL              32500228
PODE             15425546
PTB              13536876
PDT              13420365
SOLIDARIEDADE    13144797
```

# Vamos visualizar os resultados?
Na aula, nós vimos como usar o matplotlib para gerar gráficos. Agora, vamos descobrir uma nova forma de fazer o mesmo usando um método nativo Pandas. Experimente colocar `.plot(kind='barh')` após a consulta ou dataframe anterior.

Com este comando, podemos produzir um gráfico (plot) do tipo (kind) de barras horizontais (barh).


```python
df_final[['VR_RECEITA', 'SG_PARTIDO']].groupby(by='SG_PARTIDO').sum().sort_values(by='VR_RECEITA',ascending=False).head(10).plot(kind='barh')
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-17-1.png" width="672" style="display: block; margin: auto;" />

## Qual o valor médio das doações por tipo de doador?

Agora é sua vez! A partir dos comandos anteriores, faça uma nova consulta para descobrir a mediana de acordo com o tipo de doador.


```python
df_final[['TIPO_DOADOR', 'VR_RECEITA']].groupby(by=['TIPO_DOADOR'], as_index=False).median()
```

```
  TIPO_DOADOR  VR_RECEITA
0      fisica         600
1    juridica        1500
```
