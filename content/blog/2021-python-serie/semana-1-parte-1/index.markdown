---
title: "Estudando Python - Semana 1, Parte 1"
excerpt: "Este posts é uma forma de documentar alguns aprendizados na minha trajetória estudando Python. Estou fazendo o curso de [Python para inovação cívica](https://escoladedados.org/courses/python-para-inovacao-civica/), oferecido pela [Escola de Dados](https://escoladedados.org/)."
draft: FALSE
author: "Beatriz Milz"
date: '2021-08-07'
categories: ["Portugues", "Python", "Estudo", "Reticulate"]
---

<script src="{{< blogdown/postref >}}index_files/twitter-widget/widgets.js"></script>

## Introdução

Olá!

Esse post é uma forma de documentar alguns aprendizados na minha trajetória estudando Python. Estou fazendo o curso de [Python para inovação cívica](https://escoladedados.org/courses/python-para-inovacao-civica/), sendo que é o segundo curso que faço na [Escola de Dados](https://escoladedados.org/) (o primeiro foi sobre
[Jornalismo de dados ambientais](https://escoladedados.org/courses/jornalismo-de-dados-ambientais/)).

O curso é organizado em 6 semanas, e a contagem é iniciada no 0 (pelo que entendi, é uma brincadeira pois a indexação no Python começa com 0 também). Essas anotações são referentes à semana 1 (portanto, a segunda semana de curso). Não pensei em criar um post sobre a primeira semana pois foi focada em ambientação, instalação das ferramentas necessárias, apresentação do Git, entre outros.

Para quem está chegando neste blog pela primeira vez, eu sou a [Bea](https://beatrizmilz.com/about/) e já programo em R desde 2018. Portanto muitas das anotações serão feitas comparando como é feito em R e em Python, assim acho que fica mais fácil para eu fazer as conexões conceituais e lembrar mais fácil depois.

> Então, **atenção**: este post é um registro do que tenho aprendido. Caso você seja uma pessoa que conhece mais Python e perceba que eu escrevi algo incorreto, me avise :) assim posso corrigir e aprender mais.

Além disso, todo esse post foi escrito diretamente da [IDE RStudio](https://www.rstudio.com/), usando os pacotes [R Markdown](https://rmarkdown.rstudio.com/) e [reticulate](https://rstudio.github.io/reticulate/), que oferece uma interface para trabalharmos com R e Python.

Vamos carregar o pacote reticulate:

``` r
library(reticulate)
```

Para verificar se o Python está disponível para uso, podemos usar a função `py_available()`. E para verificar qual versão do Python o reticulate está usando, podemos usar a função `py_version()`:

``` r
py_available()
# > [1] TRUE

py_version()
# > [1] ‘3.6’
```

> OBS: Uma dica se você também está se aventurando no mundo do RMarkdown + Reticulate: nas opções globais de chunk, utilize `python = reticulate::eng_python` para que funcione tudo corretamente :)

Vamos lá!

<div class="figure" style="text-align: center">

<img src="reticulated_python-featured-hex.png" alt="Imagem do pacote reticulate, que mostra o logo do R em azul e cinza, junto com uma cobra python com carinha feliz, representando a união das duas linguagens." width="370" />
<p class="caption">
Figure 1: Imagem do pacote reticulate, que mostra o logo do R em azul e cinza, junto com uma cobra python com carinha feliz, representando a união das duas linguagens.
</p>

</div>

> Se você se interessa em saber mais como programar em Python diretamente do RStudio, escreve aqui nos comentários :) Assim dá pra saber se tem demanda por um post futuramente sobre como tem sido essa experiência.

## Variáveis

As regras para nomear as variáveis em Python são iguais às que usamos em R. O que percebi de diferente é a forma de declarar as variáveis:

-   Em R, podemos declarar tanto usando o operador `<-` quanto `=`. Porém, as boas práticas recomendam utilizar `<-`. Por exemplo:

``` r
# Em R:
# use o sinal <- para atribuir algum valor a uma variável
atribuindo_variavel_em_r <- "Olá mundo do R!"

# escreva e execute o nome de uma variável para ver o conteúdo
atribuindo_variavel_em_r
```

    [1] "Olá mundo do R!"

-   Em Python, devemos usar `=` para declarar variáveis. Por exemplo:

``` python
# Em Python:
# use o sinal = para atribuir algum valor a uma variável
atribuindo_variavel_em_python = 'Olá mundo do Python!'
```

``` python
# Em Python:
# escreva e execute o nome de uma variável para ver o conteúdo
atribuindo_variavel_em_python
```

    'Olá mundo do Python!'

## Tipos básicos de dados

Os tipos básicos de dados nas duas linguagens também são similares, apesar de até então não visto um tipo de dado básico similar aos `factors` (usado para dados categóricos) em R no Python.

> Editando: O [Belisário](https://twitter.com/belisards), da [Escola de Dados](https://escoladedados.org/), me contou que no [pandas](https://pandas.pydata.org/) existe um tipo de dado categórico, chamado `Categoricals`. Deixo aqui o [link para a documentação](https://pandas.pydata.org/pandas-docs/stable/user_guide/categorical.html), que ele enviou! Muito obrigada, Belisário!

Para descobrir a classe de uma variável, em R usamos a função `class()`, e em Python usamos a função `type()`:

``` r
# Em R:
class(atribuindo_variavel_em_r)
```

    [1] "character"

``` python
# Em Python:
type(atribuindo_variavel_em_python)
```

    <class 'str'>

## TRUE ou True?

Em R, usamos `TRUE` e `FALSE` (em letras maiúsculas) para representar valores booleanos de verdadeiro e falso. Já em Python, usamos `True` e `False`, sendo a primeira letra maiúscula e as outras minúsculas. Veja o exemplo:

``` r
# Em R
1 == 1
```

    [1] TRUE

``` r
1 == 2
```

    [1] FALSE

``` python
# Em Python
1 == 1
```

    True

``` python
1 == 2
```

    False

## Índice

Essa diferença é algo que eu já tinha ouvido falar: Python é uma linguagem cujo índice se inicia em 0. Já em R, o índice se inicia em 1. Veja um exemplo:

``` r
# Em R:
# Criamos um vetor com três nomes
nomes_r <- c("Beatriz", "Ana", "Cecília")

# Para acessar o primeiro nome, usamos essa sintaxe, 
# com o índice 1:
nomes_r[1]
```

    [1] "Beatriz"

``` python
# Em Python:

# Criamos uma lista com três nomes
nomes_python  = ['Beatriz', 'Ana', 'Cecília']

# Para acessar o primeiro nome, usamos essa sintaxe, 
# com o índice 0:
nomes_python[0]
```

    'Beatriz'

``` python
# Se usassemos o índice 1, como em R, o valor retornado seria o segundo nome da lista:
nomes_python[1]
```

    'Ana'

## Estruturas de dados

As estruturas de dados que são tratadas no curso são as **listas** e os **dicionários**. Confesso que preciso estudar mais para me sentir a vontade de escrever as comparações com R, mas seguem aqui **as minhas primeiras impressões**:

### Listas

De início, as listas me pareceram como os vetores que usamos em R, sendo que no R usamos a função `c()` para concatenar os valores em um vetor. Já em Python, usamos os colchetes para delimitar quais valores serão adicionados na lista: `[]`.

``` r
# Em R:
# Criamos um vetor com três nomes
vetor_r <- c("Beatriz", "Ana", "Cecília")
```

``` python
# Em Python:

# Criamos uma lista com três nomes
lista_python  = ['Beatriz', 'Ana', 'Cecília']
```

PORÉM, uma coisa que é diferente é que **a lista do Python aceita valores de mais de um tipo de classe**. Já nos vetores em R isso não funciona bem, pois os vetores devem conter apenas um tipo de classe. Assim, caso a gente crie um vetor com valores de classes diferentes, acontecerá a coerção e tudo será generalizado para uma única classe:

``` r
# Em R:
# Criamos um vetor com três valores de classes diferentes
vetor_r_varias_classes <- c("Beatriz", 28, TRUE)

# usamos os colchetes para acessar valores dentro de um vetor: 
vetor_r_varias_classes[1]
```

    [1] "Beatriz"

``` r
# podemos usar a função class() para conferir a classe de cada um dos elementos:
class(vetor_r_varias_classes[1])
```

    [1] "character"

``` r
class(vetor_r_varias_classes[2])
```

    [1] "character"

``` r
class(vetor_r_varias_classes[3])
```

    [1] "character"

Reparou? No R, todos os valores do vetor foram transformados para ter a classe de texto, pois dentre as classes usadas no vetor, é a mais geral.

Já na lista do Python, a classe de cada elemento da lista foi mantida:

``` python
# Em Python:

# Criamos uma lista com três valores de classes diferentes
lista_python_varias_classes  = ['Beatriz', 28, True]

# conferindo a classe da variável
type(lista_python_varias_classes)
```

    <class 'list'>

``` python
# usamos os colchetes para acessar valores dentro de uma lista:
lista_python_varias_classes[0]
```

    'Beatriz'

``` python
# podemos usar a função type() para conferir a classe de cada um dos elementos:
type(lista_python_varias_classes[0])
```

    <class 'str'>

``` python
type(lista_python_varias_classes[1])
```

    <class 'int'>

``` python
type(lista_python_varias_classes[2])
```

    <class 'bool'>

Outra possibilidade seria comparar as listas em Python com as listas em R. Porém a lista é criada com a função `list()`, e para acessar os elementos da lista é preciso usar colchetes duplos `[[ ]]`:

``` r
# Criamos uma lista com três valores de classes diferentes
lista_r <- list("Beatriz", 28, TRUE)

# Verificar a classe de cada elemento da lista
class(lista_r[[1]])
```

    [1] "character"

``` r
class(lista_r[[2]])
```

    [1] "numeric"

``` r
class(lista_r[[3]])
```

    [1] "logical"

### Dicionários

Os dicionários em Python me pareceram mais como as listas em R!

<div class="figure" style="text-align: center">

<img src="nazare.jpeg" alt="Imagem do meme da Nazaré Tedesco confusa." width="495" />
<p class="caption">
Figure 2: Imagem do meme da Nazaré Tedesco confusa.
</p>

</div>

Se em R queremos fazer uma sequência de itens declarando uma chave e um valor correspondente, podemos usar a sintaxe `list("chave" = valor_correspondente, ....)`:

``` r
# Em R:
lista_em_r <- list("nome" = "Beatriz", "idade" = 28, "estudante" = TRUE)
```

Para acessar algum valor da lista utilizando a chave, podemos usar a sintaxe `nome_da_lista["nome_da_chave"]`, por exemplo:

``` r
# Em R:
lista_em_r["nome"]
```

    $nome
    [1] "Beatriz"

Nos dicionários de Python, para criar o dicionário devemos utilizar as chaves `{ }`, e usar a seguinte sintaxe: `{'nome_da_chave': valor_correspondente, ...}`

``` python
pessoa = {'nome': 'Beatriz', 'idade': 28, 'estudante': True}
```

Para acessar algum valor o dicionário utilizando a chave, podemos usar a mesma sintaxe usada nas listas em R: `nome_do_dicionario['nome_da_chave']`, por exemplo:

``` python
pessoa['nome']
```

    'Beatriz'

Como eu disse, ainda preciso estudar mais sobre essas estruturas de dados para conectar melhor as equivalências. Quem sabe no futuro escrevo algum post melhor sobre essas diferenças, né?

## Aspas simples ou duplas?

Para escrever textos, é possível usar aspas simples ou aspas duplas. Porém em R é mais comum usar aspas duplas, e até então tenho visto mais o uso de aspas simples em Python.

## Conclusão

Esse post ficou imenso e eu abordei a comparação de apenas parte do conteúdo da semana 1! Então achei melhor encerrar por aqui e continuar em outro post.

Achei bem legal escrever esse post pois me fez “colocar a mão na massa” e perceber várias das diferenças tratadas aqui!

Espero que esse post seja útil para pessoas que, assim como eu, já programam em R e querem aprender Python.

## Agradecimentos

Agradeço muito à equipe da [Escola de Dados](https://escoladedados.org/courses/python-para-inovacao-civica/), por oferecer esse curso. Além disso, gostaria de agradecer especialmente à instrutora da semana: [Ana Cecília Vieira](https://twitter.com/cecivieira).

## Como interagir?

Atualmente, não está funcionando a opção de comentários. Então se quiser comentar/interagir, recomendo que faça nessa thread, onde estou falando sobre essa série de posts:

<center>
<blockquote class="twitter-tweet" data-width="550" data-lang="en" data-dnt="true" data-theme="light"><p lang="pt" dir="ltr">Tô aprendendo Python no curso de Python pra Inovação cívica da <a href="https://twitter.com/EscolaDeDados?ref_src=twsrc%5Etfw">@EscolaDeDados</a> , e escrevi um post pra me ajudar a fixar o conteúdo. O post é comparando o que é ensinado sobre Python, com as formas que fazemos em R.<br>Obrigada  <a href="https://twitter.com/cecivieira?ref_src=twsrc%5Etfw">@cecivieira</a> e  <a href="https://twitter.com/EscolaDeDados?ref_src=twsrc%5Etfw">@EscolaDeDados</a>!<a href="https://t.co/EFLjAvPwMl">https://t.co/EFLjAvPwMl</a></p>&mdash; Beatriz Milz (@BeaMilz) <a href="https://twitter.com/BeaMilz/status/1424188713974829056?ref_src=twsrc%5Etfw">August 8, 2021</a></blockquote>

</center>

-   [Veja a thread completa neste link!](https://twitter.com/BeaMilz/status/1424188713974829056?s=20)
