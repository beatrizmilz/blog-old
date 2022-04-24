url <-
  "https://docs.google.com/spreadsheets/d/1qFGTBA8GARs9ODk086e6G58aFodCiasjnIWPThHCes0/edit?usp=sharing"
sheet <- googlesheets4::read_sheet(url, "turmas")

cursos_bea <- sheet |>
  dplyr::filter(
    stringr::str_detect(ministrantes, "Beatriz") |
      stringr::str_detect(monitoria, "Beatriz")
  )

cursos_bea |>
  dplyr::filter(data_fim > Sys.Date()) |>
  dplyr::select(curso, ministrantes, monitoria, data_inicio, data_fim) |>
  tidyr::unite("ministrando_com", c(ministrantes, monitoria),  sep = " ") |>
  dplyr::mutate(
    ministrando_com = stringr::str_remove(ministrando_com, "Beatriz Milz") |> stringr::str_trim(),
    mes_inicio = lubridate::month(data_inicio),

    texto = glue::glue(
      "    - {format(data_inicio, '%d/%m')} a {format(data_fim, '%d/%m/%Y')} - [Curso-R](https://curso-r.com/) - Curso: {curso}. Ministrando com: {ministrando_com}."
    )
  ) |>
  dplyr::arrange(data_inicio) |>
  dplyr::select(mes_inicio, texto) |>
  dplyr::pull(texto)


