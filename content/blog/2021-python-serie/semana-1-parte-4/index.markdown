---
title: "Estudando Python - Semana 1, Parte 4"
excerpt: "Este posts é uma forma de documentar alguns aprendizados na minha trajetória estudando Python. Estou fazendo o curso de [Python para inovação cívica](https://escoladedados.org/courses/python-para-inovacao-civica/), oferecido pela [Escola de Dados](https://escoladedados.org/)."
draft: FALSE
author: "Beatriz Milz"
date: '2021-08-13'
categories: ["Portugues", "Python", "Estudo", "Reticulate"]
---

<script src="{{< blogdown/postref >}}index_files/twitter-widget/widgets.js"></script>

## Introdução

Olá!

Esse post faz parte de uma série de posts, que tem como objetivo documentar alguns aprendizados na minha trajetória estudando Python. Estou fazendo o curso de [Python para inovação cívica](https://escoladedados.org/courses/python-para-inovacao-civica/), oferecido pela [Escola de Dados](https://escoladedados.org/). Eu já programo em R, portanto muitas das anotações serão feitas comparando como é feito em R e em Python, assim acho que fica mais fácil para eu fazer as conexões conceituais e lembrar mais fácil depois.

Esse é o quarto post da semana 1, então caso não tenha lido os posts anteriores, [acesse esse link](https://beatrizmilz.com/blog/2021-python-serie/)!

## Pacotes

Em R, podemos instalar pacotes e com isso ter disponível muitas funções que expandem as possibilidades do R base. Em Python também podemos instalar as bibliotecas (li em outros lugares também chamar de módulos ou pacotes), através do [`pip`](https://pypi.org/project/pip/), um instalador de pacotes para Python, que já está disponível nas versões mais recentes do Python ao instalá-lo. Antes de comentar como instalar pacotes, tem outro conceito importante a ser citado: o de ambientes virtuais!

### Ambientes virtuais

Em R, quando queremos isolar os pacotes e suas respectivas versões entre os projetos que estamos desenvolvendo, podemos utilizar o pacote [`{renv}`](https://rstudio.github.io/renv/articles/renv.html) (apesar de não ser tão comum de ser utilizado: eu mesma uso em apenas alguns projetos que desenvolvo, como por exemplo: a minha tese, projetos acadêmicos, etc).

Em Python, o uso dos ambientes virtuais parece ser bem mais comum. Eu ainda estou me ambientando com os ambientes virtuais em Python, mas algo que já percebi de diferente entre os ambientes virtuais de Python e o [`{renv}`](https://rstudio.github.io/renv/articles/renv.html) do R é que o {renv} é configurado vinculado ao projeto no RStudio (os `.RProj`); já em Python nós podemos criar os ambientes virtuais no computador e eles não parecem ser vinculados à “projetos” como no RStudio, e sim à um diretório (uma pasta no computador).

A função `reticulate::conda_list()` retorna um data frame com o nome de ambientes disponíveis para uso. No resultado abaixo, é possível ver que o nome do ambiente disponível é `r-reticulate`:

``` r
# Código R
library(reticulate)

reticulate::conda_list()
```

              name
    1 r-reticulate
                                                                   python
    1 /Users/beatrizmilz/Library/r-miniconda/envs/r-reticulate/bin/python

Neste post, não vou tratar sobre como criar ambientes virtuais pois é algo que eu estou praticando bastante 🤣 e prefiro entender melhor antes de tratar disso em um post. Mas deixo aqui algumas referências:

-   [Documentação do Python](https://docs.python.org/3/tutorial/venv.html)

-   [Documentação do pacote reticulate](https://rstudio.github.io/reticulate/articles/python_packages.html)

### Instalar e carregar pacotes

Para instalar pacotes em R, podemos usar a seguinte função:

``` r
# Código R
install.packages("nome_do_pacote")
```

Para instalar pacotes em Python, algo que ficou confuso para mim inicialmente era se eu deveria executar os códigos no terminal ou no próprio Phyton! No exemplo a seguir, apresento o código onde consegui instalar o pacote [pandas](https://pandas.pydata.org/) no terminal:

``` bash
# código em bash/terminal:
python3 -m pip install "pandas"
```

Referência importante: [Documentação do Python - Instalando pacotes](https://packaging.python.org/tutorials/installing-packages/)

Outra forma para instalar pacotes em Python é com o [reticulate](https://rstudio.github.io/reticulate/), que possui funções para que a gente instale pacotes sendo explícitos em qual ambiente virtual esses pacotes devem ser instalados. Por exemplo, se queremos instalar o [pandas](https://pandas.pydata.org/) no ambiente `r-reticulate`, podemos usar a função `conda_install()`:

``` r
# Código R
reticulate::conda_install("r-reticulate", "pandas")
```

E para verificar se o pacote está disponível para uso, podemos usar a função `py_module_available()`:

``` r
# Código R
reticulate::py_module_available("pandas")
```

    [1] TRUE

### Carregar pacotes

Em R e Python, não basta apenas instalar um pacote para que fique totalmente disponível para utilizar as suas funções: precisamos carregar os pacotes. Em R, utilizamos a função:

``` r
# Código R
library(nome_do_pacote)
```

Em Python, usamos o `import`:

``` python
# Código Python
import glob
```

Para utilizar alguma função do pacote, é usado a sintaxe `nomedopacote.nomedafuncao()`. Por exemplo, para usar a função `glob()` do pacote `glob`, usamos:

``` python
# Código Python
glob.glob('dados/*.csv')
```

    ['dados/consulta_cand_2020_PE.csv']

> Obs: Não é necessário focar no uso da função acima agora, pois vou comentar em posts futuros!

Porém, algo que eu achei curioso é que podemos usar abreviações para acessar alguns pacotes, como o pandas! Por exemplo:

``` python
# Código Python
import pandas as pd
```

Para utilizar alguma função do pacote, nós precisamos usar a forma `nomedopacote.nomedafuncao()`, por exemplo, para usar a função `glob()` do pacote `glob`, usamos:

``` python
# Código Python

# Importando uma base com pd.read_csv()
pd.read_csv('dados/consulta_cand_2020_PE.csv', sep = ';', encoding = 'latin_1')
```

           DT_GERACAO  ... ST_CANDIDATO_INSERIDO_URNA
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

    [21101 rows x 63 columns]

> Obs: Não é necessário focar no uso da função acima agora, pois vou comentar em posts futuros!

Conheço pessoas que não gostam muito dessa sintaxe usada em Python (por exemplo `pd.read_csv()`). Porém, quando estou programando em R, na maioria das vezes eu uso uma sintaxe que me permite não carregar pacotes com `library()`, e também diminuir a chance de conflitos de funções de pacotes diferentes mas que tem o mesmo nome de função. Essa sintaxe utiliza os quatro pontos `::`, por exemplo: `nome_do_pacote::nome_da_funcao()`. Então usar o `pd.read_csv()` e `readr::read_csv()` não é tão diferente para mim!

## Agradecimentos

Espero que esse post seja útil para pessoas que, assim como eu, já programam em R e querem aprender Python. Agradeço muito à equipe da [Escola de Dados](https://escoladedados.org/courses/python-para-inovacao-civica/), por oferecer esse curso. Além disso, gostaria de agradecer especialmente à instrutora da semana: [Ana Cecília Vieira](https://twitter.com/cecivieira).

## Como interagir?

Atualmente, não está funcionando a opção de comentários. Então se quiser comentar/interagir, recomendo que faça nessa thread, onde estou falando sobre essa série de posts:

<center>
<blockquote class="twitter-tweet" data-width="550" data-lang="en" data-dnt="true" data-theme="light"><p lang="pt" dir="ltr">Tô aprendendo Python no curso de Python pra Inovação cívica da <a href="https://twitter.com/EscolaDeDados?ref_src=twsrc%5Etfw">@EscolaDeDados</a> , e escrevi um post pra me ajudar a fixar o conteúdo. O post é comparando o que é ensinado sobre Python, com as formas que fazemos em R.<br>Obrigada  <a href="https://twitter.com/cecivieira?ref_src=twsrc%5Etfw">@cecivieira</a> e  <a href="https://twitter.com/EscolaDeDados?ref_src=twsrc%5Etfw">@EscolaDeDados</a>!<a href="https://t.co/EFLjAvPwMl">https://t.co/EFLjAvPwMl</a></p>&mdash; Beatriz Milz (@BeaMilz) <a href="https://twitter.com/BeaMilz/status/1424188713974829056?ref_src=twsrc%5Etfw">August 8, 2021</a></blockquote>

</center>

-   [Veja a thread completa neste link!](https://twitter.com/BeaMilz/status/1424188713974829056?s=20)
