---
title: "Estudando Python - Semana 1, Parte 3"
excerpt: "Este posts é uma forma de documentar alguns aprendizados na minha trajetória estudando Python. Estou fazendo o curso de [Python para inovação cívica](https://escoladedados.org/courses/python-para-inovacao-civica/), oferecido pela [Escola de Dados](https://escoladedados.org/)."
draft: FALSE
author: "Beatriz Milz"
date: '2021-08-09'
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
<script src="{{< blogdown/postref >}}index_files/twitter-widget/widgets.js"></script>

## Introdução

Olá!

Esse post faz parte de uma série de posts, que tem como objetivo documentar alguns aprendizados na minha trajetória estudando Python. Estou fazendo o curso de [Python para inovação cívica](https://escoladedados.org/courses/python-para-inovacao-civica/), oferecido pela [Escola de Dados](https://escoladedados.org/). Eu já programo em R, portanto muitas das anotações serão feitas comparando como é feito em R e em Python, assim acho que fica mais fácil para eu fazer as conexões conceituais e lembrar mais fácil depois.

Esse é o terceiro post, então caso não tenha lido os posts anteriores, [acesse esse link](https://beatrizmilz.com/blog/2021-python-serie/)!

## Estruturas de controle condicionais

As estruturas de controle condicionais (que conhecemos como `if/else`) funcionam da mesma forma nas duas linguagens, porém a sintaxe é um pouco diferente.

Vamos pensar em um exemplo onde queremos criar uma estrutura onde, dada uma nota que alguém tirou em uma disciplina, é possível saber se a pessoa foi aprovada, se deve fazer a prova de recuperação, ou se foi reprovada. Escrevi primeiro a estrutura em R, onde eu conheço mais, e depois escrevi seguindo a sintaxe em Python:

``` r
# Em R...

# considerando a nota que a pessoa tirou
nota <- 4.5

# se a nota for maior ou igual a 5, ela será aprovada
if(nota >= 5) {
  print("Aprovação")

  # se a nota for maior ou igual a 5, mas menor que 5,
  # ela deverá fazer a prova de recuperação
} else if (nota >= 3 & nota < 5) {
  print("Exame de recuperação")
  
  # se nenhum dos casos anteriores for verdadeiro,
  # ou seja, a nota for menor que 3,
  # a pessoa será reprovada
} else {
  print("Reprovação")
}
```

    [1] "Exame de recuperação"

``` python
# Em Python..

# considerando a nota que a pessoa tirou
nota = 4.5

# se a nota for maior ou igual a 5, ela será aprovada
if nota >= 5:
  print('Aprovação')
  
  # se a nota for maior ou igual a 5, mas menor que 5,
  # ela deverá fazer a prova de recuperação  
elif nota >= 3 and nota < 5:
  print('Exame de recuperação')
  
  # se nenhum dos casos anteriores for verdadeiro,
  # ou seja, a nota for menor que 3,
  # a pessoa será reprovada
else:
  print('Reprovação')
```

    Exame de recuperação

Diferenças importantes:

-   Em R usamos a palavra `else if`, já em Python devemos usar `elif`. Ambos representam a mesma etapa.

-   Em Python não é necessário delimitar com as chaves como fazemos em R. Em vez disso, a indentação é importante e será usada para definir a estrutura. A indentação será mais abordada no próximo tópico.

## Indentação

A indentação (ou *indentation* em inglês) são os espaços que adicionamos no começo da linha de código. Esses espaços, que muitas vezes também fazemos com tabs, permitem destacar a estrutura do código. A indentação também ajuda muito a facilitar a leitura do código.

Em R, o uso da indentação é uma boa prática, mas se o código não estiver indentado corretamente ele ainda funcionará. Em Python, a indentação correta é necessária, caso contrário o código pode gerar um erro! Vamos ver os códigos do exemplo passado sem indentação, e ver o que acontece:

``` r
# Em R...
nota <- 4.5
if(nota >= 5) {
print("Aprovação")
} else if (nota >= 3 & nota < 5) {
print("Exame de recuperação")
} else {
print("Reprovação")
}
```

    [1] "Exame de recuperação"

Em R, podemos remover a indentação e o código ainda funciona. Vamos ver o que acontece em Python nesse caso:

``` python
# Em Python..
nota = 4.5
if nota >= 5:
print('Aprovação')
elif nota >= 3 and nota < 5:
print('Exame de recuperação')
else:
print('Reprovação')
```

    >>> SyntaxError: invalid syntax (<string>, line 1)

Em Python, remover as indentações gerou um erro de sintaxe (**SyntaxError: invalid syntax (<string>, line 1)**). Então é sempre bom lembrar de verificar isso caso o código retorne esse erro. A boa notícia é que as IDEs (os ambientes de desenvolvimento integrado, ou seja, os softwares que utilizamos para facilitar a nossa vida quando estamos programando) nos ajudam bastante com a indentação (inclusive o [RStudio](https://www.rstudio.com/), pois eu estou usando ele e seguindo as indentações sugeridas e tem funcionado bem!).

Caso você queira saber mais sobre as regras de indentação em Python, no curso a instrutora indica o [Guia de estilo para código em Python](https://www.python.org/dev/peps/pep-0008/#indentation).
Eu ainda não li o Guia de estilo, pois acho que é algo que fará mais sentido quando tiver um conhecimento mais consolidado na linguagem. Porém olhei de forma transversal e me pareceu similar ao [guia de estilo do tidyverse](https://style.tidyverse.org/) que usamos como referência em código em R.

## Função `range()` em Python

Outra função abordada no curso foi a função `range()` em Python. Em R temos uma função que também se chama `range()` porém com um comportamento diferente. A função `range()` em Python me pareceu muito com a função `seq()` em R, pois ambas servem para criar sequências. Veja os exemplos:

``` python
# Em Python...

# Forma de uso: range(inicio, fim, passo)

list(range(4, 9, 2))
```

    [4, 6, 8]

``` r
# Em R...

#  Forma de uso: seq(inicio, fim, passo)

seq(4, 9, 2)
```

    [1] 4 6 8

Algo que devemos tomar cuidado é que podemos usar apenas um argumento, que será usado para definir o tamanho da sequência de números. Neste caso, ambas as funções usarão como valores padrões para os argumentos de passo (sendo 1), e do início da sequência (e aí que fica diferente: em Python é 0 e em R é 1, devido à indexação diferente das linguagens). Exemplos que parecem iguais mas retornam resultados diferentes:

``` python
# Em Python...
list(range(9))
```

    [0, 1, 2, 3, 4, 5, 6, 7, 8]

``` r
# Em R...
seq(9)
```

    [1] 1 2 3 4 5 6 7 8 9

### Estrutura de repetição

No exemplo que usei para mostrar o `if/else`, era possível verificar se uma pessoa passou ou não na disciplina. Mas em disciplinas na vida real teremos muitas pessoas matriculadas, correto? Se quisermos repetir aquela estrutura para várias pessoas, podemos usar o `for`.

<div class="figure" style="text-align: center">

<img src="https://github.com/allisonhorst/stats-illustrations/blob/master/rstats-artwork/bakers_7.png?raw=true" alt="Ilustração por Allison Horst, onde representa três seres verdinhos e peludos que estão repetindo as etapas para criar cupcakes. Disponível &lt;a href='https://github.com/allisonhorst/stats-illustrations'&gt;aqui&lt;/a&gt;." width="50%" />
<p class="caption">
Figure 1: Ilustração por Allison Horst, onde representa três seres verdinhos e peludos que estão repetindo as etapas para criar cupcakes. Disponível <a href='https://github.com/allisonhorst/stats-illustrations'>aqui</a>.
</p>

</div>

Novamente, as estruturas de controle condicionais (que conhecemos como `if/else`) funcionam da mesma forma nas duas linguagens, porém a sintaxe é um pouco diferente. A diferença é que o `for` em Python aceita um `else` no final, mas ainda não ficou claro pra mim a utilidade além de escrever alguma mensagem avisando que a iteração acabou..

<div class="figure" style="text-align: center">

<img src="https://media.giphy.com/media/3KCOFfdqmptLi/giphy.gif" alt="Gif do filme Harry Potter e a Pedra Filosofal, onde o Olivaras diz: Curioso, muito curioso."  />
<p class="caption">
Figure 2: Gif do filme Harry Potter e a Pedra Filosofal, onde o Olivaras diz: Curioso, muito curioso.
</p>

</div>

Usei funcões do pacote [{tidyverse}](https://www.tidyverse.org/) para preparar uma pequena base de dados com nomes e notas e servir de exemplo:

``` r
library(magrittr)
tabela_notas <- babynames::babynames %>% 
 dplyr::filter(year == 2017) %>% 
  dplyr::arrange(desc(n)) %>% 
  dplyr::slice(1:5) %>% 
  dplyr::select(name) %>% 
  dplyr::mutate(nota = c(8, 4, 2, 10, 5))

reactable::reactable(tabela_notas)
```

<div id="htmlwidget-1" class="reactable html-widget" style="width:auto;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-1">{"x":{"tag":{"name":"Reactable","attribs":{"data":{"name":["Emma","Liam","Olivia","Noah","Ava"],"nota":[8,4,2,10,5]},"columns":[{"accessor":"name","name":"name","type":"character"},{"accessor":"nota","name":"nota","type":"numeric"}],"defaultPageSize":10,"paginationType":"numbers","showPageInfo":true,"minRows":1,"dataKey":"f604af406dae98a1641737562a85ac4f","key":"f604af406dae98a1641737562a85ac4f"},"children":[]},"class":"reactR_markup"},"evals":[],"jsHooks":[]}</script>

Considerando um conjunto de notas que está na base `tabela_notas`, queremos saber se as pessoas foram aprovadas ou não. Vou apresentar uma solução com R base, depois algo equivalente em Python, e depois de uma forma mais elegante em R usando funções que não pertencem ao R base (ainda não sei fazer de forma mais elegante em Python então vai ficar só em R mesmo).

``` r
# Em R base..

for (indice in 1:nrow(tabela_notas)) {
  nota <- tabela_notas[indice, 'nota']
  
  # se a nota for maior ou igual a 5, ela será aprovada
  if (nota >= 5) {
    print(paste0("Resultado para ", tabela_notas[indice, "name"], ": Aprovação"))
    
    # se a nota for maior ou igual a 5, mas menor que 5,
    # ela deverá fazer a prova de recuperação
  } else if (nota >= 3 & nota < 5) {
    print(paste0("Resultado para ", tabela_notas[indice, "name"],
                 ": Exame de recuperação"))
    # se nenhum dos casos anteriores for verdadeiro,
    # ou seja, a nota for menor que 3,
    # a pessoa será reprovada
  } else {
    print(paste0("Resultado para ", tabela_notas[indice, "name"], ": Reprovação"))
  }
}
```

    [1] "Resultado para Emma: Aprovação"
    [1] "Resultado para Liam: Exame de recuperação"
    [1] "Resultado para Olivia: Reprovação"
    [1] "Resultado para Noah: Aprovação"
    [1] "Resultado para Ava: Aprovação"

Agora para replicar o exemplo em Python, podemos criar uma lista de dicionários (sim, unindo os dois conceitos de estrutura de dados que foi falado no primeiro post), para armazenar os mesmos dados:

``` python
# Em Python..
tabela_notas = [{'nome': 'Emma', 'nota': 8}, {'nome': 'Liam', 'nota': 4}, {'nome': 'Olivia', 'nota': 2}, {'nome': 'Noah', 'nota': 10}, {'nome': 'Ava', 'nota': 5}]

tabela_notas
```

    [{'nome': 'Emma', 'nota': 8}, {'nome': 'Liam', 'nota': 4}, {'nome': 'Olivia', 'nota': 2}, {'nome': 'Noah', 'nota': 10}, {'nome': 'Ava', 'nota': 5}]

``` python
for pessoa in tabela_notas:
  
# se a nota for maior ou igual a 5, ela será aprovada
  if pessoa['nota'] >= 5:
    print(f'Resultado para {pessoa["nome"]}: Aprovação')
  
  # se a nota for maior ou igual a 5, mas menor que 5,
  # ela deverá fazer a prova de recuperação  
  elif pessoa['nota'] >= 3 and pessoa['nota'] < 5:
    print(f'Resultado para {pessoa["nome"]}: Exame de recuperação')
  
  # se nenhum dos casos anteriores for verdadeiro,
  # ou seja, a nota for menor que 3,
  # a pessoa será reprovada
  else:
    print(f'Resultado para {pessoa["nome"]}: Reprovação')
else: 
  print('Acabou. Todas as notas foram processadas!')
```

    Resultado para Emma: Aprovação
    Resultado para Liam: Exame de recuperação
    Resultado para Olivia: Reprovação
    Resultado para Noah: Aprovação
    Resultado para Ava: Aprovação
    Acabou. Todas as notas foram processadas!

O mais importante para pegar o jeito do uso do `for` e do `if/else` em Python é **respeitar a indentação**. Além disso, a lógica se mantém.

Como prometido, mostro também uma forma mais elegante em R, utilizando o pacote [{dplyr}](https://dplyr.tidyverse.org/):

``` r
tabela_notas %>% 
  dplyr::mutate(resultado = dplyr::case_when(
    nota >= 5 ~ "Aprovação",
    nota >= 3 & nota < 5 ~ "Exame de recuperação",
    TRUE ~ "Reprovação"
  )) %>% 
reactable::reactable()
```

<div id="htmlwidget-2" class="reactable html-widget" style="width:auto;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-2">{"x":{"tag":{"name":"Reactable","attribs":{"data":{"name":["Emma","Liam","Olivia","Noah","Ava"],"nota":[8,4,2,10,5],"resultado":["Aprovação","Exame de recuperação","Reprovação","Aprovação","Aprovação"]},"columns":[{"accessor":"name","name":"name","type":"character"},{"accessor":"nota","name":"nota","type":"numeric"},{"accessor":"resultado","name":"resultado","type":"character"}],"defaultPageSize":10,"paginationType":"numbers","showPageInfo":true,"minRows":1,"dataKey":"fd055cc07e0645c03aa6a037440c9f1c","key":"fd055cc07e0645c03aa6a037440c9f1c"},"children":[]},"class":"reactR_markup"},"evals":[],"jsHooks":[]}</script>

Bem melhor do que a forma em R base, né? A ilustração a seguir ajuda a entender a explicar essa função (porém está em inglês):

<div class="figure" style="text-align: center">

<img src="https://github.com/allisonhorst/stats-illustrations/blob/master/rstats-artwork/dplyr_case_when.png?raw=true" alt="Ilustração por Allison Horst, explicando a função usada. Disponível &lt;a href='https://github.com/allisonhorst/stats-illustrations'&gt;aqui&lt;/a&gt;." width="100%" />
<p class="caption">
Figure 3: Ilustração por Allison Horst, explicando a função usada. Disponível <a href='https://github.com/allisonhorst/stats-illustrations'>aqui</a>.
</p>

</div>

## Conclusão

Ainda não completei o conteúdo de estudo da semana 1 do curso, e ainda será necessário um post para terminar o conteúdo. Então se você gostou deste post, confira o blog nos próximos dias!

Espero que esse post seja útil para pessoas que, assim como eu, já programam em R e querem aprender Python.

## Agradecimentos

Agradeço muito à equipe da [Escola de Dados](https://escoladedados.org/courses/python-para-inovacao-civica/), por oferecer esse curso. Além disso, gostaria de agradecer especialmente à instrutora da semana: [Ana Cecília Vieira](https://twitter.com/cecivieira).

## Como interagir?

Atualmente, não está funcionando a opção de comentários. Então se quiser comentar/interagir, recomendo que faça nessa thread, onde estou falando sobre essa série de posts:

<center>
<blockquote class="twitter-tweet" data-width="550" data-lang="en" data-dnt="true" data-theme="light"><p lang="pt" dir="ltr">Tô aprendendo Python no curso de Python pra Inovação cívica da <a href="https://twitter.com/EscolaDeDados?ref_src=twsrc%5Etfw">@EscolaDeDados</a> , e escrevi um post pra me ajudar a fixar o conteúdo. O post é comparando o que é ensinado sobre Python, com as formas que fazemos em R.<br>Obrigada  <a href="https://twitter.com/cecivieira?ref_src=twsrc%5Etfw">@cecivieira</a> e  <a href="https://twitter.com/EscolaDeDados?ref_src=twsrc%5Etfw">@EscolaDeDados</a>!<a href="https://t.co/EFLjAvPwMl">https://t.co/EFLjAvPwMl</a></p>&mdash; Beatriz Milz (@BeaMilz) <a href="https://twitter.com/BeaMilz/status/1424188713974829056?ref_src=twsrc%5Etfw">August 8, 2021</a></blockquote>

</center>

-   [Veja a thread completa neste link!](https://twitter.com/BeaMilz/status/1424188713974829056?s=20)
