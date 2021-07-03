---
title: "Criando mapas com os pacotes tidyverse e geobr"
excerpt: "Utilizando dados sobre coleta e tratamento de esgoto no Estado De São Paulo"
author: "Beatriz Milz"
date: '2020-07-27'
categories: ["Portugues", "Reprodutibilidade", "Mapas"]
bibliography: packages.bib
---

Como eu estou meses sem postar nada no blog, resolvi postar um código adaptado, referente a um projeto final que realizei para a disciplina [“FLS6397 - Introdução à Análise de Dados, Programação e Visualização para as Ciências Sociais”](https://jonnyphillips.github.io/Ciencia_de_Dados/). A disciplina ocorreu no primeiro semestre de 2020, na FFLCH/USP (porém devido à pandemia, a maior parte das aulas foi online). Na [página da disciplina](https://jonnyphillips.github.io/Ciencia_de_Dados/), está disponível tutoriais com todo o conteúdo da disciplina, de graça e aberto para todes!

As instruções para a realização do projeto estão disponíveis na [página da disciplina](https://jonnyphillips.github.io/Ciencia_de_Dados/projeto.html).

## Dados utilizados

-   **Dados de Saneamento: ** A Companhia Ambiental do Estado de São Paulo (CETESB)[^1] publica todos os anos o “[Relatório de Qualidade das Águas Interiores do Estado de São Paulo](https://cetesb.sp.gov.br/aguas-interiores/publicacoes-e-relatorios/).” Desde o relatório referente ao ano de 2016, é publicado o **Apêndice C**, que contém **dados de saneamento por município** do Estado de São Paulo. Os arquivos são disponibilizados em arquivo PDF, [e especificamente para o ano de 2016 é um arquivo PDF que não possibilita copiar as informações](https://cetesb.sp.gov.br/aguas-interiores/wp-content/uploads/sites/12/2018/03/Ap%C3%AAndice-C-Dados-do-saneamento-b%C3%A1sico...-munic%C3%ADpios-paulistas-2016_17-04.pdf) (como uma imagem, por exemplo). O relatório mais recente é referente ao ano de [2018](https://cetesb.sp.gov.br/aguas-interiores/wp-content/uploads/sites/12/2019/10/Ap%C3%AAndice-C_Dados-de-Saneamento-por-Munic%C3%ADpio.pdf).

-   **Dados shapefile dos municípios:** Foi utilizado o pacote `{geobr}` (Pereira and Goncalves 2021), que possibilita acessar dados espaciais oficiais do Brasil.

Neste post, irei focar em mostrar como abri os dados, e utilizando principalmente o `tidyverse` (Wickham et al. 2019) e o pacote `geobr` (Pereira and Goncalves 2021), criei mapas com esses dados.

## Pacotes necessários

``` r
library(ggplot2)
library(dplyr)
library(magrittr)
library(geobr)
# install.packages("pdftables")
library(pdftables)
library(readr)
library(stringr)
library(abjutils)
library(ggspatial)
library(tibble)
library(knitr)
library(sf)
```

<div class="alert alert-primary" role="alert">

**O que é `::` ?**

Nos códigos abaixo, muitas vezes me refiro à uma função utilizando o formato `pacote::funcao()`, sendo que o que vem antes dos `::` é o nome do pacote em qual à função pertence, e depois dos `::` é o nome da função que quero usar.

Isso é útil pois:

1.  Caso o pacote não esteja carregado com a função `library(pacote)`, ainda sim o R entenderá qual função você está se referindo, e executará o código.

2.  Caso você se refira à uma função apenas pelo nome (sem considerar o `::`), em uma situação onde você carregou pacotes diferentes que possuem funções com nome igual, a função do pacote carregado por último será utilizada. Isso pode causar a execução de uma função indesejada. Portanto, utilizar o `::` ajuda a garantir a utilização da função desejada.

</div>

## Abrir e arrumar as bases brutas

### Dados de Saneamento

O primeiro passo é fazer o download do arquivo PDF referente ao Apêndice C e converter em CSV. A função `download.file()` possibilita fazer download de arquivos diretamente do R.

``` r
# Link do relatório
url <-
  "https://cetesb.sp.gov.br/aguas-interiores/wp-content/uploads/sites/12/2019/10/Ap%C3%AAndice-C_Dados-de-Saneamento-por-Munic%C3%ADpio.pdf" 


#Fazer o download do arquivo PDF

download.file(url, # URL do arquivo a ser baixado
              destfile = "dados/apendice_c_2018.pdf", # Informar onde quer que seja salvo, e com qual nome e extensão 
              method = "curl" # Método utilizado para o download
              )
```

Para fazer a conversão, utilizei o pacote `{pdftables}` (Persson 2016), que possibilita converter o arquivo PDF para CSV diretamente do R, através da API (e omiti a minha chave da API no código):

<div class="alert alert-primary" role="alert">

**O que é API?**

É a sigla para “Application Programming Interfaces,” ou em português, “Interface de programação de aplicações.”

Neste exemplo, caso não fosse utilizar a API, seria necessário realizar o upload do arquivo PDF no site [PDFTables](https://pdftables.com/), e depois baixar o arquivo convertido.

Para utilizar a API, é necessário fazer um cadastro no site, e na aba [API](https://pdftables.com/pdf-to-excel-api) é disponibilizado a chave da API para utilizá-la. Posteriormente, pode-se utilizar a função `pdftables::convert_pdf()` para fazer a conversão diretamente do R. Isso é muito útil quando temos uma grande quantidade de arquivos, e também para deixar registrado a etapa realizada.

Caso queira saber mais sobre APIs, leia essa [página do material](http://material.curso-r.com/api/) da [Curso-R](http://curso-r.com/).

</div>

``` r
# Converter o arquivo PDF em CSV. Utilizei a API que obtive no site, mas para compilar, omiti a API key.

pdftables::convert_pdf("dados/apendice_c_2018.pdf",
                       # Arquivo para converter
                       output_file = "dados/apendice_c_2018.csv",
                       #  Informar onde quer o arquivo gerado
                       # seja salvo, e com qual nome e extensão
                       api_key = "..." # Chave da API, gerada através do site.
                       )
```

A tabela convertida em `.csv` pode ser acessada [neste link](https://beatrizmilz.github.io/2020-FLS6397/projeto_final/dados/apendice_c_2018.csv). O próximo passo é carregar a base, usando a função `readr::read_csv()`:

``` r
apendice_c_2018 <-
  readr::read_csv(
    "dados/apendice_c_2018.csv", # Qual arquivo CSV quero carregar
    col_names = c(
      # define o nome das colunas
      "ugrhi",
      "municipio",
      "consessao",
      "pop_urbana",
      "atendimento_coleta_porc",
      "atendimento_tratamento_porc",
      "eficiencia",
      "carga_poluidora_potencial",
      "carga_poluidora_remancescente",
      "ictem",
      "corpo_receptor"
    ),
    locale = readr::locale(encoding = "ISO-8859-1"),
    # encoding dos dados
    skip = 5 # Quantas linhas para pular no CSV antes de começar a ler os dados.
  )
```

<div class="alert alert-primary" role="alert">

**Encoding?**

Uma das informações importantes que utilizei na função para ler os dados no R, no código acima, é o **Encoding**. O Encoding está relacionado à codificação dos caracteres. Você já carregou uma base de dados onde os caracteres apareceram desconfigurados, como na imagem abaixo? Provavelmente era um erro de Encoding!

<img src="https://beatrizmilz.com/img/encoding-error.JPG" width="80%" style="display: block; margin: auto;" />

Ao carregar um arquivo, é util saber em qual encoding ele foi salvo.

O recomendado ao salvar um arquivo é utilizar o encoding **UTF-8**.[^2]

</div>

-   A base deve conter 645 linhas, referente ao número de municípios no estado de São Paulo[^3]:

``` r
nrow(apendice_c_2018) # consulta quantas linhas tem na base
```

    ## [1] 701

A base contém mais linhas do que municípios. O código abaixo retira linhas que apenas contém NA, e linhas que não apresentam dados dos municípios:

``` r
apendice_c_filtrado <- apendice_c_2018 %>%
  # Filtrar linhas que não contém nome de municípios
  dplyr::filter(!municipio %in% c("Estado de São Paulo", "Município", NA, "MUNICÍPIO")) 
```

Agora a base tem 645 linhas, o que corresponde aos 645 municípios do estado de SP. É importante também verificar o tipo de dados nas colunas:

``` r
tibble::glimpse(apendice_c_filtrado)
```

    ## Rows: 645
    ## Columns: 11
    ## $ ugrhi                         <chr> "1", "1", "1", "2", "2", "2", "2", "2", …
    ## $ municipio                     <chr> "Campos do Jordão", "Santo Antônio do Pi…
    ## $ consessao                     <chr> "SABESP", "SABESP", "SABESP", "SAAE", "S…
    ## $ pop_urbana                    <chr> "51440", "4033", "5224", "35604", "1863"…
    ## $ atendimento_coleta_porc       <chr> "52", "47", "92", "70", "91", "100", "89…
    ## $ atendimento_tratamento_porc   <chr> "100", "100", "75", "28", "100", "0", "1…
    ## $ eficiencia                    <chr> "97", "80", "76", "70", "82", NA, "62", …
    ## $ carga_poluidora_potencial     <chr> "2.778", "218", "282", "1.923", "101", "…
    ## $ carga_poluidora_remancescente <chr> "1.377", "136", "133", "1.659", "26", "1…
    ## $ ictem                         <chr> "6,06", "4,65", "6,14", "2,56", "8,22", …
    ## $ corpo_receptor                <chr> "Rio Capivari, Rio Sapucaí-Guaçu e aflue…

Algumas colunas são de dados numéricos mas que foram carregadas como texto (`<chr>`), portanto devem ser convertidas para o tipo correto (possível com a função `dplyr::mutate()`:

``` r
apendice_c <- apendice_c_filtrado %>%
  dplyr::mutate(
    pop_urbana = as.double(pop_urbana) , 
    atendimento_coleta_porc = as.double(atendimento_coleta_porc),
    atendimento_tratamento_porc = as.double(atendimento_tratamento_porc),
    eficiencia = as.double(eficiencia),
    
    # As conversões abaixo tem uma etapa a mais, devido à padronização diferente utilizada na base, 
    #com o ponto e a vírgula para representar as casas decimais:
    carga_poluidora_potencial =  stringr::str_replace_all(carga_poluidora_potencial, "\\.", "") %>%
      as.double(),
    
    carga_poluidora_remancescente =  stringr::str_replace_all(carga_poluidora_remancescente, "\\.", "") %>%
      as.double(),
    ictem =  stringr::str_replace_all(ictem, ",", "\\.") %>% as.double()
    
  )
```

Agora podemos observar novamente o tipo de dados nas colunas, e verificar se todos os dados estão no formato ideal para a análise:

``` r
tibble::glimpse(apendice_c)
```

    ## Rows: 645
    ## Columns: 11
    ## $ ugrhi                         <chr> "1", "1", "1", "2", "2", "2", "2", "2", …
    ## $ municipio                     <chr> "Campos do Jordão", "Santo Antônio do Pi…
    ## $ consessao                     <chr> "SABESP", "SABESP", "SABESP", "SAAE", "S…
    ## $ pop_urbana                    <dbl> 51440, 4033, 5224, 35604, 1863, 2598, 86…
    ## $ atendimento_coleta_porc       <dbl> 52, 47, 92, 70, 91, 100, 89, 100, 100, 8…
    ## $ atendimento_tratamento_porc   <dbl> 100, 100, 75, 28, 100, 0, 100, 99, 100, …
    ## $ eficiencia                    <dbl> 97, 80, 76, 70, 82, NA, 62, 75, 86, 89, …
    ## $ carga_poluidora_potencial     <dbl> 2778, 218, 282, 1923, 101, 140, 470, 432…
    ## $ carga_poluidora_remancescente <dbl> 1377, 136, 133, 1659, 26, 140, 210, 1125…
    ## $ ictem                         <dbl> 6.06, 4.65, 6.14, 2.56, 8.22, 1.50, 6.92…
    ## $ corpo_receptor                <chr> "Rio Capivari, Rio Sapucaí-Guaçu e aflue…

Agora a base está pronta para uso!

### Dados shapefile dos município

Os dados foram obtidos com o pacote `geobr`:

``` r
# Lê a base de dados espaciais (do tipo Shapefile) dos municípios do Estado de São Paulo,
# no ano de 2018, segundo o IBGE.
# Os dados salvos são da classe Simple Feature

municipios_sp <- geobr::read_municipality("SP", 2018)
```

<div class="alert alert-primary" role="alert">

O pacote `geobr` (Pereira and Goncalves 2021) é um pacote que disponibiliza funções para realizar o download de diversas bases de dados espaciais oficiais do Brasil. Você pode saber mais no [repositório do pacote no GitHub](https://github.com/ipeaGIT/geobr).

O pacote `sf` (Simple Features for R) (Pebesma 2021, 2018) possibilita trabalhar com essas bases de dados espaciais. Gosto muito da seguinte ilustação da [Allison Horst](https://github.com/allisonhorst/stats-illustrations) sobre esse pacote:

<img src="https://raw.githubusercontent.com/allisonhorst/stats-illustrations/master/rstats-artwork-PT/sf_pt.png" width="80%" style="display: block; margin: auto;" />

</div>

### Lista de UGRHIS

No projeto, defini como área de estudo os municípios das seguintes Unidades de Gerenciamento de Recursos Hídricos (**UGRHI**): Paraíba do Sul, Litoral Norte, Piracicaba/Capivari/Jundiaí, Alto Tietê, Baixada Santista e Tietê/Sorocaba. Essas UGRHIs foram escolhidas por estarem totalmente ou marjoritariamente no território da Macrometrópole Paulista (**MMP**) (considerando a delimitação do DAEE[^4]).

Criei manualmente uma tibble com o número e nome das UGRHIs que farão parte da análise:

``` r
ugrhis <- tibble::tibble(
  ugrhi = c("2",
            "3",
            "5",
            "6",
            "7",
            "10"),
  nome_ugrhi = c(
    " Paraíba do Sul",
    " Litoral Norte",
    " Piracicaba/Capivari/Jundiaí",
    " Alto Tietê",
    " Baixada Santista",
    " Tietê/Sorocaba"
  )
)
```

## Unir as bases !

A base da CETESB não possui o código de município do IBGE (o ideal para fazer o Join). Neste caso, podemos usar o nome do município, porém é preciso padronizar os nomes em relação à maiúsculas/minúsculas, acentos, presença de traços, entre outros. A maior diferença encontrada foi na grafia do nome do município “São Luiz do Paraitinga”: segundo o site da Assembléia Legislativa do Estado de São Paulo, e o site do município, Luiz é escrito com Z, porém a base da CETESB utiliza a forma incorreta: “São Luís do Paraitinga.” Essas inconsistências foram corrigidas com código abaixo, usando principalmente funções dos pacotes `stringr`, `dplyr` e `abjutils`:

``` r
municipios_sp_limpo <-
  municipios_sp %>% dplyr::mutate(
    nome_muni = stringr::str_to_lower(name_muni),
    nome_muni = stringr::str_replace_all(nome_muni, "-", " "),
    nome_muni = abjutils::rm_accent(nome_muni)
  )

apendice_c_limpo <- apendice_c %>% dplyr::mutate(
  nome_muni =  dplyr::case_when(
    municipio == "São Luís do Paraitinga" ~
      "São Luiz do Paraitinga",
    TRUE ~ municipio
  ),
  nome_muni = stringr::str_to_lower(nome_muni),
  nome_muni = stringr::str_replace_all(nome_muni, "-", " "),
  nome_muni = abjutils::rm_accent(nome_muni))
```

-   Após arrumar a base, podemos unir com as funções do tipo `join_*`, do pacote `dplyr` (Sim, é possível usar as funções do tipo `join_*` com objetos de classe Simple Feature, porém use-os como o primeiro argumento ao usar a função):

``` r
apendice_c_geo <-
  dplyr::full_join(municipios_sp_limpo, apendice_c_limpo) %>%
  dplyr::left_join(ugrhis)

apendice_c_geo %>% nrow() # Confirmando se a nova base tem o número de municípios do estado.
```

    ## [1] 645

Ao unir as bases, temos colunas duplicadas ou desnecessárias, então é interessante removê-las. Após este procedimento, a base será filtrada para que apenas municípios que fazem parte das UGRHIs analisadas estejam na tibble gerada.

Além disso, o valor de porcentagem de atendimento de tratamento de esgoto é um valor de porcentagem em relação ao volume de esgoto **coletado**. Por exemplo, o município de Bertioga, segundo os dados da CETESB para 2018, apresenta uma porcentagem de coleta de apenas 34 % do esgoto gerado, e uma porcentagem de 100 % do esgoto tratado. Isso significa que 100 % do esgoto coletado é tratado, e não mostra a porcentagem de todo esgoto gerado que foi tratado. Para isso, criei também uma coluna (chamada `porc_real_trat`) onde é feito esse cálculo (utilizando a função mutate).

``` r
saneamento <- apendice_c_geo %>%
  dplyr::select(-nome_muni,-municipio,-code_state) %>% # Remove colunas duplicadas
  dplyr::filter(ugrhi %in% ugrhis$ugrhi) %>% # Filtra a coluna UGRHI. Apenas as UGRHIS que estão na tibble
                                            # criada, permanecerão.
  dplyr::mutate(porc_real_trat = atendimento_tratamento_porc * atendimento_coleta_porc / 100) # Cria uma nova
# coluna, com o cálculo do número real de porcentagem de tratamento de esgoto.
```

A base final que usaremos na análise contém dados de 171 municípios, que fazem parte de 6 UGRHIs diferentes. A soma da população urbana destes municípios é de 32.79 milhões de habitantes, o que corresponde à 75.1 % da população urbana do Estado de São Paulo (segundo os dados da base completa utilizada nessa análise).

## Visualizando os dados

Para evitar duplicação de código, o código abaixo é referente ao estilo do mapa, que aplicarei em todos os mapas seguintes.

``` r
tema_mapa <-
  theme_bw() + # Escolhe o tema. Eu gosto do theme_bw() por ser bem simples/limpo
  
  # Os códigos abaixo são referentes à estética do tema,
  # como o tamanho da fonte, direção do texto,
  # linhas ao fundo, etc.
  
  theme(
    axis.text.y = element_text(
      angle = 90,
      hjust = 0.5,
      size = 8
    ),
    axis.text.x = element_text(size = 8),
    axis.title.y = element_text(size = rel(0.8)),
    axis.title.x = element_text(size = rel(0.8)),
    panel.grid.major = element_line(
      color = gray(0.9),
      linetype = "dashed",
      size = 0.1
    ),
    panel.background = element_rect(fill = "white") +
      annotation_scale(location = "br", width_hint = 0.30)
  )
```

Com a função `geom_sf()`, é possível criar mapas utilizando o pacote `ggplot2` e objetos de classe Simple Feature (sf). Assim podemos usar as nossas habilidades de criar gráficos lindos no `ggplot2`, e criar mapas também usando as funções que já conhecemos.

``` r
class(saneamento) # Função class() apresenta a classe do objeto. 
```

    ## [1] "sf"         "data.frame"

O mapa abaixo apresenta os municípios que fazem parte da análise, segundo a UGRHI, e a localização destes municípios no Estado de São Paulo. Podemos usar mais de uma camada `geom_sf()` no mesmo mapa, da mesma forma que fazemos com o `ggplot2`:

``` r
saneamento %>% # Base de dados usada
  ggplot() + # Inicia o gráfico ggplot
  geom_sf(data = apendice_c_geo,
          # Camada do mapa da base completa (Estado SP)
          alpha = .9,
          color = NA) +
  geom_sf(aes(fill = nome_ugrhi)) + # Camada do mapa da base saneamento
  # Adiciona Título e Legendas
  labs(fill = "UGRHI",
       title = "Municípios que fazem parte da análise, segundo a UGRHI") +
  # Adiciona o Norte Geográfico
  annotation_north_arrow(
    location = "br",
    which_north = "true",
    height = unit(1, "cm"),
    width = unit(1, "cm"),
    pad_x = unit(0.1, "in"),
    pad_y = unit(0.1, "in"),
    style = north_arrow_fancy_orienteering
  ) +
  ggspatial::annotation_scale() +
  # Adiciona o tema criado anteriormente
  tema_mapa 
```

<img src="{{< blogdown/postref >}}index_files/figure-html/mapa-area-estudo-1.png" width="100%" style="display: block; margin: auto;" />

O mapa abaixo apresenta a porcentagem de atendimento de coleta de esgoto, por município:

``` r
saneamento %>%
  ggplot() +
  geom_sf(aes(fill = atendimento_coleta_porc)) +
  scale_fill_viridis_c(direction = -1, limits = c(0, 100)) + # Escala de cores
  labs(fill = "Porcentagem de \natendimento de \ncoleta de esgoto",
       title = "Porcentagem de atendimento de coleta de esgoto, por município",
       subtitle = "Dados da CETESB, para o ano de 2018.") +
  annotation_north_arrow(
    location = "br",
    which_north = "true",
    height = unit(1, "cm"),
    width = unit(1, "cm"),
    pad_x = unit(0.1, "in"),
    pad_y = unit(0.1, "in"),
    style = north_arrow_fancy_orienteering
  ) +
  ggspatial::annotation_scale() +
  tema_mapa 
```

<img src="{{< blogdown/postref >}}index_files/figure-html/mapa-coleta-1.png" width="100%" style="display: block; margin: auto;" />

O mapa abaixo apresenta a porcentagem de atendimento de tratamento de esgoto, considerando o total de esgoto coletado, por município:

``` r
saneamento %>%
  ggplot() +
  geom_sf(aes(fill = porc_real_trat)) +
  scale_fill_viridis_c(direction = -1, limits = c(0, 100)) +
  labs(fill = "% de \natendimento de \ntratamento de esgoto ",
       title = "Porcentagem de atendimento de tratamento de esgoto, por município",
       subtitle = "Calculado a partir de dados da CETESB, para o ano de 2018.") +
  annotation_north_arrow(
    location = "br",
    which_north = "true",
    height = unit(1, "cm"),
    width = unit(1, "cm"),
    pad_x = unit(0.1, "in"),
    pad_y = unit(0.1, "in"),
    style = north_arrow_fancy_orienteering
  ) +
  ggspatial::annotation_scale() +
  tema_mapa 
```

<img src="{{< blogdown/postref >}}index_files/figure-html/mapa-tratamento-1.png" width="100%" style="display: block; margin: auto;" />

## Conclusão do post

Neste post, mostrei um caminho reprodutível e realizado utilizando o R:

-   Com o pacote `pdftables`, é possível converter tabelas que estão em arquivos PDF para arquivos CSV.

-   Com o pacote `geobr`, é possível obter os arquivos shapefile para os mapas.

-   Com as funções dos pacotes que fazem parte do `tidyverse`, diversas etapas da análise de dados são possíveis: ler os dados no R, limpeza de dados, manipulação dos dados, cruzamento de bases de dados, visualização, e outros.

## Recomendações para a base da CETESB

-   Adicionar uma explicação sobre cada coluna da base disponibilizada.

-   Seria melhor disponibilizar também o arquivo `.CSV`. Não disponibilizar PDFs digitalizados (Ex: relatório do ano de 2016).

-   Seria útil adicionar, para os próximos relatórios, a coluna de código IBGE do município. Isso facilitaria o cruzamento com outras bases de dados.

-   Verificar a grafia do nome dos municípios (está inconsistente com a lista de municípios da Assembléia Legislativa do Estado de São Paulo[^5]): São Luiz do Paraitinga, Biritiba Mirim, Itaoca.

## Informações sobre a sessão do R e RStudio

-   As informações abaixo são interessantes para registrar a versão do R utilizada, versões de pacotes, entre outros.

``` r
sessioninfo::session_info()
```

    ## ─ Session info ───────────────────────────────────────────────────────────────
    ##  setting  value                       
    ##  version  R version 3.6.3 (2020-02-29)
    ##  os       macOS  10.16                
    ##  system   x86_64, darwin15.6.0        
    ##  ui       X11                         
    ##  language (EN)                        
    ##  collate  en_US.UTF-8                 
    ##  ctype    en_US.UTF-8                 
    ##  tz       America/Sao_Paulo           
    ##  date     2021-07-03                  
    ## 
    ## ─ Packages ───────────────────────────────────────────────────────────────────
    ##  package     * version    date       lib source                         
    ##  abjutils    * 0.3.1.9000 2021-07-03 [1] Github (abjur/abjutils@7e52a0d)
    ##  assertthat    0.2.1      2019-03-21 [1] CRAN (R 3.6.0)                 
    ##  blogdown      1.3        2021-04-14 [1] CRAN (R 3.6.2)                 
    ##  bookdown      0.22       2021-04-22 [1] CRAN (R 3.6.2)                 
    ##  bslib         0.2.5.1    2021-05-18 [1] CRAN (R 3.6.2)                 
    ##  class         7.3-15     2019-01-01 [1] CRAN (R 3.6.3)                 
    ##  classInt      0.4-3      2020-04-07 [1] CRAN (R 3.6.2)                 
    ##  cli           3.0.0      2021-06-30 [1] CRAN (R 3.6.2)                 
    ##  colorspace    2.0-2      2021-06-24 [1] CRAN (R 3.6.2)                 
    ##  crayon        1.4.1      2021-02-08 [1] CRAN (R 3.6.2)                 
    ##  crul          1.1.0      2021-02-15 [1] CRAN (R 3.6.2)                 
    ##  curl          4.3.2      2021-06-23 [1] CRAN (R 3.6.2)                 
    ##  data.table    1.14.0     2021-02-21 [1] CRAN (R 3.6.3)                 
    ##  DBI           1.1.1      2021-01-15 [1] CRAN (R 3.6.2)                 
    ##  digest        0.6.27     2020-10-24 [1] CRAN (R 3.6.2)                 
    ##  dplyr       * 1.0.7      2021-06-18 [1] CRAN (R 3.6.2)                 
    ##  e1071         1.7-7      2021-05-23 [1] CRAN (R 3.6.2)                 
    ##  ellipsis      0.3.2      2021-04-29 [1] CRAN (R 3.6.2)                 
    ##  evaluate      0.14       2019-05-28 [1] CRAN (R 3.6.0)                 
    ##  fansi         0.5.0      2021-05-25 [1] CRAN (R 3.6.2)                 
    ##  farver        2.1.0      2021-02-28 [1] CRAN (R 3.6.2)                 
    ##  generics      0.1.0      2020-10-31 [1] CRAN (R 3.6.2)                 
    ##  geobr       * 1.6.1      2021-04-16 [1] CRAN (R 3.6.2)                 
    ##  ggplot2     * 3.3.5      2021-06-25 [1] CRAN (R 3.6.2)                 
    ##  ggspatial   * 1.1.5      2021-01-04 [1] CRAN (R 3.6.2)                 
    ##  glue          1.4.2      2020-08-27 [1] CRAN (R 3.6.2)                 
    ##  gtable        0.3.0      2019-03-25 [1] CRAN (R 3.6.0)                 
    ##  highr         0.9        2021-04-16 [1] CRAN (R 3.6.2)                 
    ##  hms           1.1.0      2021-05-17 [1] CRAN (R 3.6.2)                 
    ##  htmltools     0.5.1.1    2021-01-22 [1] CRAN (R 3.6.2)                 
    ##  httpcode      0.3.0      2020-04-10 [1] CRAN (R 3.6.2)                 
    ##  httr          1.4.2      2020-07-20 [1] CRAN (R 3.6.2)                 
    ##  jquerylib     0.1.4      2021-04-26 [1] CRAN (R 3.6.2)                 
    ##  jsonlite      1.7.2      2020-12-09 [1] CRAN (R 3.6.2)                 
    ##  KernSmooth    2.23-16    2019-10-15 [1] CRAN (R 3.6.3)                 
    ##  knitr       * 1.33       2021-04-24 [1] CRAN (R 3.6.2)                 
    ##  labeling      0.4.2      2020-10-20 [1] CRAN (R 3.6.2)                 
    ##  lifecycle     1.0.0      2021-02-15 [1] CRAN (R 3.6.2)                 
    ##  magrittr    * 2.0.1      2020-11-17 [1] CRAN (R 3.6.2)                 
    ##  munsell       0.5.0      2018-06-12 [1] CRAN (R 3.6.0)                 
    ##  pdftables   * 0.1        2016-02-15 [1] CRAN (R 3.6.0)                 
    ##  pillar        1.6.1      2021-05-16 [1] CRAN (R 3.6.2)                 
    ##  pkgconfig     2.0.3      2019-09-22 [1] CRAN (R 3.6.0)                 
    ##  proxy         0.4-26     2021-06-07 [1] CRAN (R 3.6.2)                 
    ##  purrr         0.3.4      2020-04-17 [1] CRAN (R 3.6.2)                 
    ##  R6            2.5.0      2020-10-28 [1] CRAN (R 3.6.2)                 
    ##  Rcpp          1.0.6      2021-01-15 [1] CRAN (R 3.6.2)                 
    ##  readr       * 1.4.0      2020-10-05 [1] CRAN (R 3.6.2)                 
    ##  rlang         0.4.11     2021-04-30 [1] CRAN (R 3.6.2)                 
    ##  rmarkdown     2.9        2021-06-15 [1] CRAN (R 3.6.2)                 
    ##  rstudioapi    0.13       2020-11-12 [1] CRAN (R 3.6.2)                 
    ##  s2            1.0.6      2021-06-17 [1] CRAN (R 3.6.2)                 
    ##  sass          0.4.0      2021-05-12 [1] CRAN (R 3.6.2)                 
    ##  scales        1.1.1      2020-05-11 [1] CRAN (R 3.6.2)                 
    ##  sessioninfo   1.1.1      2018-11-05 [1] CRAN (R 3.6.0)                 
    ##  sf          * 1.0-1      2021-06-29 [1] CRAN (R 3.6.2)                 
    ##  stringi       1.6.2      2021-05-17 [1] CRAN (R 3.6.2)                 
    ##  stringr     * 1.4.0      2019-02-10 [1] CRAN (R 3.6.0)                 
    ##  tibble      * 3.1.2      2021-05-16 [1] CRAN (R 3.6.2)                 
    ##  tidyselect    1.1.1      2021-04-30 [1] CRAN (R 3.6.2)                 
    ##  triebeard     0.3.0      2016-08-04 [1] CRAN (R 3.6.0)                 
    ##  units         0.7-2      2021-06-08 [1] CRAN (R 3.6.2)                 
    ##  urltools      1.7.3      2019-04-14 [1] CRAN (R 3.6.0)                 
    ##  utf8          1.2.1      2021-03-12 [1] CRAN (R 3.6.2)                 
    ##  vctrs         0.3.8      2021-04-29 [1] CRAN (R 3.6.2)                 
    ##  viridisLite   0.4.0      2021-04-13 [1] CRAN (R 3.6.2)                 
    ##  withr         2.4.2      2021-04-18 [1] CRAN (R 3.6.2)                 
    ##  wk            0.4.1      2021-03-16 [1] CRAN (R 3.6.2)                 
    ##  xfun          0.24       2021-06-15 [1] CRAN (R 3.6.2)                 
    ##  yaml          2.2.1      2020-02-01 [1] CRAN (R 3.6.0)                 
    ## 
    ## [1] /Library/Frameworks/R.framework/Versions/3.6/Resources/library

O projeto foi realizado com R (R Core Team 2020), e os pacotes: `{abjutils}` (Lente and Trecenti 2020), `{dplyr}` (Wickham, François, et al. 2021), `{geobr}` (Pereira and Goncalves 2021), `{ggplot2}` (Wickham, Chang, et al. 2021; Wickham 2016), `{ggspatial}` (Dunnington 2021), `{knitr}` (Xie 2021, 2015), `{magrittr}` (Bache and Wickham 2020), `{pdftables}` (Persson 2016), `{readr}` (Wickham and Hester 2020), `{rmarkdown}` (Allaire et al. 2021; Xie, Allaire, and Grolemund 2018), `{sf}` (Pebesma 2021, 2018), `{stringr}` (Wickham 2019), `{tibble}` (Müller and Wickham 2021).

## Muito obrigada!

-   Ao Professor [Jonathan Phillips](https://jonnyphillips.github.io/Website/), pelo oferecimento da disciplina [“FLS6397 - Introdução à Análise de Dados, Programação e Visualização para as Ciências Sociais”](https://jonnyphillips.github.io/Ciencia_de_Dados/), por sua disponibilidade para tirar as dúvidas de todes, disponibilização de todo material da aula na internet de forma aberta e gratuita, e pelo esforço para que a disciplina fosse proveitosa mesmo considerando o contexto de pandemia.

-   A [Vanessa Escolano Maso](https://bv.fapesp.br/pt/pesquisador/705683/vanessa-escolano-maso/), amiga, parceira na R-Ladies São Paulo e também na disciplina, pela companhia durante a disciplina e também por revisar e sugerir melhoras neste post.

-   Ao [Maurício Vancine](https://twitter.com/mauriciovancine) pela sua sugestão via [twitter](https://twitter.com/mauriciovancine/status/1287852208449638402?s=20) de utilizar a função `ggspatial::annotation_scale()` para adicionar uma barra de escala nos gráficos.

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-R-rmarkdown" class="csl-entry">

Allaire, JJ, Yihui Xie, Jonathan McPherson, Javier Luraschi, Kevin Ushey, Aron Atkins, Hadley Wickham, Joe Cheng, Winston Chang, and Richard Iannone. 2021. *Rmarkdown: Dynamic Documents for r*. <https://CRAN.R-project.org/package=rmarkdown>.

</div>

<div id="ref-R-magrittr" class="csl-entry">

Bache, Stefan Milton, and Hadley Wickham. 2020. *Magrittr: A Forward-Pipe Operator for r*. <https://CRAN.R-project.org/package=magrittr>.

</div>

<div id="ref-R-ggspatial" class="csl-entry">

Dunnington, Dewey. 2021. *Ggspatial: Spatial Data Framework for Ggplot2*. <https://CRAN.R-project.org/package=ggspatial>.

</div>

<div id="ref-R-abjutils" class="csl-entry">

Lente, Caio, and Julio Trecenti. 2020. *Abjutils: Useful Tools for Jurimetrical Analysis Used by the Brazilian Jurimetrics Association*. <https://github.com/abjur/abjutils>.

</div>

<div id="ref-R-tibble" class="csl-entry">

Müller, Kirill, and Hadley Wickham. 2021. *Tibble: Simple Data Frames*. <https://CRAN.R-project.org/package=tibble>.

</div>

<div id="ref-sf2018" class="csl-entry">

Pebesma, Edzer. 2018. “<span class="nocase">Simple Features for R: Standardized Support for Spatial Vector Data</span>.” *The R Journal* 10 (1): 439–46. <https://doi.org/10.32614/RJ-2018-009>.

</div>

<div id="ref-R-sf" class="csl-entry">

———. 2021. *Sf: Simple Features for r*. <https://CRAN.R-project.org/package=sf>.

</div>

<div id="ref-R-geobr" class="csl-entry">

Pereira, Rafael H. M., and Caio Nogueira Goncalves. 2021. *Geobr: Download Official Spatial Data Sets of Brazil*. <https://github.com/ipeaGIT/geobr>.

</div>

<div id="ref-R-pdftables" class="csl-entry">

Persson, Eric. 2016. *Pdftables: Programmatic Conversion of PDF Tables*. <https://CRAN.R-project.org/package=pdftables>.

</div>

<div id="ref-R-base" class="csl-entry">

R Core Team. 2020. *R: A Language and Environment for Statistical Computing*. Vienna, Austria: R Foundation for Statistical Computing. <https://www.R-project.org/>.

</div>

<div id="ref-ggplot22016" class="csl-entry">

Wickham, Hadley. 2016. *Ggplot2: Elegant Graphics for Data Analysis*. Springer-Verlag New York. <https://ggplot2.tidyverse.org>.

</div>

<div id="ref-R-stringr" class="csl-entry">

———. 2019. *Stringr: Simple, Consistent Wrappers for Common String Operations*. <https://CRAN.R-project.org/package=stringr>.

</div>

<div id="ref-tidyverse2019" class="csl-entry">

Wickham, Hadley, Mara Averick, Jennifer Bryan, Winston Chang, Lucy D’Agostino McGowan, Romain François, Garrett Grolemund, et al. 2019. “Welcome to the <span class="nocase">tidyverse</span>.” *Journal of Open Source Software* 4 (43): 1686. <https://doi.org/10.21105/joss.01686>.

</div>

<div id="ref-R-ggplot2" class="csl-entry">

Wickham, Hadley, Winston Chang, Lionel Henry, Thomas Lin Pedersen, Kohske Takahashi, Claus Wilke, Kara Woo, Hiroaki Yutani, and Dewey Dunnington. 2021. *Ggplot2: Create Elegant Data Visualisations Using the Grammar of Graphics*. <https://CRAN.R-project.org/package=ggplot2>.

</div>

<div id="ref-R-dplyr" class="csl-entry">

Wickham, Hadley, Romain François, Lionel Henry, and Kirill Müller. 2021. *Dplyr: A Grammar of Data Manipulation*. <https://CRAN.R-project.org/package=dplyr>.

</div>

<div id="ref-R-readr" class="csl-entry">

Wickham, Hadley, and Jim Hester. 2020. *Readr: Read Rectangular Text Data*. <https://CRAN.R-project.org/package=readr>.

</div>

<div id="ref-knitr2015" class="csl-entry">

Xie, Yihui. 2015. *Dynamic Documents with R and Knitr*. 2nd ed. Boca Raton, Florida: Chapman; Hall/CRC. <https://yihui.org/knitr/>.

</div>

<div id="ref-R-knitr" class="csl-entry">

———. 2021. *Knitr: A General-Purpose Package for Dynamic Report Generation in r*. <https://yihui.org/knitr/>.

</div>

<div id="ref-rmarkdown2018" class="csl-entry">

Xie, Yihui, J. J. Allaire, and Garrett Grolemund. 2018. *R Markdown: The Definitive Guide*. Boca Raton, Florida: Chapman; Hall/CRC. <https://bookdown.org/yihui/rmarkdown>.

</div>

</div>

[^1]: https://cetesb.sp.gov.br/

[^2]: https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

[^3]: https://www.al.sp.gov.br/documentacao/municipios-paulistas/

[^4]: Plano Diretor de Aproveitamento dos Recursos Hídricos para a Macrometrópole Paulista - http://www.daee.sp.gov.br/

[^5]: https://www.al.sp.gov.br/documentacao/municipios-paulistas/
