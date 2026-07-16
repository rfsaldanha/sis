#!/usr/bin/env Rscript

# Gera o índice remissivo da edição online e injeta as marcas usadas pelo
# índice automático da edição impressa. O arquivo index-terms.tsv é a fonte
# editorial única para as duas apresentações.

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2L || !args[[1L]] %in% c("build", "inject")) {
  stop("Uso: build_subject_index.R <build|inject> <diretório> [manifesto]", call. = FALSE)
}

mode <- args[[1L]]
root <- normalizePath(args[[2L]], mustWork = TRUE)
manifest_path <- if (length(args) >= 3L) args[[3L]] else file.path(root, "index-terms.tsv")
manifest_path <- normalizePath(manifest_path, mustWork = TRUE)

terms <- read.delim(
  manifest_path,
  sep = "\t",
  quote = "",
  comment.char = "",
  stringsAsFactors = FALSE,
  check.names = FALSE,
  fileEncoding = "UTF-8"
)

required_columns <- c("term", "chapter", "heading")
if (!all(required_columns %in% names(terms))) {
  stop("O manifesto deve conter as colunas term, chapter e heading.", call. = FALSE)
}
if (any(!nzchar(terms$term) | !nzchar(terms$chapter) | !nzchar(terms$heading))) {
  stop("O manifesto contém campos vazios.", call. = FALSE)
}

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

heading_id <- function(raw_heading) {
  attributes <- regmatches(raw_heading, regexpr("\\{[^}]*\\}[[:space:]]*$", raw_heading, perl = TRUE))
  if (length(attributes) && nzchar(attributes)) {
    explicit <- regmatches(attributes, regexpr("#[[:alnum:]_.:-]+", attributes, perl = TRUE))
    if (length(explicit) && nzchar(explicit)) {
      return(substring(explicit, 2L))
    }
  }

  identifier <- plain_text(raw_heading)
  identifier <- gsub("--+", "", identifier)
  identifier <- gsub("[^\\p{L}\\p{N}_. -]", "", identifier, perl = TRUE)
  identifier <- gsub("[[:space:]]+", "-", identifier, perl = TRUE)
  identifier <- tolower(identifier)
  identifier <- sub("^[^\\p{L}]*", "", identifier, perl = TRUE)
  if (!nzchar(identifier)) "section" else identifier
}

parse_headings <- function(chapter, directory = root) {
  path <- file.path(directory, paste0(chapter, ".qmd"))
  if (!file.exists(path)) {
    stop("Capítulo não encontrado: ", path, call. = FALSE)
  }

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
    level <- nchar(sub("^(#{1,6}).*$", "\\1", lines[[i]]))
    found[[length(found) + 1L]] <- data.frame(
      chapter = chapter,
      heading = strip_attributes(raw),
      label = plain_text(raw),
      id = heading_id(raw),
      level = level,
      line = i,
      stringsAsFactors = FALSE
    )
  }
  if (!length(found)) stop("Nenhum título encontrado em ", path, call. = FALSE)
  do.call(rbind, found)
}

chapters <- unique(terms$chapter)
headings <- do.call(rbind, lapply(chapters, parse_headings))

resolve_targets <- function() {
  resolved <- vector("list", nrow(terms))
  for (i in seq_len(nrow(terms))) {
    candidates <- headings[
      headings$chapter == terms$chapter[[i]] & headings$heading == terms$heading[[i]],
      ,
      drop = FALSE
    ]
    if (nrow(candidates) != 1L) {
      stop(
        "O termo '", terms$term[[i]], "' deve corresponder a um único título em ",
        terms$chapter[[i]], ".qmd: '", terms$heading[[i]], "'. Encontrados: ",
        nrow(candidates), ".",
        call. = FALSE
      )
    }
    resolved[[i]] <- cbind(terms[i, , drop = FALSE], candidates[, c("label", "id", "level", "line")])
  }
  do.call(rbind, resolved)
}

entries <- resolve_targets()

sort_key <- function(x) {
  x <- plain_text(x)
  converted <- iconv(x, from = "UTF-8", to = "ASCII//TRANSLIT")
  converted[is.na(converted)] <- x[is.na(converted)]
  converted <- toupper(converted)
  converted <- gsub("['`^~\"]", "", converted)
  converted <- gsub("[^A-Z0-9]", " ", converted)
  trimws(gsub("[[:space:]]+", " ", converted))
}

html_escape <- function(x) {
  x <- gsub("&", "&amp;", x, fixed = TRUE)
  x <- gsub("<", "&lt;", x, fixed = TRUE)
  x <- gsub(">", "&gt;", x, fixed = TRUE)
  gsub('"', "&quot;", x, fixed = TRUE)
}

chapter_labels <- c(
  introducao = "Introdução",
  historico = "Histórico",
  organizacao = "Organização dos SIS",
  eventos = "Eventos de saúde",
  sim = "SIM",
  sinasc = "SINASC",
  sih = "SIH/SUS",
  sia = "SIA/SUS",
  sinan = "SINAN",
  cnes = "CNES",
  siscan = "SISCAN",
  sisagua = "SISAGUA",
  siops = "SIOPS",
  sisaps = "SISAPS",
  sipni = "SI-PNI",
  rnds = "RNDS",
  quadro_resumo = "Quadro-resumo",
  cid = "CID",
  codmun = "Códigos dos municípios",
  pop = "Estimativas populacionais",
  inqueritos = "Inquéritos de saúde",
  sivep = "SIVEP",
  sisvan = "SISVAN",
  ans = "ANS",
  interoperabilidade = "Interoperabilidade"
)

if (mode == "build") {
  entries$sort <- sort_key(entries$term)
  entries <- entries[order(entries$sort, entries$term, entries$chapter, entries$line), , drop = FALSE]
  grouped <- split(entries, entries$term)
  grouped <- grouped[order(vapply(grouped, function(x) x$sort[[1L]], character(1L)))]
  letters <- unique(substr(vapply(grouped, function(x) x$sort[[1L]], character(1L)), 1L, 1L))

  output <- c(
    "<!-- Arquivo gerado por scripts/build_subject_index.R. -->",
    "",
    "# Índice remissivo {#sec-indice-remissivo .unnumbered}",
    "",
    "Este índice reúne sistemas, documentos, conceitos, métodos e eventos de saúde tratados no livro. Na versão online, cada remissão leva diretamente à seção correspondente.",
    "",
    paste(sprintf("[%s](#indice-%s)", letters, tolower(letters)), collapse = " · "),
    ""
  )

  for (letter in letters) {
    output <- c(output, sprintf("## %s {#indice-%s .unnumbered}", letter, tolower(letter)), "", ":::: {.subject-index}")
    selected <- grouped[substr(vapply(grouped, function(x) x$sort[[1L]], character(1L)), 1L, 1L) == letter]
    for (item in selected) {
      links <- character()
      for (i in seq_len(nrow(item))) {
        chapter_label <- unname(chapter_labels[[item$chapter[[i]]]])
        if (is.null(chapter_label)) chapter_label <- item$chapter[[i]]
        link_label <- if (item$level[[i]] == 1L) {
          chapter_label
        } else {
          paste0(chapter_label, ": ", item$label[[i]])
        }
        href <- if (item$level[[i]] == 1L) {
          sprintf("%s.html", html_escape(item$chapter[[i]]))
        } else {
          sprintf(
            "%s.html#%s",
            html_escape(item$chapter[[i]]),
            html_escape(item$id[[i]])
          )
        }
        links <- c(links, sprintf("[%s](%s)", link_label, href))
      }
      links <- unique(links)
      output <- c(
        output,
        "::: {.subject-index-entry}",
        sprintf(
          "[%s]{.subject-index-term} — %s",
          plain_text(item$term[[1L]]),
          paste(links, collapse = "; ")
        ),
        ":::"
      )
    }
    output <- c(output, "::::", "")
  }

  writeLines(output, file.path(root, "indice.qmd"), useBytes = TRUE)
  message("Índice online gerado com ", length(grouped), " termos e ", nrow(entries), " remissões.")
}

typst_escape <- function(x) {
  x <- gsub("\\\\", "\\\\\\\\", x)
  gsub('"', '\\\\"', x, fixed = TRUE)
}

if (mode == "inject") {
  by_chapter <- split(entries, entries$chapter)
  for (chapter in names(by_chapter)) {
    path <- file.path(root, paste0(chapter, ".qmd"))
    lines <- readLines(path, warn = FALSE, encoding = "UTF-8")
    chapter_entries <- by_chapter[[chapter]]
    by_line <- split(chapter_entries, chapter_entries$line)
    for (line_number in rev(sort(as.integer(names(by_line))))) {
      item <- by_line[[as.character(line_number)]]
      markers <- vapply(unique(item$term), function(term) {
        display <- plain_text(term)
        key <- sort_key(display)
        sprintf('#index("%s!%s")', typst_escape(key), typst_escape(display))
      }, character(1L))
      block <- c("```{=typst}", markers, "```", "")
      lines <- append(lines, block, after = line_number - 1L)
    }
    writeLines(lines, path, useBytes = TRUE)
  }

  message("Marcas do índice impresso injetadas em ", length(by_chapter), " capítulos.")
}
