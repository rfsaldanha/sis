#!/usr/bin/env Rscript

# Mantém as remissões "Veja também" das edições online e impressa a partir de
# um único manifesto editorial. A edição impressa usa referências nativas do
# Typst; a online recebe as páginas apuradas no PDF final e links internos.

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2L || !args[[1L]] %in% c("build", "inject", "pages")) {
  stop(
    "Uso: build_see_also.R <build|inject|pages> <diretório> [arquivo auxiliar]",
    call. = FALSE
  )
}

mode <- args[[1L]]
root <- normalizePath(args[[2L]], mustWork = TRUE)
manifest_path <- file.path(root, "see-also.tsv")
if (!file.exists(manifest_path) && mode == "inject" && length(args) >= 3L) {
  manifest_path <- args[[3L]]
}
manifest_path <- normalizePath(manifest_path, mustWork = TRUE)

relations <- read.delim(
  manifest_path,
  sep = "\t",
  quote = "",
  comment.char = "",
  stringsAsFactors = FALSE,
  check.names = FALSE,
  fileEncoding = "UTF-8"
)

required <- c("source", "target", "heading")
if (!all(required %in% names(relations))) {
  stop("O manifesto deve conter as colunas source, target e heading.", call. = FALSE)
}
if (any(!nzchar(relations$source) | !nzchar(relations$target) | !nzchar(relations$heading))) {
  stop("O manifesto contém campos vazios.", call. = FALSE)
}

chapter_titles <- c(
  introducao = "Introdução",
  historico = "Breve histórico da experiência brasileira",
  organizacao = "Organização dos SIS",
  eventos = "Eventos de saúde",
  sim = "SIM — Sistema de Informação sobre Mortalidade",
  sinasc = "SINASC — Sistema de Informação sobre Nascidos Vivos",
  sih = "SIH — Sistema de Informações Hospitalares do SUS",
  sia = "SIA — Sistema de Informações Ambulatoriais do SUS",
  sinan = "SINAN — Sistema de Informação de Agravos de Notificação",
  cnes = "CNES — Cadastro Nacional de Estabelecimentos de Saúde",
  siscan = "SISCAN — Sistema de Informação de Câncer",
  sisagua = "SISAGUA — Sistema de Informação de Vigilância da Qualidade da Água para Consumo Humano",
  siops = "SIOPS — Sistema de Informações sobre Orçamentos Públicos em Saúde",
  sisaps = "Siaps — Sistema de Informação para a Atenção Primária à Saúde",
  sipni = "SI-PNI — Sistema de Informações do Programa Nacional de Imunizações",
  rnds = "RNDS — Rede Nacional de Dados em Saúde",
  quadro_resumo = "Quadro-resumo",
  cid = "CID — Classificação Internacional de Doenças",
  codmun = "Códigos dos municípios",
  pop = "Estimativas populacionais",
  inqueritos = "Inquéritos e pesquisas de saúde",
  sivep = "SIVEP — Sistema de Vigilância Epidemiológica",
  sisvan = "SISVAN — Sistema de Vigilância Alimentar e Nutricional",
  ans = "Agência Nacional de Saúde Suplementar — ANS",
  interoperabilidade = "Interoperabilidade entre os Sistemas de Informação em Saúde"
)

unknown <- setdiff(unique(c(relations$source, relations$target)), names(chapter_titles))
if (length(unknown)) stop("Capítulos desconhecidos: ", paste(unknown, collapse = ", "), call. = FALSE)

strip_attributes <- function(x) {
  trimws(sub("[[:space:]]+\\{[^}]*\\}[[:space:]]*$", "", x, perl = TRUE))
}

plain_text <- function(x) {
  x <- strip_attributes(x)
  x <- gsub("!\\[([^]]*)\\]\\([^)]*\\)", "\\1", x, perl = TRUE)
  x <- gsub("\\[([^]]+)\\]\\([^)]*\\)", "\\1", x, perl = TRUE)
  x <- gsub("[`*_~]", "", x, perl = TRUE)
  x <- gsub("<[^>]+>", "", x, perl = TRUE)
  trimws(x)
}

explicit_id <- function(raw_heading) {
  attributes <- regmatches(raw_heading, regexpr("\\{[^}]*\\}[[:space:]]*$", raw_heading, perl = TRUE))
  if (!length(attributes) || !nzchar(attributes)) return(NA_character_)
  identifier <- regmatches(attributes, regexpr("#[[:alnum:]_.:-]+", attributes, perl = TRUE))
  if (!length(identifier) || !nzchar(identifier)) return(NA_character_)
  substring(identifier, 2L)
}

online_id <- function(raw_heading) {
  identifier <- explicit_id(raw_heading)
  if (!is.na(identifier)) return(identifier)
  identifier <- plain_text(raw_heading)
  identifier <- gsub("--+", "", identifier)
  identifier <- gsub("[^\\p{L}\\p{N}_. -]", "", identifier, perl = TRUE)
  identifier <- gsub("[[:space:]]+", "-", identifier, perl = TRUE)
  identifier <- tolower(identifier)
  identifier <- sub("^[^\\p{L}]*", "", identifier, perl = TRUE)
  if (!nzchar(identifier)) "section" else identifier
}

ascii_slug <- function(x) {
  converted <- iconv(plain_text(x), from = "UTF-8", to = "ASCII//TRANSLIT")
  if (is.na(converted)) converted <- plain_text(x)
  converted <- tolower(gsub("['`^~\"]", "", converted))
  converted <- gsub("[^a-z0-9]+", "-", converted)
  converted <- gsub("(^-+|-+$)", "", converted)
  substr(converted, 1L, 52L)
}

parse_headings <- function(chapter, directory = root) {
  path <- file.path(directory, paste0(chapter, ".qmd"))
  if (!file.exists(path)) stop("Capítulo não encontrado: ", path, call. = FALSE)
  lines <- readLines(path, warn = FALSE, encoding = "UTF-8")
  in_fence <- FALSE
  found <- list()
  for (i in seq_along(lines)) {
    if (grepl("^```", lines[[i]])) {
      in_fence <- !in_fence
      next
    }
    if (in_fence || !grepl("^#{1,6}[[:space:]]+", lines[[i]])) next
    raw <- sub("^#{1,6}[[:space:]]+", "", lines[[i]])
    found[[length(found) + 1L]] <- data.frame(
      chapter = chapter,
      heading = strip_attributes(raw),
      raw = raw,
      line = i,
      stringsAsFactors = FALSE
    )
  }
  if (!length(found)) stop("Nenhum título encontrado em ", path, call. = FALSE)
  do.call(rbind, found)
}

target_chapters <- unique(relations$target)
target_headings <- do.call(rbind, lapply(target_chapters, parse_headings))

resolved <- vector("list", nrow(relations))
for (i in seq_len(nrow(relations))) {
  candidates <- target_headings[
    target_headings$chapter == relations$target[[i]] &
      target_headings$heading == relations$heading[[i]],
    ,
    drop = FALSE
  ]
  if (nrow(candidates) != 1L) {
    stop(
      "A remissão de ", relations$source[[i]], " para ", relations$target[[i]],
      " deve localizar um único título: '", relations$heading[[i]],
      "'. Encontrados: ", nrow(candidates), ".",
      call. = FALSE
    )
  }
  raw <- candidates$raw[[1L]]
  label <- explicit_id(raw)
  if (is.na(label)) {
    label <- paste0(
      "sec-related-", relations$target[[i]], "-", ascii_slug(relations$heading[[i]])
    )
  }
  resolved[[i]] <- data.frame(
    source = relations$source[[i]],
    target = relations$target[[i]],
    heading = relations$heading[[i]],
    target_raw = raw,
    target_line = candidates$line[[1L]],
    online_id = online_id(raw),
    label = label,
    stringsAsFactors = FALSE
  )
}
entries <- do.call(rbind, resolved)

begin_marker <- "<!-- BEGIN GENERATED SEE ALSO -->"
end_marker <- "<!-- END GENERATED SEE ALSO -->"

remove_generated <- function(lines) {
  begins <- which(lines == begin_marker)
  ends <- which(lines == end_marker)
  if (!length(begins) && !length(ends)) return(lines)
  if (length(begins) != 1L || length(ends) != 1L || ends < begins) {
    stop("Bloco Veja também gerado está inconsistente.", call. = FALSE)
  }
  keep <- seq_along(lines) < begins | seq_along(lines) > ends
  lines <- lines[keep]
  while (length(lines) && !nzchar(lines[[length(lines)]])) lines <- lines[-length(lines)]
  lines
}

if (mode == "build") {
  page_path <- if (length(args) >= 3L) args[[3L]] else ""
  pages <- NULL
  if (nzchar(page_path)) {
    pages <- read.delim(
      normalizePath(page_path, mustWork = TRUE),
      sep = "\t",
      quote = "",
      stringsAsFactors = FALSE,
      check.names = FALSE
    )
    if (!all(c("label", "page") %in% names(pages))) {
      stop("O mapa de páginas deve conter as colunas label e page.", call. = FALSE)
    }
  }

  generated_sources <- names(chapter_titles)[vapply(names(chapter_titles), function(source) {
    path <- file.path(root, paste0(source, ".qmd"))
    file.exists(path) && any(
      readLines(path, warn = FALSE, encoding = "UTF-8") == begin_marker
    )
  }, logical(1L))]
  build_sources <- unique(c(entries$source, generated_sources))

  for (source in build_sources) {
    path <- file.path(root, paste0(source, ".qmd"))
    lines <- remove_generated(readLines(path, warn = FALSE, encoding = "UTF-8"))
    related <- entries[entries$source == source, , drop = FALSE]
    if (!nrow(related)) {
      writeLines(lines, path, useBytes = TRUE)
      next
    }
    block <- c(
      "",
      "",
      begin_marker,
      "::: {.content-hidden when-format=\"typst\"}",
      sprintf("## Veja também {#sec-veja-tambem-%s}", source),
      ""
    )
    for (i in seq_len(nrow(related))) {
      page_text <- ""
      if (!is.null(pages)) {
        page <- pages$page[match(related$label[[i]], pages$label)]
        if (length(page) != 1L || is.na(page)) {
          stop("Página não encontrada para ", related$label[[i]], ".", call. = FALSE)
        }
        page_text <- sprintf(" Na edição impressa, p. %s.", page)
      }
      link_text <- sprintf(
        "%s — seção “%s”",
        unname(chapter_titles[[related$target[[i]]]]),
        related$heading[[i]]
      )
      block <- c(
        block,
        sprintf(
          "- [%s](%s.html#%s).%s",
          link_text,
          related$target[[i]],
          related$online_id[[i]],
          page_text
        ),
        ""
      )
    }
    block <- c(block, ":::", end_marker)
    writeLines(c(lines, block), path, useBytes = TRUE)
  }
  message("Seções Veja também geradas em ", length(unique(entries$source)), " capítulos.")
}

add_identifier <- function(line, label) {
  raw <- sub("^#{1,6}[[:space:]]+", "", line)
  current <- explicit_id(raw)
  if (!is.na(current)) {
    if (current != label) stop("Título já possui outro identificador: ", line, call. = FALSE)
    return(line)
  }
  if (grepl("[[:space:]]+\\{[^}]*\\}[[:space:]]*$", line, perl = TRUE)) {
    return(sub("\\}[[:space:]]*$", paste0(" #", label, "}"), line, perl = TRUE))
  }
  paste0(line, " {#", label, "}")
}

if (mode == "inject") {
  unique_targets <- unique(entries[, c("target", "heading", "label"), drop = FALSE])
  for (target in unique(unique_targets$target)) {
    path <- file.path(root, paste0(target, ".qmd"))
    lines <- readLines(path, warn = FALSE, encoding = "UTF-8")
    parsed <- parse_headings(target, root)
    selected <- unique_targets[unique_targets$target == target, , drop = FALSE]
    for (i in seq_len(nrow(selected))) {
      candidate <- parsed[parsed$heading == selected$heading[[i]], , drop = FALSE]
      if (nrow(candidate) != 1L) {
        stop("Título de destino não localizado após a sincronização: ", selected$heading[[i]], call. = FALSE)
      }
      line_number <- candidate$line[[1L]]
      lines[[line_number]] <- add_identifier(lines[[line_number]], selected$label[[i]])
    }
    writeLines(lines, path, useBytes = TRUE)
  }

  for (source in unique(entries$source)) {
    path <- file.path(root, paste0(source, ".qmd"))
    lines <- readLines(path, warn = FALSE, encoding = "UTF-8")
    related <- entries[entries$source == source, , drop = FALSE]
    block <- c("", "## Veja também", "")
    for (i in seq_len(nrow(related))) {
      block <- c(
        block,
        sprintf(
          "- %s — seção “%s”, @%s.",
          unname(chapter_titles[[related$target[[i]]]]),
          related$heading[[i]],
          related$label[[i]]
        ),
        ""
      )
    }
    writeLines(c(lines, block), path, useBytes = TRUE)
  }
  message("Remissões impressas injetadas em ", length(unique(entries$source)), " capítulos.")
}

if (mode == "pages") {
  if (length(args) < 3L) stop("Informe o caminho do PDF.", call. = FALSE)
  pdf <- normalizePath(args[[3L]], mustWork = TRUE)
  destinations <- system2("pdfinfo", c("-dests", pdf), stdout = TRUE, stderr = TRUE)
  pattern <- '^\\s*([0-9]+).*"([^"]+)"\\s*$'
  matched <- grepl(pattern, destinations, perl = TRUE)
  page_map <- data.frame(
    page = as.integer(sub(pattern, "\\1", destinations[matched], perl = TRUE)),
    label = sub(pattern, "\\2", destinations[matched], perl = TRUE),
    stringsAsFactors = FALSE
  )
  wanted <- unique(entries$label)
  result <- page_map[match(wanted, page_map$label), c("label", "page"), drop = FALSE]
  if (any(is.na(result$page))) {
    stop(
      "Destinos ausentes no PDF: ",
      paste(result$label[is.na(result$page)], collapse = ", "),
      call. = FALSE
    )
  }
  output <- file.path(root, "see-also-pages.tsv")
  write.table(result, output, sep = "\t", row.names = FALSE, quote = FALSE, fileEncoding = "UTF-8")
  message("Mapa de páginas gravado em ", output, ".")
}
