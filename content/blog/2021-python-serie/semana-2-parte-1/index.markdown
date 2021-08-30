---
title: "Estudando Python - Semana 2, Parte 1"
excerpt: "Este posts é uma forma de documentar alguns aprendizados na minha trajetória estudando Python. Estou fazendo o curso de [Python para inovação cívica](https://escoladedados.org/courses/python-para-inovacao-civica/), oferecido pela [Escola de Dados](https://escoladedados.org/). Imagem de [Towards Data Science](https://towardsdatascience.com/tidying-up-pandas-4572bfa38776)."
draft: true
author: "Beatriz Milz"
date: '2021-08-16'
categories: ["Portugues", "Python", "Estudo", "Reticulate"]
---

<script src="{{< blogdown/postref >}}index_files/core-js/shim.min.js"></script>
<script src="{{< blogdown/postref >}}index_files/react/react.min.js"></script>
<script src="{{< blogdown/postref >}}index_files/react/react-dom.min.js"></script>
<script src="{{< blogdown/postref >}}index_files/reactwidget/react-tools.js"></script>
<script src="{{< blogdown/postref >}}index_files/htmlwidgets/htmlwidgets.js"></script>
<script src="{{< blogdown/postref >}}index_files/reactable-binding/reactable.js"></script>

## Introdução

``` r
readr::write_csv2(dados::dados_starwars, "dados/starwars.csv") 
```

``` python
import pandas as pd

starwars = pd.read_csv('dados/starwars.csv', sep = ';', encoding = 'utf-8')

starwars.describe()
```

               altura  filmes  veiculos  naves_espaciais
    count   81.000000     0.0       0.0              0.0
    mean   174.358025     NaN       NaN              NaN
    std     34.770429     NaN       NaN              NaN
    min     66.000000     NaN       NaN              NaN
    25%    167.000000     NaN       NaN              NaN
    50%    180.000000     NaN       NaN              NaN
    75%    191.000000     NaN       NaN              NaN
    max    264.000000     NaN       NaN              NaN

-   Quais colunas temos na base?

``` python
starwars.columns
```

    Index(['nome', 'altura', 'massa', 'cor_do_cabelo', 'cor_da_pele',
           'cor_dos_olhos', 'ano_nascimento', 'sexo_biologico', 'genero',
           'planeta_natal', 'especie', 'filmes', 'veiculos', 'naves_espaciais'],
          dtype='object')

## Filtro

parece muito a sintaxe do R base!

Filtrando apenas linhas em que a espécie seja Humano:

``` python
personagens_humanos = starwars[starwars['especie'] == 'Humano'] 
```

## relatório sobre o dataset

``` python
from pandas_profiling import ProfileReport

profile = ProfileReport(starwars, title='relatorio-starwars')
profile.to_file(output_file = 'relatorio_starwars.html')
```

## medidas de tendencia central

``` python
starwars['altura'].mode()
```

    0    183.0
    dtype: float64

``` python
starwars['altura'].mean()
```

    174.35802469135803

``` python
starwars['altura'].median()
```

    180.0

## medidas de dispersao

``` python
starwars['altura'].var()
```

    1208.9827160493824

``` python
starwars['altura'].std()
```

    34.770428758492216

``` r
library(magrittr)
dados::dados_starwars %>% 
  dplyr::summarise(minimo = min(altura, na.rm = TRUE),
                   maximo = max(altura, na.rm = TRUE),
                   media = mean(altura, na.rm = TRUE),
                   mediana = median(altura, na.rm = TRUE),
                   variancia = var(altura, na.rm = TRUE),
                   desviopadrao = sd(altura, na.rm = TRUE))
```

    # A tibble: 1 × 6
      minimo maximo media mediana variancia desviopadrao
       <int>  <int> <dbl>   <int>     <dbl>        <dbl>
    1     66    264  174.     180     1209.         34.8

## valores faltantes

em R: NA

em python: None

substituir algum valor por NA:

``` python
import pandas as pd
df_candidatos_pe = pd.read_csv('dados/consulta_cand_2020_PE.csv', sep = ';', encoding = 'latin_1')

df_candidatos_pe[df_candidatos_pe['DS_SITUACAO_CANDIDATO_PLEITO'] == '#NULO#']
```

           DT_GERACAO  ... ST_CANDIDATO_INSERIDO_URNA
    4      05/08/2021  ...                        NÃO
    5      05/08/2021  ...                        NÃO
    6      05/08/2021  ...                        NÃO
    94     05/08/2021  ...                        NÃO
    97     05/08/2021  ...                        NÃO
    ...           ...  ...                        ...
    21043  05/08/2021  ...                        NÃO
    21061  05/08/2021  ...                        NÃO
    21081  05/08/2021  ...                        NÃO
    21087  05/08/2021  ...                        NÃO
    21088  05/08/2021  ...                        NÃO

    [670 rows x 63 columns]

``` python
df_candidatos_pe['DS_SITUACAO_CANDIDATO_PLEITO'] = df_candidatos_pe.loc[:, 'DS_SITUACAO_CANDIDATO_PLEITO'].replace({'#NULO#': None})


df_candidatos_pe[df_candidatos_pe['DS_SITUACAO_CANDIDATO_PLEITO'] == '#NULO#']
```

    Empty DataFrame
    Columns: [DT_GERACAO, HH_GERACAO, ANO_ELEICAO, CD_TIPO_ELEICAO, NM_TIPO_ELEICAO, NR_TURNO, CD_ELEICAO, DS_ELEICAO, DT_ELEICAO, TP_ABRANGENCIA, SG_UF, SG_UE, NM_UE, CD_CARGO, DS_CARGO, SQ_CANDIDATO, NR_CANDIDATO, NM_CANDIDATO, NM_URNA_CANDIDATO, NM_SOCIAL_CANDIDATO, NR_CPF_CANDIDATO, NM_EMAIL, CD_SITUACAO_CANDIDATURA, DS_SITUACAO_CANDIDATURA, CD_DETALHE_SITUACAO_CAND, DS_DETALHE_SITUACAO_CAND, TP_AGREMIACAO, NR_PARTIDO, SG_PARTIDO, NM_PARTIDO, SQ_COLIGACAO, NM_COLIGACAO, DS_COMPOSICAO_COLIGACAO, CD_NACIONALIDADE, DS_NACIONALIDADE, SG_UF_NASCIMENTO, CD_MUNICIPIO_NASCIMENTO, NM_MUNICIPIO_NASCIMENTO, DT_NASCIMENTO, NR_IDADE_DATA_POSSE, NR_TITULO_ELEITORAL_CANDIDATO, CD_GENERO, DS_GENERO, CD_GRAU_INSTRUCAO, DS_GRAU_INSTRUCAO, CD_ESTADO_CIVIL, DS_ESTADO_CIVIL, CD_COR_RACA, DS_COR_RACA, CD_OCUPACAO, DS_OCUPACAO, VR_DESPESA_MAX_CAMPANHA, CD_SIT_TOT_TURNO, DS_SIT_TOT_TURNO, ST_REELEICAO, ST_DECLARAR_BENS, NR_PROTOCOLO_CANDIDATURA, NR_PROCESSO, CD_SITUACAO_CANDIDATO_PLEITO, DS_SITUACAO_CANDIDATO_PLEITO, CD_SITUACAO_CANDIDATO_URNA, DS_SITUACAO_CANDIDATO_URNA, ST_CANDIDATO_INSERIDO_URNA]
    Index: []

## correlacao

-   pearson (ou linear) expressa a correlacao linear entre duas variaveis quantitativas

-   matriz de correlacao

-   spearman - expressa a correlacao entre duas variaveis quantitativas, que nao possuam necessariamente a mesma taxa de mudança.
    indica grau de correlacao, mas nao indica que é na mesma taxa

## operacoes basicas com dados

operadores dentro do panda é diferente! muito cuidado aqui.

<div id="htmlwidget-1" class="reactable html-widget" style="width:auto;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-1">{"x":{"tag":{"name":"Reactable","attribs":{"data":{"Descrição":["E","Ou","Negação"],"R":["&","|","!"],"Python":["and","or","not"],"Pandas (Python)":["&","|","~"]},"columns":[{"accessor":"Descrição","name":"Descrição","type":"character"},{"accessor":"R","name":"R","type":"character"},{"accessor":"Python","name":"Python","type":"character"},{"accessor":"Pandas (Python)","name":"Pandas (Python)","type":"character"}],"defaultPageSize":10,"paginationType":"numbers","showPageInfo":true,"minRows":1,"rowStyle":[null,null,{"fontWeight":"bold","background":"rgba(0, 0, 0, 0.03)"}],"dataKey":"513ac4e43818badcc56349e8b4ba5522","key":"513ac4e43818badcc56349e8b4ba5522"},"children":[]},"class":"reactR_markup"},"evals":[],"jsHooks":[]}</script>

-   selecionar uma coluna: dataframe\[‘titulo\_coluna’\]

-   selecionar várias colunas: novo\_df = dataframe\[‘lista\_coluna\_desejadas’\]

-   filtro: selecionar linhas: novo\_df = dataframe\[expressao\_condicional\]

-   selecionar linhas e colunas: novo\_df = dataframe.loc\[expressao\_condicional, ‘lista\_colunas\_desejadas’\]

-   parece R base. mostrar comparando pandas, r base, dplyr

``` python
import pandas as pd
starwars = pd.read_csv('dados/starwars.csv', sep = ';', encoding = 'utf-8')

# selecionar apenas uma coluna
starwars['nome']


# selecionar algumas colunas
```

    0     Luke Skywalker
    1              C-3PO
    2              R2-D2
    3        Darth Vader
    4        Leia Organa
               ...      
    82               Rey
    83       Poe Dameron
    84               BB8
    85    Captain Phasma
    86     Padmé Amidala
    Name: nome, Length: 87, dtype: object

``` python
starwars[['altura', 'massa']]


# filtrar com 1 condicao
```

        altura  massa
    0    172.0   77,0
    1    167.0   75,0
    2     96.0   32,0
    3    202.0  136,0
    4    150.0   49,0
    ..     ...    ...
    82     NaN    NaN
    83     NaN    NaN
    84     NaN    NaN
    85     NaN    NaN
    86   165.0   45,0

    [87 rows x 2 columns]

``` python
starwars[starwars['planeta_natal'] == 'Tatooine']

# filtrar com mais condicoes # AQUI TEM OUTRA DIFERENCA! PRECISAMOS COLOCAR
# PARENTESES!

# E
```

                      nome  altura  massa  ... filmes veiculos naves_espaciais
    0       Luke Skywalker   172.0   77,0  ...    NaN      NaN             NaN
    1                C-3PO   167.0   75,0  ...    NaN      NaN             NaN
    3          Darth Vader   202.0  136,0  ...    NaN      NaN             NaN
    5            Owen Lars   178.0  120,0  ...    NaN      NaN             NaN
    6   Beru Whitesun lars   165.0   75,0  ...    NaN      NaN             NaN
    7                R5-D4    97.0   32,0  ...    NaN      NaN             NaN
    8    Biggs Darklighter   183.0   84,0  ...    NaN      NaN             NaN
    10    Anakin Skywalker   188.0   84,0  ...    NaN      NaN             NaN
    40      Shmi Skywalker   163.0    NaN  ...    NaN      NaN             NaN
    58         Cliegg Lars   183.0    NaN  ...    NaN      NaN             NaN

    [10 rows x 14 columns]

``` python
starwars[(starwars['planeta_natal'] == 'Tatooine') & (starwars['especie'] == 'Humano')]
```

                      nome  altura  massa  ... filmes veiculos naves_espaciais
    0       Luke Skywalker   172.0   77,0  ...    NaN      NaN             NaN
    3          Darth Vader   202.0  136,0  ...    NaN      NaN             NaN
    5            Owen Lars   178.0  120,0  ...    NaN      NaN             NaN
    6   Beru Whitesun lars   165.0   75,0  ...    NaN      NaN             NaN
    8    Biggs Darklighter   183.0   84,0  ...    NaN      NaN             NaN
    10    Anakin Skywalker   188.0   84,0  ...    NaN      NaN             NaN
    40      Shmi Skywalker   163.0    NaN  ...    NaN      NaN             NaN
    58         Cliegg Lars   183.0    NaN  ...    NaN      NaN             NaN

    [8 rows x 14 columns]

``` python
starwars[(starwars['planeta_natal'] == 'Tatooine') & (starwars['especie'] == 'Humano') & (starwars['cor_do_cabelo'] != 'Loiro')]


# OU 
```

                      nome  altura  massa  ... filmes veiculos naves_espaciais
    3          Darth Vader   202.0  136,0  ...    NaN      NaN             NaN
    5            Owen Lars   178.0  120,0  ...    NaN      NaN             NaN
    6   Beru Whitesun lars   165.0   75,0  ...    NaN      NaN             NaN
    8    Biggs Darklighter   183.0   84,0  ...    NaN      NaN             NaN
    40      Shmi Skywalker   163.0    NaN  ...    NaN      NaN             NaN
    58         Cliegg Lars   183.0    NaN  ...    NaN      NaN             NaN

    [6 rows x 14 columns]

``` python
starwars[(starwars['planeta_natal'] == 'Tatooine') | (starwars['especie'] == 'Humano')]



# e o loc?
```

                       nome  altura  massa  ... filmes veiculos naves_espaciais
    0        Luke Skywalker   172.0   77,0  ...    NaN      NaN             NaN
    1                 C-3PO   167.0   75,0  ...    NaN      NaN             NaN
    3           Darth Vader   202.0  136,0  ...    NaN      NaN             NaN
    4           Leia Organa   150.0   49,0  ...    NaN      NaN             NaN
    5             Owen Lars   178.0  120,0  ...    NaN      NaN             NaN
    6    Beru Whitesun lars   165.0   75,0  ...    NaN      NaN             NaN
    7                 R5-D4    97.0   32,0  ...    NaN      NaN             NaN
    8     Biggs Darklighter   183.0   84,0  ...    NaN      NaN             NaN
    9        Obi-Wan Kenobi   182.0   77,0  ...    NaN      NaN             NaN
    10     Anakin Skywalker   188.0   84,0  ...    NaN      NaN             NaN
    11       Wilhuff Tarkin   180.0    NaN  ...    NaN      NaN             NaN
    13             Han Solo   180.0   80,0  ...    NaN      NaN             NaN
    16       Wedge Antilles   170.0   77,0  ...    NaN      NaN             NaN
    17     Jek Tono Porkins   180.0  110,0  ...    NaN      NaN             NaN
    19            Palpatine   170.0   75,0  ...    NaN      NaN             NaN
    20            Boba Fett   183.0   78,2  ...    NaN      NaN             NaN
    23     Lando Calrissian   177.0   79,0  ...    NaN      NaN             NaN
    24                Lobot   175.0   79,0  ...    NaN      NaN             NaN
    26           Mon Mothma   150.0    NaN  ...    NaN      NaN             NaN
    27         Arvel Crynyd     NaN    NaN  ...    NaN      NaN             NaN
    30         Qui-Gon Jinn   193.0   89,0  ...    NaN      NaN             NaN
    32        Finis Valorum   170.0    NaN  ...    NaN      NaN             NaN
    40       Shmi Skywalker   163.0    NaN  ...    NaN      NaN             NaN
    47           Mace Windu   188.0   84,0  ...    NaN      NaN             NaN
    56         Gregar Typho   185.0   85,0  ...    NaN      NaN             NaN
    57                Cordé   157.0    NaN  ...    NaN      NaN             NaN
    58          Cliegg Lars   183.0    NaN  ...    NaN      NaN             NaN
    62                Dormé   165.0    NaN  ...    NaN      NaN             NaN
    63                Dooku   193.0   80,0  ...    NaN      NaN             NaN
    64  Bail Prestor Organa   191.0    NaN  ...    NaN      NaN             NaN
    65           Jango Fett   183.0   79,0  ...    NaN      NaN             NaN
    70           Jocasta Nu   167.0    NaN  ...    NaN      NaN             NaN
    78      Raymus Antilles   188.0   79,0  ...    NaN      NaN             NaN
    81                 Finn     NaN    NaN  ...    NaN      NaN             NaN
    82                  Rey     NaN    NaN  ...    NaN      NaN             NaN
    83          Poe Dameron     NaN    NaN  ...    NaN      NaN             NaN
    86        Padmé Amidala   165.0   45,0  ...    NaN      NaN             NaN

    [37 rows x 14 columns]

``` python
starwars.loc[(starwars['planeta_natal'] == 'Tatooine'), ['nome', 'planeta_natal', 'especie']]

# não ficou claro pra mim o copy() - perguntei no chat!
```

                      nome planeta_natal especie
    0       Luke Skywalker      Tatooine  Humano
    1                C-3PO      Tatooine  Droide
    3          Darth Vader      Tatooine  Humano
    5            Owen Lars      Tatooine  Humano
    6   Beru Whitesun lars      Tatooine  Humano
    7                R5-D4      Tatooine  Droide
    8    Biggs Darklighter      Tatooine  Humano
    10    Anakin Skywalker      Tatooine  Humano
    40      Shmi Skywalker      Tatooine  Humano
    58         Cliegg Lars      Tatooine  Humano

## filter e sort\_values

``` python
# é chamado de filter mas trabalha em colunas, meu deus aguas escuras cuidado com isso
starwars.filter(like='cor_', axis = 1)
```

       cor_do_cabelo   cor_da_pele        cor_dos_olhos
    0          Loiro  Branca clara                 Azul
    1            NaN          Ouro              Amarelo
    2            NaN  Branca, Azul             Vermelho
    3         Nenhum        Branca              Amarelo
    4       Castanho         Clara             Castanho
    ..           ...           ...                  ...
    82      Castanho         Clara  Castanho esverdeado
    83      Castanho         Clara             Castanho
    84        Nenhum       Nenhuma                Preto
    85  Desconhecido  Desconhecida         Desconhecido
    86      Castanho         Clara             Castanho

    [87 rows x 3 columns]

``` python
starwars.sort_values(by = 'altura', ascending = False)
```

                  nome  altura  massa  ... filmes veiculos naves_espaciais
    53     Yarael Poof   264.0    NaN  ...    NaN      NaN             NaN
    77         Tarfful   234.0  136,0  ...    NaN      NaN             NaN
    68         Lama Su   229.0   88,0  ...    NaN      NaN             NaN
    12       Chewbacca   228.0  112,0  ...    NaN      NaN             NaN
    34    Roos Tarpals   224.0   82,0  ...    NaN      NaN             NaN
    ..             ...     ...    ...  ...    ...      ...             ...
    81            Finn     NaN    NaN  ...    NaN      NaN             NaN
    82             Rey     NaN    NaN  ...    NaN      NaN             NaN
    83     Poe Dameron     NaN    NaN  ...    NaN      NaN             NaN
    84             BB8     NaN    NaN  ...    NaN      NaN             NaN
    85  Captain Phasma     NaN    NaN  ...    NaN      NaN             NaN

    [87 rows x 14 columns]

## operacoes com dados

``` python
starwars['altura_em_metros'] = starwars['altura']/100
```

## apply

``` python
import pandas as pd
starwars = pd.read_csv('dados/starwars.csv', sep = ';', encoding = 'utf-8')


from unidecode import unidecode
starwars['nome_sem_acentos'] = starwars['nome'].apply(unidecode)
starwars['nome_sem_acentos']
```

    0     Luke Skywalker
    1              C-3PO
    2              R2-D2
    3        Darth Vader
    4        Leia Organa
               ...      
    82               Rey
    83       Poe Dameron
    84               BB8
    85    Captain Phasma
    86     Padme Amidala
    Name: nome_sem_acentos, Length: 87, dtype: object

## Gráficos!

``` python
from matplotlib import pyplot as plt
```

### boxplot

``` python
starwars.boxplot(column=['altura'])
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-18-1.png" width="672" style="display: block; margin: auto;" />

### gráfico de barras

``` python
#plt.bar(x = altura, y = massa)
```

## operacoes com dados agrupados

``` python
import pandas as pd
starwars = pd.read_csv('dados/starwars.csv', sep = ';', encoding = 'utf-8')

starwars.groupby('cor_do_cabelo').count()
```

                          nome  altura  massa  ...  filmes  veiculos  naves_espaciais
    cor_do_cabelo                              ...                                   
    Branco                   4       4      3  ...       0         0                0
    Castanho                18      15     11  ...       0         0                0
    Castanho avermelhado     1       1      0  ...       0         0                0
    Castanho, Cinza          1       1      1  ...       0         0                0
    Cinza                    1       1      1  ...       0         0                0
    Desconhecido             1       0      0  ...       0         0                0
    Loiro                    4       4      3  ...       0         0                0
    Nenhum                  37      36     27  ...       0         0                0
    Preto                   13      12      7  ...       0         0                0
    Ruivo, Branco            1       1      1  ...       0         0                0
    Ruivo, Cinza             1       1      0  ...       0         0                0

    [11 rows x 13 columns]

## copy

O subset (df\_vereadores\[cols…\]) retorna uma referência ao data frame original. Modificações no subset refletirão no data frame original. É o conceito de deep vs shallow copy. O copy() por padrão é “deep” (copy(deep=True)).

www.geeksforgeeks.org
Difference Between Shallow copy VS Deep copy in Pandas Dataframes - GeeksforGeeks

## extra

post da carol https://carolineattilio.medium.com/piririm-piririm-piririm-ainda-existe-orelh%C3%A3o-em-curitiba-8bb4d6bd67e

sugestao do junior: https://br.linkedin.com/in/juniorssz/

``` python
from unidecode import unidecode
unidecode('São Paulo')
```

    'Sao Paulo'
