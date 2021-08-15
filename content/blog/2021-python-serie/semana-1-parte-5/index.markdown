---
title: "Estudando Python - Semana 1, Parte 5"
excerpt: "Este posts é uma forma de documentar alguns aprendizados na minha trajetória estudando Python. Estou fazendo o curso de [Python para inovação cívica](https://escoladedados.org/courses/python-para-inovacao-civica/), oferecido pela [Escola de Dados](https://escoladedados.org/)."
draft: FALSE
author: "Beatriz Milz"
date: '2021-08-15'
categories: ["Portugues", "Python", "Estudo", "Reticulate"]
---

<script src="{{< blogdown/postref >}}index_files/twitter-widget/widgets.js"></script>

## Introdução

Olá!

Esse post faz parte de uma série de posts, que tem como objetivo documentar alguns aprendizados na minha trajetória estudando Python. Estou fazendo o curso de [Python para inovação cívica](https://escoladedados.org/courses/python-para-inovacao-civica/), oferecido pela [Escola de Dados](https://escoladedados.org/). Eu já programo em R, portanto muitas das anotações serão feitas comparando como é feito em R e em Python, assim acho que fica mais fácil para eu fazer as conexões conceituais e lembrar mais fácil depois.

Esse post é o último sobre conteúdo da semana 1, então caso não tenha lido os posts anteriores, [acesse esse link](https://beatrizmilz.com/blog/2021-python-serie/). Esse post, e os próximos dessa série, serão bem mais diretos: mostrarei o que fizemos em Python, como eu faria em R, e caso haja alguma diferença importante que percebi, eu destacarei :)

## glob: listando arquivos no diretório

O primeiro conceito importante é a função `glob()`, do pacote `glob`. Mas antes disso, uma pausa para um comentário aleatório:

> Eu não consigo ler glob sem lembrar de Hora da aventura! Não tem como não lembrar do episódio que o Lemongrab corre gritando ‘YOU ARE MY GLOB’

<img src="https://media.giphy.com/media/nJZxhesBFKbCw/giphy.gif" style="display: block; margin: auto;" />

Nesse vídeo está a referência:

<center>
<iframe width="560" height="315" src="https://www.youtube.com/embed/X3RbYyHABzo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
</iframe>
</center>

> Final do comentário aleatório!

O `glob` é útil para criar uma lista com os caminhos e nomes de arquivos em um determinado diretório. Por exemplo, dentro da pasta onde estou desenvolvendo este post, tem uma pasta chamada `dados/` e ela contém três arquivos. Vamos checar quais são usando o glob?

``` python
# Em Python

import glob # importar o pacote glob


glob.glob('dados/*') # Todos os arquivos na pasta dados
```

    ['dados/consulta_cand_2020_PE.csv', 'dados/consulta_cand_2020_RN.csv', 'dados/arquivo-vazio.txt']

``` python
glob.glob('dados/*.csv') # Arquivos na pasta dados que tem extensão csv
```

    ['dados/consulta_cand_2020_PE.csv', 'dados/consulta_cand_2020_RN.csv']

Como fazer isso em R? Nos exemplos a seguir, apresento com R base e também com o pacote [`{fs}`](https://fs.r-lib.org/):

``` r
# Em R base:
# Todos os arquivos na pasta dados
list.files("dados/")
```

    [1] "arquivo-vazio.txt"         "consulta_cand_2020_PE.csv"
    [3] "consulta_cand_2020_RN.csv"

``` r
# Em R base:
# Arquivos na pasta dados que tem extensão csv
list.files("dados/", pattern = ".csv")
```

    [1] "consulta_cand_2020_PE.csv" "consulta_cand_2020_RN.csv"

``` r
# Em R com pacote fs:
fs::dir_ls("dados/", glob = "*.csv")
```

    dados/consulta_cand_2020_PE.csv dados/consulta_cand_2020_RN.csv 

## Importando uma tabela armazenada em um arquivo .csv

Para importar dados tabulares em `.csv` de forma similar ao data.frame que temos em R, podemos usar o pacote [pandas](https://pandas.pydata.org/). O [pandas](https://pandas.pydata.org/) possui várias funções que começam com `read_` e que podemos usar para importar arquivos, como:

-   `pd.read_clipboard()`

-   `pd.read_csv()`

-   `pd.read_excel()`

-   `pd.read_json()`

-   e muitos outros :)

Para importar um arquivo .csv, usamos então a função `pd.read_csv()`. No primeiro argumento, escrevemos o caminho até o arquivo. No argumento `sep =`, escrevemos o separador usado para delimitar as colunas. No argumento `encoding =`, escrevemos o encoding (a codificação dos caracteres) usado para salvar o arquivo (um exemplo comum é o `UTF-8`, mas o ideal é consultar a documentação, ou dicionário de dados, da base que você quer importar):

``` python
import pandas as pd # importar o pandas

# importar os dados
candidaturas_pe = pd.read_csv('dados/consulta_cand_2020_PE.csv', sep = ';', 
                              encoding = 'latin_1')

candidaturas_pe.head # ver as primeiras linhas
```

    <bound method NDFrame.head of        DT_GERACAO  ... ST_CANDIDATO_INSERIDO_URNA
    0      05/08/2021  ...                        SIM
    1      05/08/2021  ...                        SIM
    2      05/08/2021  ...                        SIM
    3      05/08/2021  ...                        SIM
    4      05/08/2021  ...                        NÃO
    ...           ...  ...                        ...
    21096  05/08/2021  ...                        SIM
    21097  05/08/2021  ...                        SIM
    21098  05/08/2021  ...                        SIM
    21099  05/08/2021  ...                        SIM
    21100  05/08/2021  ...                        SIM

    [21101 rows x 63 columns]>

Como fazer isso em R? Podemos usar o pacote [`{readr}`](https://readr.tidyverse.org/), porém é apenas uma das formas! Se usamos arquivos `.csv` gerados no contexto brasileiro, é comum que o separador seja o ponto-e-vírgula (;), e nesses casos, podemos usar a função `read_csv2()`. Veja o exemplo a seguir:

``` r
# Em R base:
library(readr) # carregar o pacote usado


# importar os dados
candidaturas_pe_r <- read_csv2("dados/consulta_cand_2020_PE.csv",
                               locale = locale(encoding = "Latin1"))

head(candidaturas_pe_r) # ver as primeiras linhas
```

    # A tibble: 6 × 63
      DT_GERACAO HH_GERACAO ANO_ELEICAO CD_TIPO_ELEICAO NM_TIPO_ELEICAO   NR_TURNO
      <chr>      <time>           <dbl>           <dbl> <chr>                <dbl>
    1 05/08/2021 12:18:13          2020               2 ELEIÇÃO ORDINÁRIA        1
    2 05/08/2021 12:18:13          2020               2 ELEIÇÃO ORDINÁRIA        1
    3 05/08/2021 12:18:13          2020               2 ELEIÇÃO ORDINÁRIA        1
    4 05/08/2021 12:18:13          2020               2 ELEIÇÃO ORDINÁRIA        1
    5 05/08/2021 12:18:13          2020               2 ELEIÇÃO ORDINÁRIA        1
    6 05/08/2021 12:18:13          2020               2 ELEIÇÃO ORDINÁRIA        1
    # … with 57 more variables: CD_ELEICAO <dbl>, DS_ELEICAO <chr>,
    #   DT_ELEICAO <chr>, TP_ABRANGENCIA <chr>, SG_UF <chr>, SG_UE <dbl>,
    #   NM_UE <chr>, CD_CARGO <dbl>, DS_CARGO <chr>, SQ_CANDIDATO <dbl>,
    #   NR_CANDIDATO <dbl>, NM_CANDIDATO <chr>, NM_URNA_CANDIDATO <chr>,
    #   NM_SOCIAL_CANDIDATO <chr>, NR_CPF_CANDIDATO <chr>, NM_EMAIL <chr>,
    #   CD_SITUACAO_CANDIDATURA <dbl>, DS_SITUACAO_CANDIDATURA <chr>,
    #   CD_DETALHE_SITUACAO_CAND <dbl>, DS_DETALHE_SITUACAO_CAND <chr>, …

## Carregando mais de um arquivo em um único dataframe

É frequente que encontremos dados que estão separados em vários arquivos! Seja por anos, por estados brasileiros, entre outros. E para analisar com o conjunto completo de dados, queremos unir todo o conteúdo em um único dataframe.

Esse código a seguir foi desenvolvido durante a aula prática, pela professora [Ana Cecília Vieira](https://twitter.com/cecivieira).

``` python
# Em Python

# Primeiro passo é importar os pacotes necessários
import glob
import pandas as pd

# Usando o glob, vamos listar os arquivos que estão na pasta dados, 
# que o nome se inicia com 'consulta' e que tem a extensão `.csv`
lista_arquivos = glob.glob('dados/consulta*.csv')


# Vamos criar uma lista vazia, onde adicionaremos os conteúdos importados
lista_df = []

# vamos fazer um loop, para ler cada arquivo que está em
# lista_arquivos, e então adicionar na lista_df:
for csv in lista_arquivos:
  df = pd.read_csv(csv, sep = ';', encoding='latin_1')
  lista_df.append(df)


# Porém o que fizemos até aqui é uma lista de dataframes!
# Precisamos juntar os dataframes, usando o concat do pandas
# e salvar o resultado em um novo objeto:
candidaturas_PE_RN = pd.concat(lista_df)

candidaturas_PE_RN.head # ver as primeiras linhas da base
```

    <bound method NDFrame.head of        DT_GERACAO  ... ST_CANDIDATO_INSERIDO_URNA
    0      05/08/2021  ...                        SIM
    1      05/08/2021  ...                        SIM
    2      05/08/2021  ...                        SIM
    3      05/08/2021  ...                        SIM
    4      05/08/2021  ...                        NÃO
    ...           ...  ...                        ...
    10550  05/08/2021  ...                        SIM
    10551  05/08/2021  ...                        SIM
    10552  05/08/2021  ...                        SIM
    10553  05/08/2021  ...                        SIM
    10554  05/08/2021  ...                        SIM

    [31656 rows x 63 columns]>

Com o `.head`, foi possível observar que ainda temos o mesmo número de colunas que a outra base importada anteriormente, mas agora temos mais linhas (pois importamos e unimos as duas bases, que representam informações de estados brasileiros diferentes).

Como fazer isso em R? Novamente, sempre tem mais de uma forma. A forma que eu costumo usar é essa: uso alguma função para listar arquivos em um diretório, e aplico uma função de leitura em todos os elementos usando o pacote [`{purrr}`](https://purrr.tidyverse.org/reference/map.html). A função purrr::map\_dfr() retornará um dataframe, e empilhará as bases usando as linhas, por isso é `dfr` (dataframe rows).

``` r
# carregar o pacote magrittr, que disponibiliza o %>%
library(magrittr)
candidaturas_PE_RN_r <-
  fs::dir_ls("dados/", glob = "*.csv") %>% # listar os arquivos na pasta
  # aplicar a função read_csv2 para todos os
  # elementos listados na etapa anterior
  purrr::map_dfr(read_csv2,
                 locale = locale(encoding = "Latin1"))

# ver as primeiras linhas
head(candidaturas_PE_RN_r)
```

    # A tibble: 6 × 63
      DT_GERACAO HH_GERACAO ANO_ELEICAO CD_TIPO_ELEICAO NM_TIPO_ELEICAO   NR_TURNO
      <chr>      <time>           <dbl>           <dbl> <chr>                <dbl>
    1 05/08/2021 12:18:13          2020               2 ELEIÇÃO ORDINÁRIA        1
    2 05/08/2021 12:18:13          2020               2 ELEIÇÃO ORDINÁRIA        1
    3 05/08/2021 12:18:13          2020               2 ELEIÇÃO ORDINÁRIA        1
    4 05/08/2021 12:18:13          2020               2 ELEIÇÃO ORDINÁRIA        1
    5 05/08/2021 12:18:13          2020               2 ELEIÇÃO ORDINÁRIA        1
    6 05/08/2021 12:18:13          2020               2 ELEIÇÃO ORDINÁRIA        1
    # … with 57 more variables: CD_ELEICAO <dbl>, DS_ELEICAO <chr>,
    #   DT_ELEICAO <chr>, TP_ABRANGENCIA <chr>, SG_UF <chr>, SG_UE <dbl>,
    #   NM_UE <chr>, CD_CARGO <dbl>, DS_CARGO <chr>, SQ_CANDIDATO <dbl>,
    #   NR_CANDIDATO <dbl>, NM_CANDIDATO <chr>, NM_URNA_CANDIDATO <chr>,
    #   NM_SOCIAL_CANDIDATO <chr>, NR_CPF_CANDIDATO <chr>, NM_EMAIL <chr>,
    #   CD_SITUACAO_CANDIDATURA <dbl>, DS_SITUACAO_CANDIDATURA <chr>,
    #   CD_DETALHE_SITUACAO_CAND <dbl>, DS_DETALHE_SITUACAO_CAND <chr>, …

E é isso, chegamos ao final da semana 1 :)

## Agradecimentos

Espero que esse post seja útil para pessoas que, assim como eu, já programam em R e querem aprender Python. Agradeço muito à equipe da [Escola de Dados](https://escoladedados.org/courses/python-para-inovacao-civica/), por oferecer esse curso. Além disso, gostaria de agradecer especialmente à instrutora da semana: [Ana Cecília Vieira](https://twitter.com/cecivieira).

## Como interagir?

Atualmente, não está funcionando a opção de comentários. Então se quiser comentar/interagir, recomendo que faça nessa thread, onde estou falando sobre essa série de posts:

<center>
<blockquote class="twitter-tweet" data-width="550" data-lang="en" data-dnt="true" data-theme="light"><p lang="pt" dir="ltr">Tô aprendendo Python no curso de Python pra Inovação cívica da <a href="https://twitter.com/EscolaDeDados?ref_src=twsrc%5Etfw">@EscolaDeDados</a> , e escrevi um post pra me ajudar a fixar o conteúdo. O post é comparando o que é ensinado sobre Python, com as formas que fazemos em R.<br>Obrigada  <a href="https://twitter.com/cecivieira?ref_src=twsrc%5Etfw">@cecivieira</a> e  <a href="https://twitter.com/EscolaDeDados?ref_src=twsrc%5Etfw">@EscolaDeDados</a>!<a href="https://t.co/EFLjAvPwMl">https://t.co/EFLjAvPwMl</a></p>&mdash; Beatriz Milz (@BeaMilz) <a href="https://twitter.com/BeaMilz/status/1424188713974829056?ref_src=twsrc%5Etfw">August 8, 2021</a></blockquote>

</center>

-   [Veja a thread completa neste link!](https://twitter.com/BeaMilz/status/1424188713974829056?s=20)
