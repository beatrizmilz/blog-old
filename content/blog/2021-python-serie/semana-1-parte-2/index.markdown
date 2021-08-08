---
title: "Estudando Python - Semana 1, Parte 2"
excerpt: "Este posts é uma forma de documentar alguns aprendizados na minha trajetória estudando Python. Estou fazendo o curso de [Python para inovação cívica](https://escoladedados.org/courses/python-para-inovacao-civica/), oferecido pela [Escola de Dados](https://escoladedados.org/)."
draft: FALSE
author: "Beatriz Milz"
date: '2021-08-08'
categories: ["Portugues", "Python", "Estudo", "Reticulate"]
---

<script src="{{< blogdown/postref >}}index_files/core-js/shim.min.js"></script>
<script src="{{< blogdown/postref >}}index_files/react/react.min.js"></script>
<script src="{{< blogdown/postref >}}index_files/react/react-dom.min.js"></script>
<script src="{{< blogdown/postref >}}index_files/reactwidget/react-tools.js"></script>
<script src="{{< blogdown/postref >}}index_files/htmlwidgets/htmlwidgets.js"></script>
<script src="{{< blogdown/postref >}}index_files/reactable-binding/reactable.js"></script>
<script src="{{< blogdown/postref >}}index_files/core-js/shim.min.js"></script>
<script src="{{< blogdown/postref >}}index_files/react/react.min.js"></script>
<script src="{{< blogdown/postref >}}index_files/react/react-dom.min.js"></script>
<script src="{{< blogdown/postref >}}index_files/reactwidget/react-tools.js"></script>
<script src="{{< blogdown/postref >}}index_files/htmlwidgets/htmlwidgets.js"></script>
<script src="{{< blogdown/postref >}}index_files/reactable-binding/reactable.js"></script>
<script src="{{< blogdown/postref >}}index_files/core-js/shim.min.js"></script>
<script src="{{< blogdown/postref >}}index_files/react/react.min.js"></script>
<script src="{{< blogdown/postref >}}index_files/react/react-dom.min.js"></script>
<script src="{{< blogdown/postref >}}index_files/reactwidget/react-tools.js"></script>
<script src="{{< blogdown/postref >}}index_files/htmlwidgets/htmlwidgets.js"></script>
<script src="{{< blogdown/postref >}}index_files/reactable-binding/reactable.js"></script>
<script src="{{< blogdown/postref >}}index_files/twitter-widget/widgets.js"></script>

## Introdução

Olá!

Esse post faz parte de uma série de posts, que tem como objetivo documentar alguns aprendizados na minha trajetória estudando Python. Estou fazendo o curso de [Python para inovação cívica](https://escoladedados.org/courses/python-para-inovacao-civica/), oferecido pela [Escola de Dados](https://escoladedados.org/). Eu já programo em R, portanto muitas das anotações serão feitas comparando como é feito em R e em Python, assim acho que fica mais fácil para eu fazer as conexões conceituais e lembrar mais fácil depois.

Esse é o segundo post, então caso não tenha lido o primeiro ainda, [acesse esse link](https://beatrizmilz.com/blog/2021-python-serie/semana-1-parte-1/)!

## Operadores

No curso foram apresentadas tabelas mostrando os operadores em Python, a descrição e exemplos de uso. Para mostrar as diferenças, fiz outras tabelas me inspirando nas tabelas do curso, mas falando destacando os operadores que são representados de forma diferente em R e Python (em negrito).

> Se você tem interesse em saber mais sobre esses operadores em R, [este](https://livro.curso-r.com/3-2-r-como-calculadora.html) e [este capítulo](https://livro.curso-r.com/3-7-testes-l%C3%B3gicos.html) do livro [Ciência de Dados em R](https://livro.curso-r.com/index.html) é muito útil!

### Operadores aritméticos

Alguns dos operadores aritméticos básicos são representados de forma diferente em Python e R: de divisão inteira, resto de divisão e de potenciação.

<div id="htmlwidget-1" class="reactable html-widget" style="width:auto;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-1">{"x":{"tag":{"name":"Reactable","attribs":{"data":{"Descrição":["Soma","Subtração","Multiplicação","Divisão","Divisão inteira","Resto da divisão","Potenciação"],"R":["+","-","*","/","%/%","%%","** ou ^"],"Python":["+","-","*","/","//","%","**"]},"columns":[{"accessor":"Descrição","name":"Descrição","type":"character"},{"accessor":"R","name":"R","type":"character"},{"accessor":"Python","name":"Python","type":"character"}],"defaultPageSize":10,"paginationType":"numbers","showPageInfo":true,"minRows":1,"rowStyle":[null,null,null,null,{"fontWeight":"bold","background":"rgba(0, 0, 0, 0.03)"},{"fontWeight":"bold","background":"rgba(0, 0, 0, 0.03)"},{"fontWeight":"bold","background":"rgba(0, 0, 0, 0.03)"}],"dataKey":"e30d5be3d8949dde32cdd10ab2fe0b84","key":"e30d5be3d8949dde32cdd10ab2fe0b84"},"children":[]},"class":"reactR_markup"},"evals":[],"jsHooks":[]}</script>

> Se você tem interesse em saber mais sobre esses operadores em R, [este capítulo](https://livro.curso-r.com/3-2-r-como-calculadora.html) do livro [Ciência de Dados em R](https://livro.curso-r.com/index.html) é muito útil!

### Operadores relacionais

Os operadores relacionais apresentados no curso são representados de forma igual em R e Python!

<div id="htmlwidget-2" class="reactable html-widget" style="width:auto;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-2">{"x":{"tag":{"name":"Reactable","attribs":{"data":{"Descrição":["Maior que ","Maior ou igual a","Menor que","Maior ou igual a","Igual a","Diferente de"],"Operador":[">",">=","<","<=","==","!="]},"columns":[{"accessor":"Descrição","name":"Descrição","type":"character"},{"accessor":"Operador","name":"Operador","type":"character"}],"defaultPageSize":10,"paginationType":"numbers","showPageInfo":true,"minRows":1,"dataKey":"000d91bd397e051a999e54e79c8a1e0d","key":"000d91bd397e051a999e54e79c8a1e0d"},"children":[]},"class":"reactR_markup"},"evals":[],"jsHooks":[]}</script>

### Operadores lógicos

Já os operadores lógicos são representados de forma diferente nas duas linguagens! Veja a tabela:

<div id="htmlwidget-3" class="reactable html-widget" style="width:auto;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-3">{"x":{"tag":{"name":"Reactable","attribs":{"data":{"Descrição":["E","Ou","Negação"],"R":["&","|","!"],"Python":["and","or","not"]},"columns":[{"accessor":"Descrição","name":"Descrição","type":"character"},{"accessor":"R","name":"R","type":"character"},{"accessor":"Python","name":"Python","type":"character"}],"defaultPageSize":10,"paginationType":"numbers","showPageInfo":true,"minRows":1,"rowStyle":[{"fontWeight":"bold","background":"rgba(0, 0, 0, 0.03)"},{"fontWeight":"bold","background":"rgba(0, 0, 0, 0.03)"},{"fontWeight":"bold","background":"rgba(0, 0, 0, 0.03)"}],"dataKey":"b5c1455120f555dc1baaba752ad06faf","key":"b5c1455120f555dc1baaba752ad06faf"},"children":[]},"class":"reactR_markup"},"evals":[],"jsHooks":[]}</script>

## Selecionando elementos de uma lista

Percebi uma diferença sutil e interessante em um exemplo de exercício! É possível selecionar as letras dentro dos elementos das listas em Python usando colchetes e o índex.

<div class="figure" style="text-align: center">

<img src="https://media.giphy.com/media/69jvP3VXUYhr3YUYu9/giphy.gif" alt="Gif do desenho Scooby-doo, onde Scooby e seus amigos estão olhando para um livro e depois para a câmera!"  />
<p class="caption">
Figure 1: Gif do desenho Scooby-doo, onde Scooby e seus amigos estão olhando para um livro e depois para a câmera!
</p>

</div>

Veja o exemplo:

``` python
# Em Python...

# Criamos uma lista
nome_linguagens = ['Python', 'R', 'Julia']

# Podemos selecionar elementos dentro de uma lista 
# usando colchetes e o índex 
nome_linguagens[0]
```

    'Python'

``` python
# Em Python...
# E podemos selecionar as letras dentro desse elemento
# usando colchetes e o índex novamente!
nome_linguagens[0][0]
```

    'P'

Se tentarmos a mesma coisa nos vetores em R não funcionará da mesma forma.

``` r
# Em R...

# criamos um vetor
nome_linguagens <- c('Python', 'R', 'Julia')

# selecionamos o primeiro elemento do vetor
nome_linguagens[1]
```

    [1] "Python"

``` r
# se usarmos essa mesma sintaxe das listas em Python,
# o valor retornado ainda será o elemento completo:
nome_linguagens[1][1]
```

    [1] "Python"

Uma forma de fazer a mesma coisa com R base seria com a função `substring()`, mas achei mais fácil em Python neste caso. Interessante, né?

``` r
# Em R base:
substring(nome_linguagens[1], 1, 1)
```

    [1] "P"

## A função `print()` é equivalente?

Outra diferença que percebi é que a função `print()` em Python permite que a gente “cole” elementos para criar a frase:

``` python
# Em Python...
nome = 'Beatriz'
print('Prazer, meu nome é', nome, '!')
```

    Prazer, meu nome é Beatriz !

Na versão em R da função `print()`, isso gera um erro:

``` r
# Em R...
nome <- "Beatriz"
print("Prazer, meu nome é", nome, "!")
# > Error in print.default("Prazer, meu nome é", nome, "!") :
# invalid printing digits -2147483648
```

Para isso podemos usar a função `paste()` ou `paste0()`:

``` r
# Em R...
nome <- "Beatriz"
paste0("Prazer, meu nome é ", nome, "!")
```

    [1] "Prazer, meu nome é Beatriz!"

## Print com `f'`

Em Python, existe a função `print()`, assim como em R. Porém é possível usar junto com o `f'`, que representa uma formatação de string/textos. Veja o exemplo:

``` python
# Em Python

# Criei duas variáveis que serão usadas no print()
nome = 'Beatriz'
idade = 28

# printo uma frase usando f', e no lugar que desejo
# que o resultado das variáveis apareça, escrevo o
# nome da variável entre chaves: {}

print(f'Olá, meu nome é {nome} e tenho {idade} anos!')
```

    Olá, meu nome é Beatriz e tenho 28 anos!

Se você se interessar por esse tema, [veja a documentação do Python neste link](https://docs.python.org/3.6/reference/lexical_analysis.html#formatted-string-literals). Um comentário importante é que é possível utilizar o `f'` em outras situações além de junto com a função `print()`.

Eu achei um pouco peculiar poder adicinar uma letra comum “perdida” no código, sem adicionar nenhum marcador de que é um operador, e funcionar magicamente. Porém confesso que eu gosto muito dessa possibilidade de escrever tudo dentro de uma única aspas e colocar as variáveis dentro de chaves, e essa sintaxe é similar à forma que usamos com a função [`glue()`](https://glue.tidyverse.org/reference/glue.html) do pacote [{glue}](https://glue.tidyverse.org/) em R:

``` r
# Em R...

nome <- "Beatriz"
idade <- "28"
glue::glue("Olá, meu nome é {nome} e tenho {idade} anos!")
```

    Olá, meu nome é Beatriz e tenho 28 anos!

Se a gente quisesse fazer a mesma coisa usando R base (ou seja, sem depender de pacotes que é necessário instalar), é possível usar a função `paste0()`, porém ela não oferece a possibilidade de usar as chaves `{}` e o código fica bem menos elegante!

``` r
# Em R...
paste0("Olá, meu nome é ", nome, " e tenho ", idade, " anos!")
```

    [1] "Olá, meu nome é Beatriz e tenho 28 anos!"

## Método `.append()` em Python

Uma coisa que ainda não está clara pra mim é: qual a diferença entre um método em Python e uma função? Pelo que li na [documentação](https://docs.python.org/pt-br/3/tutorial/classes.html), um método é *“uma função que “pertence” a um objeto instância."*. Porém ainda não entendi o que é objeto instância que a documentação aborda. Quem sabe em outro post eu já tenha entendido melhor haha

O que eu notei sobre métodos é que é usado de uma forma diferente da forma que usamos funções, com a seguinte sintaxe: `nome_do_objeto.nome_do_metodo(argumentos)`.

<div class="figure" style="text-align: center">

<img src="tapassada.jpeg" alt="Meme do essemenino, retirado do video onde ele representa a Pfizer enviando emails para o presidente do Brasil, escrito: 'tá passada?'." width="30%" />
<p class="caption">
Figure 2: Meme do essemenino, retirado do video onde ele representa a Pfizer enviando emails para o presidente do Brasil, escrito: ‘tá passada?’
</p>

</div>

Mas como eu cheguei nos métodos?
Em Python, se temos uma lista e queremos adicionar um elemento à ela, podemos usar o método `.append()`, que foi abordado em um exemplo do curso e eu fiquei curiosa e fui pesquisar mais sobre.

Vamos ver um exemplo de uso:

``` python
# Em Python...

# Criamos uma lista com nome de 3 linguagens usadas em 
# ciência de dados
nome_linguagens = ['Python', 'R', 'Julia']

# Se queremos adicionar mais uma linguagem, podemos usar o 
# método append()

nome_linguagens.append("SQL")
```

``` python
# Se queremos conferir quais são os elementos da lista,
# podemos escrever o nome e executar:
nome_linguagens
```

    ['Python', 'R', 'Julia', 'SQL']

Curioso.. O método `.append()` adicionou um elemento à lista sem precisar usar o operador de atribuição (`=`).

Vamos ver uma situação similar em R: primeiramente, eu não lembrava de uma função chamada `append()` em R, e fui pesquisar. E ela existe! Porém ela não funciona da mesma forma:

``` r
# Em R...
# Criamos um vetor com nome de 3 linguagens usadas em 
# ciência de dados
nome_linguagens <- c('Python', 'R', 'Julia')

# usamos a função append, de uma forma equivalente
append(nome_linguagens, "SQL")
```

    [1] "Python" "R"      "Julia"  "SQL"   

``` r
# Se queremos conferir quais são os elementos do vetor,
# podemos escrever o nome e executar:
nome_linguagens
```

    [1] "Python" "R"      "Julia" 

Veja só, a função `append()` em R, por si só, não atualiza o vetor. É necessário usar o operador de atribuição para que isso funcione:

``` r
# Em R..
# usamos a função append
nome_linguagens <- append(nome_linguagens, "SQL")

# Se queremos conferir quais são os elementos do vetor,
# podemos escrever o nome e executar:
nome_linguagens
```

    [1] "Python" "R"      "Julia"  "SQL"   

Essa é uma diferença interessante! Agora sim o elemento foi adicionado, e isso me fez entender a razão de não ver as pessoas usarem a função `append()` em R: pois é mais fácil fazer a mesma coisa usando a função `c()` para concatenar valores. Veja o exemplo:

``` r
# Em R..
# Criamos o vetor nome_linguagens
nome_linguagens <- c('Python', 'R', 'Julia')

# Usamos a função c() para adicionar mais elementos
nome_linguagens <- c(nome_linguagens, "SQL")

# Se queremos conferir quais são os elementos do vetor,
# podemos escrever o nome e executar:
nome_linguagens
```

    [1] "Python" "R"      "Julia"  "SQL"   

Pois é, em R é mais fácil usar a função `c()` do que a função `append()`. Mas achei bem interessante a forma de uso do método `.append()` em Python. Na minha opinião, por um lado o método `.append()` em Python possibilita que o código fique mais curto. Porém eu gosto de utilizar a atribuição, pois deixa mais explícito que alteramos um objeto.

## Conclusão

Novamente, esse post ficou imenso e ainda não terminei de registrar as diferenças que encontrei entre R e Python na semana 1 do curso. Então provavelmente ainda escreverei mais posts para continuar a documentar esse processo!

Espero que esse post seja útil para pessoas que, assim como eu, já programam em R e querem aprender Python.

## Agradecimentos

Agradeço muito à equipe da [Escola de Dados](https://escoladedados.org/courses/python-para-inovacao-civica/), por oferecer esse curso. Além disso, gostaria de agradecer especialmente à instrutora da semana: [Ana Cecília Vieira](https://twitter.com/cecivieira).

## Como interagir?

Atualmente, não está funcionando a opção de comentários. Então se quiser comentar/interagir, recomendo que faça nessa thread, onde estou falando sobre essa série de posts:

<center>
<blockquote class="twitter-tweet" data-width="550" data-lang="en" data-dnt="true" data-theme="light"><p lang="pt" dir="ltr">Tô aprendendo Python no curso de Python pra Inovação cívica da <a href="https://twitter.com/EscolaDeDados?ref_src=twsrc%5Etfw">@EscolaDeDados</a> , e escrevi um post pra me ajudar a fixar o conteúdo. O post é comparando o que é ensinado sobre Python, com as formas que fazemos em R.<br>Obrigada  <a href="https://twitter.com/cecivieira?ref_src=twsrc%5Etfw">@cecivieira</a> e  <a href="https://twitter.com/EscolaDeDados?ref_src=twsrc%5Etfw">@EscolaDeDados</a>!<a href="https://t.co/EFLjAvPwMl">https://t.co/EFLjAvPwMl</a></p>&mdash; Beatriz Milz (@BeaMilz) <a href="https://twitter.com/BeaMilz/status/1424188713974829056?ref_src=twsrc%5Etfw">August 8, 2021</a></blockquote>

</center>

-   [Veja a thread completa neste link!](https://twitter.com/BeaMilz/status/1424188713974829056?s=20)
