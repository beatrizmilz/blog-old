---
title: "Experimentando o R 4.1.0"
excerpt: "Primeiras impressões ao usar o nova versão do R"
author: "Beatriz Milz"
categories:
  - RStudio
  - R
  - Pipe
date: 2021-05-18
---
<link href="{{< blogdown/postref >}}index_files/panelset/panelset.css" rel="stylesheet" />
<script src="{{< blogdown/postref >}}index_files/panelset/panelset.js"></script>






## Introdução

A versão do 4.1.0 do R foi lançada **hoje** (dia 18 de maio de 2021), e a comunidade está bem animada com a chegada do pipe `|>` no R base!

Esse post **não** tem como objetivo explicar quais foram as mudanças, e sim para apenas mostrar as primeiras impressões ao usar **a versão 4.1.0**! Caso você queira saber mais sobre as mudanças, recomendo esses textos:

- [Post "R 4.1: o novo pipe está chegando!", por Caio Lente, da Curso-R](https://blog.curso-r.com/posts/2021-05-06-o-novo-pipe-esta-chegando/)

- [Post "New features in R 4.1.0", blog da jumping rivers](https://www.jumpingrivers.com/blog/new-features-r410-pipe-anonymous-functions/)

- *edit*: [Video por Samuel Macêdo: Qual a diferença entre o pipe do magrittr e o do R base?](https://www.youtube.com/watch?v=6SZc4v0FDTw) 

Além disso,  amanhã acontecerá uma live no canal do Youtube da Curso-R (e eu pretendo participar):

<center>
<iframe width="560" height="315" src="https://www.youtube.com/embed/RPSLFU_5OGk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></center>


## Atalho do pipe no RStudio

Além de atualizar a versão do R para 4.1.0 ([veja mais aqui](https://www.r-project.org/)), eu também atualizei a versão do RStudio para a preview ([veja mais aqui](https://www.rstudio.com/products/rstudio/download/preview/)).

A versão preview apresenta a opção de atalho para o novo pipe, seguindo os passos: Tools > Global Options > Code > Use native pipe operator.

![](https://beatrizmilz.com/img/atalho_rstudio_novo_pipe.png)<!-- -->

Ativando essa opção, é possível usar o mesmo atalho de costume para escrever o pipe do R base: `Ctrl` + `Shift` + `M`!


## Exemplos!

Para experimentar, resolvi tentar adaptar os exemplos apresentados no [capítulo sobre o operador pipe](https://livro.curso-r.com/6-1-o-operador-pipe.html), do livro [Ciência de Dados em R](https://livro.curso-r.com/index.html), da qual sou contribuidora!

<a href='https://livro.curso-r.com/index.html'>
<img src="https://curso-r.com/images/produtos/hex-livro.png" width="30%" style="display: block; margin: auto;" />
</a>

Como vou apresentar o código original mostrado no livro (usando o pipe do `{magrittr}`) e a adaptação com pipe do R base, é necessário carregar o pipe do pacote `{magrittr}` para que os exemplos a seguir funcionem:


```r
# Esse argumento include.only é útil nesse caso,
# pois apenas a função %>% é carregada
library(magrittr, include.only = "%>%")
```

O primeiro exemplo do livro mostra algumas equivalências, e adiciono então uma terceira linha, mostrando a equivalência com o pipe do R base: substituimos o `%>%` do `{magrittr}`, pelo `|>` do R base!  


```r
f(x, y) # sem o pipe
x %>% f(y) # com o pipe do magrittr
x |> f(y) # com o pipe do R base
```

## Exemplo 1

No primeiro exemplo, apenas foi necessário substituir o pipe do magrittr `%>%` pelo pipe do R base `|>`:

Exemplo do livro: 

> Vamos calcular a raiz quadrada da soma dos valores de 1 a 4. Primeiro, sem o pipe.


```r
x <- c(1, 2, 3, 4)
```


::::: {.panelset}

::: {.panel}

## Sem pipe  {.sem-pipe}

```r
# Versão original do livro, sem usar o pipe
sqrt(sum(x))
```

```
## [1] 3.162278
```


:::
  
  
::: {.panel}

## Pipe magrittr {.pipe-magrittr}

```r
# Versão original do livro, com o pipe do magrittr
x %>% sum() %>% sqrt()
```

```
## [1] 3.162278
```


:::
  
::: {.panel}

## Versão adaptada com pipe do R base {.pipe-nativo}

```r
# Versão usando o pipe do R base
x |> sum() |> sqrt()
```

```
## [1] 3.162278
```

:::
  

:::::

Foi tranquilo!

## Exemplo 2

Neste próximo exemplo, não basta fazer a substituição feita no exemplo anterior. Isso acontece porque o pipe do magrittr aceita utilizar o ponto `.` (chamado de *dot placeholder* em inglês) para indicar onde o resultado recebido pelo pipe será substituído na próxima operação. Por outro lado, o pipe do R base não aceita essa forma.

Como o exemplo do livro utiliza o ponto `.`, isso teve que ser adaptado para que o código funcionasse! Essa adaptação ocorreu utilizando outra grande novidade do R 4.1.0: **as funções anônimas**: `\(x)`. Meu objetivo não é explicar aqui, mas recomendo fortemente que leia [texto do Caio Lente](https://blog.curso-r.com/posts/2021-05-06-o-novo-pipe-esta-chegando/), pois lá tem uma seção inteira sobre esse tema. 
Sinceramente não foi de primeira que eu acertei o uso da função anônima no exemplo abaixo, mas depois de olhar alguns outros exemplos, deu certo!

Exemplo do livro: 

> Queremos que o dataset seja recebido pelo segundo argumento (data=) da função "lm".


::::: {.panelset}

::: {.panel}

## Versão original do livro {.pipe-magrittr}

```r
# Versão original do livro usando o pipe do magrittr
airquality %>%
  na.omit() %>%
  lm(Ozone ~ Wind + Temp + Solar.R, data = .) %>%
  summary()
```

```
## 
## Call:
## lm(formula = Ozone ~ Wind + Temp + Solar.R, data = .)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -40.485 -14.219  -3.551  10.097  95.619 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept) -64.34208   23.05472  -2.791  0.00623 ** 
## Wind         -3.33359    0.65441  -5.094 1.52e-06 ***
## Temp          1.65209    0.25353   6.516 2.42e-09 ***
## Solar.R       0.05982    0.02319   2.580  0.01124 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 21.18 on 107 degrees of freedom
## Multiple R-squared:  0.6059,	Adjusted R-squared:  0.5948 
## F-statistic: 54.83 on 3 and 107 DF,  p-value: < 2.2e-16
```


:::
  
::: {.panel}

## Versão adaptada com pipe do R base {.pipe-nativo}

```r
# Versão usando o pipe do R base + funções anônimas
airquality |>
  na.omit()  |>
  {\(x) lm(formula = Ozone ~ Wind + Temp + Solar.R, data = x)}() |>
  summary()
```

```
## 
## Call:
## lm(formula = Ozone ~ Wind + Temp + Solar.R, data = x)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -40.485 -14.219  -3.551  10.097  95.619 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept) -64.34208   23.05472  -2.791  0.00623 ** 
## Wind         -3.33359    0.65441  -5.094 1.52e-06 ***
## Temp          1.65209    0.25353   6.516 2.42e-09 ***
## Solar.R       0.05982    0.02319   2.580  0.01124 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 21.18 on 107 degrees of freedom
## Multiple R-squared:  0.6059,	Adjusted R-squared:  0.5948 
## F-statistic: 54.83 on 3 and 107 DF,  p-value: < 2.2e-16
```

:::
  
:::::

## Conclusão

É muito legal ver que a linguagem está desenvolvendo e incorporando contribuições que surgiram das demandas da comunidade! Muito empolgante testar coisas novas. Caso você também esteja animada(o), [assista a live da Curso-R sobre o tema](https://www.youtube.com/embed/RPSLFU_5OGk)! 

Lembrando que os códigos acima utilizando o pipe do R base e as notações das funções anônimas apenas funcionarão se você instalou a nova versão do R: 4.1.0!

Essas são as informações relacionadas à plataforma que estou usando, e a versão do R:


```r
sessioninfo::session_info()$platform
```

```
##  setting  value                                      
##  version  R version 4.1.0 Patched (2021-05-19 r80340)
##  os       macOS Big Sur 11.3.1                       
##  system   aarch64, darwin20                          
##  ui       X11                                        
##  language (EN)                                       
##  collate  en_US.UTF-8                                
##  ctype    en_US.UTF-8                                
##  tz       America/Sao_Paulo                          
##  date     2021-06-05
```

