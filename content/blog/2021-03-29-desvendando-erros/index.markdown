---
title: "Desvendando erros: Entendendo mensagens de erro comuns em R"
excerpt: "Post publicado no blog da Curso-R. Esse post tem como objetivo listar alguns erros comuns quando programamos em R, e dicas de como resolvê-los!"
author: "Beatriz Milz e Fernando Corrêa"
date: 2021-03-29
output:
  distill::distill_article:
    self_contained: false
categories:
  - R
  - Erros
---





Leia o post no blog da Curso-R: [acesse aqui!](https://blog.curso-r.com/posts/2021-03-29-desvendando-erros/)





Quando estamos programando, é muito comum executar algum código e ele gerar um erro! Algumas vezes é difícil entender as mensagens de erro para começar a buscar ajuda, e isso pode atrasar nossas tarefas (e também nos desanimar).

<div class="figure" style="text-align: center">
<img src="https://github.com/allisonhorst/stats-illustrations/blob/master/rstats-artwork/stormyr.gif?raw=true" alt="Ilustração por &lt;a href='https://github.com/allisonhorst/stats-illustrations'&gt;Allison Horst&lt;/a&gt;" width="80%" />
<p class="caption">Figure 1: Ilustração por <a href='https://github.com/allisonhorst/stats-illustrations'>Allison Horst</a></p>
</div>

Principalmente quando estamos iniciando a nossa jornada de aprendizagem de R, alguns erros podem ser mais frequentes. Esse post tem como objetivo listar alguns desses erros comuns, baseado na minha experiência aprendendo e ensinando R, e também respondendo dúvidas :)

Vamos então ler um pouco sobre alguns erros frequentes, e como resolvê-los? Prepara um café ou chá, e vamos lá! ☕


## Objeto não encontrado

Imagine que queremos calcular a média do orçamento dos filmes que fazem parte da base de dados sobre filmes do IMDB, e recebemos o seguinte erro:

``` r
mean(imdb$orcamento, na.rm = TRUE)
#> Error in mean(imdb$orcamento, na.rm = TRUE): objeto 'imdb' não encontrado
```
<sup>Created on 2021-03-26 by the [reprex package](https://reprex.tidyverse.org) (v1.0.0)</sup>

O R está dizendo para nós que não está encontrando o objeto `imdb`! Como podemos resolver esse erro? Precisamos carregar esse objeto no nosso ambiente, para que ele esteja disponível para uso!

Para isso, precisamos usar o sinal de atribuição: `<-`.

No exemplo abaixo, importamos o arquivo `imdb.csv` e salvamos essa base de dados no objeto `imdb`. Dessa forma, não obtemos um erro quando tentamos calcular a média da mesma forma que fizemos anteriormente, pois o objeto será encontrado e o código conseguirá ser executado!


```r
imdb <- readr::read_csv2("https://raw.githubusercontent.com/curso-r/202010-r4ds-1/master/dados/imdb2.csv")

mean(imdb$orcamento, na.rm = TRUE)
## [1] 35237114
```


## Não foi possível encontrar a função "..."

Já tentou executar um código e o retorno foi essa mensagem de erro? 

``` r
glimpse(imdb)
#> Error in glimpse(imdb): não foi possível encontrar a função "glimpse"
```

<sup>Created on 2021-03-26 by the [reprex package](https://reprex.tidyverse.org) (v1.0.0)</sup>

Isso significa que o R não encontrou essa função. No R, podemos instalar pacotes que contém funções para que a gente utilize nas nossas rotinas. Porém, é preciso carregar o pacote para que as funções do mesmo fiquem disponíveis para uso. Podemos carregar um pacote utilizando a função `library()`.

No exemplo abaixo, a função `glimpse()` faz parte do pacote `{dplyr}`. Carregando o pacote no início do código deixará todas as funções do pacote `{dplyr}` disponíveis para uso (incluindo a função que queremos usar): 



```r
library(dplyr)
glimpse(imdb)
## Rows: 3,713
## Columns: 15
## $ titulo         <chr> "Avatar ", "Pirates of the Caribbean: At World's End ",…
## $ ano            <dbl> 2009, 2007, 2012, 2012, 2007, 2010, 2015, 2016, 2006, 2…
## $ diretor        <chr> "James Cameron", "Gore Verbinski", "Christopher Nolan",…
## $ duracao        <dbl> 178, 169, 164, 132, 156, 100, 141, 183, 169, 151, 150, …
## $ cor            <chr> "Color", "Color", "Color", "Color", "Color", "Color", "…
## $ generos        <chr> "Action|Adventure|Fantasy|Sci-Fi", "Action|Adventure|Fa…
## $ pais           <chr> "USA", "USA", "USA", "USA", "USA", "USA", "USA", "USA",…
## $ classificacao  <chr> "A partir de 13 anos", "A partir de 13 anos", "A partir…
## $ orcamento      <dbl> 237000000, 300000000, 250000000, 263700000, 258000000, …
## $ receita        <dbl> 760505847, 309404152, 448130642, 73058679, 336530303, 2…
## $ nota_imdb      <dbl> 7.9, 7.1, 8.5, 6.6, 6.2, 7.8, 7.5, 6.9, 6.1, 7.3, 6.5, …
## $ likes_facebook <dbl> 33000, 0, 164000, 24000, 0, 29000, 118000, 197000, 0, 5…
## $ ator_1         <chr> "CCH Pounder", "Johnny Depp", "Tom Hardy", "Daryl Sabar…
## $ ator_2         <chr> "Joel David Moore", "Orlando Bloom", "Christian Bale", …
## $ ator_3         <chr> "Wes Studi", "Jack Davenport", "Joseph Gordon-Levitt", …
```

Outra forma de utilizar a função sem que seja necessário carregar o pacote, é utilizando o operador `::` (você pode ler mais sobre ele [neste capítulo do livro Zen do R](https://curso-r.github.io/zen-do-r/funcoes-deps.html#quatro-pontos)). 

Leia o código abaixo como: quero usar a função `glimpse()` do pacote `dplyr` 


```r
dplyr::glimpse(imdb)
## Rows: 3,713
## Columns: 15
## $ titulo         <chr> "Avatar ", "Pirates of the Caribbean: At World's End ",…
## $ ano            <dbl> 2009, 2007, 2012, 2012, 2007, 2010, 2015, 2016, 2006, 2…
## $ diretor        <chr> "James Cameron", "Gore Verbinski", "Christopher Nolan",…
## $ duracao        <dbl> 178, 169, 164, 132, 156, 100, 141, 183, 169, 151, 150, …
## $ cor            <chr> "Color", "Color", "Color", "Color", "Color", "Color", "…
## $ generos        <chr> "Action|Adventure|Fantasy|Sci-Fi", "Action|Adventure|Fa…
## $ pais           <chr> "USA", "USA", "USA", "USA", "USA", "USA", "USA", "USA",…
## $ classificacao  <chr> "A partir de 13 anos", "A partir de 13 anos", "A partir…
## $ orcamento      <dbl> 237000000, 300000000, 250000000, 263700000, 258000000, …
## $ receita        <dbl> 760505847, 309404152, 448130642, 73058679, 336530303, 2…
## $ nota_imdb      <dbl> 7.9, 7.1, 8.5, 6.6, 6.2, 7.8, 7.5, 6.9, 6.1, 7.3, 6.5, …
## $ likes_facebook <dbl> 33000, 0, 164000, 24000, 0, 29000, 118000, 197000, 0, 5…
## $ ator_1         <chr> "CCH Pounder", "Johnny Depp", "Tom Hardy", "Daryl Sabar…
## $ ator_2         <chr> "Joel David Moore", "Orlando Bloom", "Christian Bale", …
## $ ator_3         <chr> "Wes Studi", "Jack Davenport", "Joseph Gordon-Levitt", …
```

## Argumento não numérico para operador binário / non-numeric argument to binary operator

De toda a nossa lista de problemas, esse é aquele com a mensagem de erro mais complicada. Você já tentou fazer algum cálculo como esse abaixo e o retorno foi essa mensagem de erro?

``` r
x <- "a"
x+1
#> Error in x + 1: argumento não-numérico para operador binário
```

<sup>Created on 2021-03-29 by the [reprex package](https://reprex.tidyverse.org) (v0.3.0)</sup>

Isso é muito comum, principalmente quando estamos trabalhando em scripts mais longos, e essa mensagem de erro é o R tentando nos avisar que nós estamos passando um texto, no caso a letra "a", para uma operação que espera receber um número. Na verdade, o R é até um pouco mais preciso: a operação esperava um número e nós frustramos essa expectativa, por isso o erro menciona um "argumento não-numérico". No caso nós tentamos fazer uma conta (a adição representada pelo símbolo `+`) usando um texto.

O que podemos fazer quando esse erro aparece? Minha recomendação é examinar o seu código para verificar que tipo de argumento as suas operações matemáticas (por exemplo `+`, `-`, `*` e `^`) estão recebendo. Muito provavelmente algum desses argumentos não é um número...

## Conflito de funções



Um problema silencioso que pode acontecer é o conflito de funções. Esse tipo de erro é um pouco mais complicado de identificar pois a mensagem de erro causada por esse problema não é padronizada.

**Mas o que é um conflito de funções?**

O R permite que a gente instale e carregue diversos pacotes. E esses pacotes podem ter funções com nomes iguais.

Por exemplo, o pacote `{dplyr}` possui uma função chamada `filter()`, assim como o pacote `{base}` também tem uma função com o mesmo nome (o `{base}` sempre está carregado quando iniciamos o R).

Quando usamos uma função sem usar o operador `::`, o R vai buscar no ambiente a função com esse nome que foi carregada por último. Então podemos usar uma função A quando queremos realmente usar a função B.

Exemplo: queremos filtrar os filmes do diretor Zack Snyder. Obtemos esse erro dizendo que o objeto imdb não foi encontrado, porém o objeto está carregado!

``` r
filter(imdb, diretor == "Zack Snyder")
#> Error in as.ts(x): objeto 'imdb' não encontrado
```
<sup>Created on 2021-03-26 by the [reprex package](https://reprex.tidyverse.org) (v1.0.0)</sup>

Isso acontece pois o R utilizou a função `filter()` do pacote `{base}`, e não a função `filter()` do pacote `{dplyr}`!


Uma forma de evitar esses erros de conflitos é utilizar o operador `::`, que foi citado anteriormente. Assim estamos falando explicitamente em qual pacote essa função está:


```r
dplyr::filter(imdb, diretor == "Zack Snyder")
## # A tibble: 7 x 15
##   titulo      ano diretor  duracao cor   generos   pais  classificacao orcamento
##   <chr>     <dbl> <chr>      <dbl> <chr> <chr>     <chr> <chr>             <dbl>
## 1 Batman v…  2016 Zack Sn…     183 Color Action|A… USA   A partir de … 250000000
## 2 Man of S…  2013 Zack Sn…     143 Color Action|A… USA   A partir de … 225000000
## 3 Watchmen   2009 Zack Sn…     215 Color Action|D… USA   A partir de … 130000000
## 4 Legend o…  2010 Zack Sn…     101 Color Action|A… USA   Livre          80000000
## 5 Sucker P…  2011 Zack Sn…     128 Color Action|F… USA   A partir de …  82000000
## 6 300        2006 Zack Sn…     117 Color Action|D… USA   A partir de …  65000000
## 7 Dawn of …  2004 Zack Sn…     110 Color Action|H… USA   A partir de …  26000000
## # … with 6 more variables: receita <dbl>, nota_imdb <dbl>,
## #   likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```


## Não existe um pacote chamado ... / There is no package called .. 

Quando queremos carregar um pacote, e ele não está instalado, o erro gerado é esse:

``` r
library(tidyverse)
#> Error in library(tidyverse) : there is no package called ‘tidyverse’
```

<sup>Created on 2021-03-26 by the [reprex package](https://reprex.tidyverse.org) (v1.0.0)</sup>


Como resolver? Precisamos instalar o pacote!

A forma mais comum de instalação de um pacote é através do CRAN, utilizando a função `install.packages()`:

``` r
install.packages("tidyverse")
```

Após instalar o pacote, conseguiremos carregá-lo normalmente!

``` r
library(tidyverse)
#> ── Attaching packages ───── tidyverse 1.3.0 ──
#> ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
#> ✓ tibble  3.1.0     ✓ dplyr   1.0.5
#> ✓ tidyr   1.1.3     ✓ stringr 1.4.0
#> ✓ readr   1.4.0     ✓ forcats 0.5.1
#> ── Conflicts ──────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
```

## O pacote ... não está disponível para essa versão do R / Package '...' is not available for this version of R 

Nesse exemplo, mostraremos um caso onde não é gerado um erro, e sim uma mensagem de aviso (*warning*). Entretanto, o código não executa como esperamos, e pode impossibilitar a execução das etapas seguintes dos scripts.

Imagine que queremos calcular a média da massa corporal dos Pinguins que fazem parte da base de dados sobre [Pinguins](https://cienciadedatos.github.io/dados/reference/pinguins.html), disponível no pacote {[dados](https://cienciadedatos.github.io/dados/)}.

``` r
install.packages("dados")
#> Warning: package 'dados' is not available for this version of R
#> 
#> A version of this package for your version of R might be available elsewhere,
#> see the ideas at
#> https://cran.r-project.org/doc/manuals/r-patched/R-admin.html#Installing-packages
```
<sup>Created on 2021-03-26 by the [reprex package](https://reprex.tidyverse.org) (v1.0.0)</sup>

Essa mensagem acontece quando queremos instalar um pacote que não está disponível no CRAN. 
O que eu recomendo, neste caso, é buscar o repositório no GitHub do pacote desejado.

No caso do pacote que estamos mostrando neste exemplo, [este é o link do repositório](https://github.com/cienciadedatos/dados).

Caso queira instalar o pacote através do GitHub, devemos utilizar a função `install_github()` do pacote `{remotes}`. Como argumento, devemos informar a organização ou pessoa a quem este repositório "pertence", e o nome do repositório: `"nome_da_organizacao/nome_do_repositorio"`. No caso do pacote `{dados}`, a organização é [cienciadedatos](https://github.com/cienciadedatos), e o repositório é chamado de [dados](https://github.com/cienciadedatos/dados). Portanto, para instalar esse pacote, devemos executar o código a seguir: 

``` r
remotes::install_github("cienciadedatos/dados")
```

Agora conseguimos utilizar funções e bases de dados do pacote `dados`:


```r
library(dados)
mean(pinguins$massa_corporal, na.rm = TRUE)
## [1] 4201.754
```


## O arquivo ... não existe no diretório de trabalho atual / ... does not exist in current working directory

E quando queremos importar uma base de dados (ou outro arquivo) para trabalhar no R, e recebemos essa mensagem?

``` r
imdb <- readr::read_csv2("imdb2.csv")
#> i Using ',' as decimal and '.' as grouping mark. Use `read_delim()` for more control.
#> Error: 'imdb2.csv' does not exist in current working directory ('C:/Users/seu_usuario/Documents').
```

<sup>Created on 2021-03-29 by the [reprex package](https://reprex.tidyverse.org) (v0.3.0)</sup>

O R está informando que não encontrou o arquivo que a gente deseja importar. A maior parte das vezes quando esse erro acontece é por que 1) esse arquivo não existe no nosso computador, ou 2) estamos indicando o caminho incorreto até o arquivo.


<div class="figure" style="text-align: center">
<img src="https://github.com/allisonhorst/stats-illustrations/blob/master/rstats-artwork/cracked_setwd.png?raw=true" alt="Ilustração sobre projetos no RStudio, por &lt;a href='https://github.com/allisonhorst/stats-illustrations'&gt;Allison Horst&lt;/a&gt;" width="80%" />
<p class="caption">Figure 2: Ilustração sobre projetos no RStudio, por <a href='https://github.com/allisonhorst/stats-illustrations'>Allison Horst</a></p>
</div>

Vamos considerar que já sabemos que o arquivo existe no computador, e trabalhar na resolução da segunda opção: precisamos corrigir o caminho até o arquivo. 
É muito mais fácil lidar com isso quando trabalhamos com projetos no RStudio (`.Rproj`). Recomendo muito ler [desse capítulo do livro Zen do R](https://curso-r.github.io/zen-do-r/rproj-dir.html#diret%C3%B3rio-de-trabalho), pois fala bastante sobre as vantagens dessa abordagem.

Quando trabalhamos com projetos no RStudio (`.Rproj`), os caminhos são relativos à pasta raiz do projeto. Recomendo adicionar dentro do seu projeto o arquivo que deseja abrir. E para descobrir o caminho, existe uma super dica: o RStudio nos ajuda a navegar nos arquivos presentes no nosso projeto. É necessário escrever duas aspas `""`, posicionar o mouse entre elas (isso é, clicando entre as suas aspas como se a gente fosse escrever algo dentro delas), e apertar a tecla TAB do teclado. O RStudio abrirá janelinha que possibilitará que a gente navegue nos arquivos do nosso projeto dessa forma.



Descobrindo o caminho correto, podemos importar a base sem que aquele erro seja gerado!

``` r
imdb <- readr::read_csv2("dados/imdb2.csv")
#> ℹ Using ',' as decimal and '.' as grouping mark. Use `read_delim()` for more control.
#> 
#> ── Column specification ────────────────────────────────────────────────────────
#> cols(
#>   titulo = col_character(),
#>   ano = col_double(),
#>   diretor = col_character(),
#>   duracao = col_double(),
#>   cor = col_character(),
#>   generos = col_character(),
#>   pais = col_character(),
#>   classificacao = col_character(),
#>   orcamento = col_double(),
#>   receita = col_double(),
#>   nota_imdb = col_double(),
#>   likes_facebook = col_double(),
#>   ator_1 = col_character(),
#>   ator_2 = col_character(),
#>   ator_3 = col_character()
#> )
```
<sup>Created on 2021-03-26 by the [reprex package](https://reprex.tidyverse.org) (v1.0.0)</sup>


## Conclusão

Espero que essas dicas sejam úteis para você resolver os erros no futuro, e você seja mais feliz enquanto escreve seus códigos em R! E caso ainda tenha dúvidas, recomendo perguntar lá no [Fórum Discourse da Curso-R](https://discourse.curso-r.com/)!


<div class="figure" style="text-align: center">
<img src="https://github.com/allisonhorst/stats-illustrations/blob/master/rstats-artwork/heartyr.gif?raw=true" alt="Ilustração por &lt;a href='https://github.com/allisonhorst/stats-illustrations'&gt;Allison Horst&lt;/a&gt;" width="80%" />
<p class="caption">Figure 3: Ilustração por <a href='https://github.com/allisonhorst/stats-illustrations'>Allison Horst</a></p>
</div>

## Gostou? Quer saber mais?

Se você quiser aprender um pouco mais sobre R em geral, dê uma olhada nos [Cursos da Curso-R](https://curso-r.com/#portfolio) e aproveite! 

