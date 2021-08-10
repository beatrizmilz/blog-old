---
title: "Estudando Python - Semana 1, Parte 4"
excerpt: "Este posts é uma forma de documentar alguns aprendizados na minha trajetória estudando Python. Estou fazendo o curso de [Python para inovação cívica](https://escoladedados.org/courses/python-para-inovacao-civica/), oferecido pela [Escola de Dados](https://escoladedados.org/)."
draft: TRUE
author: "Beatriz Milz"
date: '2021-08-10'
categories: ["Portugues", "Python", "Estudo", "Reticulate"]
---

<script src="{{< blogdown/postref >}}index_files/twitter-widget/widgets.js"></script>

## Introdução

Olá!

Esse post faz parte de uma série de posts, que tem como objetivo documentar alguns aprendizados na minha trajetória estudando Python. Estou fazendo o curso de [Python para inovação cívica](https://escoladedados.org/courses/python-para-inovacao-civica/), oferecido pela [Escola de Dados](https://escoladedados.org/). Eu já programo em R, portanto muitas das anotações serão feitas comparando como é feito em R e em Python, assim acho que fica mais fácil para eu fazer as conexões conceituais e lembrar mais fácil depois.

Esse é o quarto post, então caso não tenha lido os posts anteriores, [acesse esse link](https://beatrizmilz.com/blog/2021-python-serie/)!

## Pacotes

Em R, podemos instalar pacotes e com isso ter disponível muitas funções que expandem as possibilidades do R base. Em Python também podemos instalar as bibliotecas (li em outros lugares também chamar de módulos ou pacotes), através do [`pip`](https://pypi.org/project/pip/), um instalador de pacotes para Python, que já está disponível nas versões mais recentes do Python ao instalá-lo. Se em R usamos `install.packages("nome_do_pacote")`, em Python podemos usar `pip install nome_do_pacote`.

Referência interessante: [Documentação do Python - Instalando módulos](https://docs.python.org/3/installing/index.html)

### Ambientes virtuais

Em R, quando queremos isolar os pacotes e suas respectivas versões entre os projetos que estamos desenvolvendo, podemos utilizar o pacote [`{renv}`](https://rstudio.github.io/renv/articles/renv.html) (apesar de não ser tão comum de ser utilizado: eu mesma uso em apenas alguns projetos que desenvolvo, como por exemplo o da minha tese).

Em Python, o uso dos ambientes virtuais parece ser bem mais comum. Eu ainda estou me ambientando com os ambientes virtuais em Python, mas algo que já percebi de diferente entre os ambientes virtuais de Python e o [`{renv}`](https://rstudio.github.io/renv/articles/renv.html) do R é que o {renv} é configurado vinculado ao projeto no RStudio (os `.RProj`); já em Python nós podemos criar os ambientes virtuais no computador e eles não parecem ser vinculados à “projetos” (e )

``` r
library(reticulate)
reticulate::conda_list()
```

              name
    1 r-reticulate
                                                                   python
    1 /Users/beatrizmilz/Library/r-miniconda/envs/r-reticulate/bin/python

### Instalar e carregar pacotes

``` r
# pip install pandas
# pip install matplotlib
```

``` r
reticulate::conda_install("r-reticulate", "numpy")
reticulate::conda_install("r-reticulate", "pandas")
reticulate::conda_install("r-reticulate", "matplotlib")
reticulate::conda_install("r-reticulate", "seaborn")
```

``` r
reticulate::py_config()
```

    python:         /Users/beatrizmilz/Library/r-miniconda/envs/r-reticulate/bin/python
    libpython:      /Users/beatrizmilz/Library/r-miniconda/envs/r-reticulate/lib/libpython3.6m.dylib
    pythonhome:     /Users/beatrizmilz/Library/r-miniconda/envs/r-reticulate:/Users/beatrizmilz/Library/r-miniconda/envs/r-reticulate
    version:        3.6.13 | packaged by conda-forge | (default, Feb 19 2021, 05:36:16)  [GCC Clang 11.0.1]
    numpy:          /Users/beatrizmilz/Library/r-miniconda/envs/r-reticulate/lib/python3.6/site-packages/numpy
    numpy_version:  1.19.5

``` r
py_module_available("pandas")
```

    [1] TRUE

### Import

esse import: o que é engraçado é poder usar essas abreviações.

Pandas

-   dataframe parecem dataframes

-   series parecem vetores!

Matplotlib

-   graficos

``` python
import pandas as pd
candidaturas_pe = pd.read_csv('dados/consulta_cand_2020_PE.csv', sep = ';', encoding = 'latin_1')
#pd.options.display.max_columns = 4
candidaturas_pe.head()
```

       DT_GERACAO HH_GERACAO  ...  DS_SITUACAO_CANDIDATO_URNA  ST_CANDIDATO_INSERIDO_URNA
    0  05/08/2021   12:18:13  ...                    DEFERIDO                         SIM
    1  05/08/2021   12:18:13  ...                    DEFERIDO                         SIM
    2  05/08/2021   12:18:13  ...                    DEFERIDO                         SIM
    3  05/08/2021   12:18:13  ...                    DEFERIDO                         SIM
    4  05/08/2021   12:18:13  ...                      #NULO#                         NÃO

    [5 rows x 63 columns]

``` python
candidaturas_pe.shape
```

    (21101, 63)

## Carregando tabelas

``` python
import glob
#glob.glob()
```

https://media.giphy.com/media/nJZxhesBFKbCw/giphy.gif

https://www.youtube.com/watch?v=X3RbYyHABzo

## Conclusão

Espero que esse post seja útil para pessoas que, assim como eu, já programam em R e querem aprender Python.

## Agradecimentos

Agradeço muito à equipe da [Escola de Dados](https://escoladedados.org/courses/python-para-inovacao-civica/), por oferecer esse curso. Além disso, gostaria de agradecer especialmente à instrutora da semana: [Ana Cecília Vieira](https://twitter.com/cecivieira).

## Como interagir?

Atualmente, não está funcionando a opção de comentários. Então se quiser comentar/interagir, recomendo que faça nessa thread, onde estou falando sobre essa série de posts:

<center>
<blockquote class="twitter-tweet" data-width="550" data-lang="en" data-dnt="true" data-theme="light"><p lang="pt" dir="ltr">Tô aprendendo Python no curso de Python pra Inovação cívica da <a href="https://twitter.com/EscolaDeDados?ref_src=twsrc%5Etfw">@EscolaDeDados</a> , e escrevi um post pra me ajudar a fixar o conteúdo. O post é comparando o que é ensinado sobre Python, com as formas que fazemos em R.<br>Obrigada  <a href="https://twitter.com/cecivieira?ref_src=twsrc%5Etfw">@cecivieira</a> e  <a href="https://twitter.com/EscolaDeDados?ref_src=twsrc%5Etfw">@EscolaDeDados</a>!<a href="https://t.co/EFLjAvPwMl">https://t.co/EFLjAvPwMl</a></p>&mdash; Beatriz Milz (@BeaMilz) <a href="https://twitter.com/BeaMilz/status/1424188713974829056?ref_src=twsrc%5Etfw">August 8, 2021</a></blockquote>

</center>

-   [Veja a thread completa neste link!](https://twitter.com/BeaMilz/status/1424188713974829056?s=20)
