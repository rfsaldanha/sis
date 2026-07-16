#!/usr/bin/env Rscript

# Gera a lista de siglas usada no pré-textual do PDF online. A página HTML
# continua sendo produzida diretamente de siglas.qmd.

args <- commandArgs(trailingOnly = FALSE)
script_arg <- grep("^--file=", args, value = TRUE)
script_path <- if (length(script_arg)) sub("^--file=", "", script_arg[[1L]]) else "scripts/build_acronym_frontmatter.R"
root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
source_path <- file.path(root, "siglas.qmd")
output_path <- file.path(root, "siglas.tex")

lines <- readLines(source_path, warn = FALSE, encoding = "UTF-8")

title_line <- grep("^# Lista de siglas", lines)
if (length(title_line) != 1L) stop("Título da lista de siglas não localizado.", call. = FALSE)

first_typst <- grep("^```\\{=typst\\}$", lines)
if (!length(first_typst)) stop("Bloco Typst da lista de siglas não localizado.", call. = FALSE)

intro <- lines[seq.int(title_line + 1L, first_typst[[1L]] - 1L)]
intro <- trimws(paste(intro[nzchar(trimws(intro))], collapse = " "))

term_rows <- which(seq_along(lines) < length(lines) & grepl("^: ", lines[seq_along(lines) + 1L]))
if (length(term_rows) < 100L) stop("Foram localizadas poucas siglas; verifique siglas.qmd.", call. = FALSE)

terms <- lines[term_rows]
descriptions <- sub("^: ", "", lines[term_rows + 1L])

# Confere as siglas introduzidas entre parênteses no texto. Prefixos de
# arquivos e nomes de variáveis são deliberadamente excluídos, conforme a
# nota editorial de siglas.qmd.
source_paths <- setdiff(
  list.files(root, pattern = "\\.qmd$", full.names = TRUE),
  source_path
)
source_text <- paste(vapply(source_paths, function(path) {
  paste(readLines(path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
}, character(1L)), collapse = "\n")
normalize_acronym <- function(value) gsub("-", "/", value, fixed = TRUE)
listed_acronyms <- unique(normalize_acronym(c(
  terms,
  unlist(strsplit(terms, "/", fixed = TRUE), use.names = FALSE)
)))
introduced_matches <- regmatches(
  source_text,
  gregexpr("\\(([A-Z][A-Z0-9/-]{1,})\\)", source_text, perl = TRUE)
)[[1L]]
introduced_acronyms <- if (length(introduced_matches) && !identical(introduced_matches, "-1")) {
  normalize_acronym(substring(introduced_matches, 2L, nchar(introduced_matches) - 1L))
} else {
  character()
}
technical_identifiers <- normalize_acronym(c(
  "CHSAMB", "CHSHOSP", "CHSOUTR", "CIINFO", "CODMUN", "CODMUNRES",
  "DT", "LATITUDE", "LOGRADOURO", "LONGITUDE", "PESO"
))
missing_acronyms <- sort(setdiff(
  unique(introduced_acronyms),
  c(listed_acronyms, technical_identifiers)
))
if (length(missing_acronyms)) {
  stop(
    "Siglas introduzidas no texto sem entrada na lista: ",
    paste(missing_acronyms, collapse = ", "), ".",
    call. = FALSE
  )
}

latex_text <- function(x) {
  x <- gsub("\\*([^*]+)\\*", "\u0001\\1\u0002", x, perl = TRUE)
  x <- gsub("\\", "\\textbackslash{}", x, fixed = TRUE)
  x <- gsub("([#$%&_{}])", "\\\\\\1", x, perl = TRUE)
  x <- gsub("~", "\\textasciitilde{}", x, fixed = TRUE)
  x <- gsub("^", "\\textasciicircum{}", x, fixed = TRUE)
  x <- gsub("\u0001", "\\emph{", x, fixed = TRUE)
  gsub("\u0002", "}", x, fixed = TRUE)
}

entries <- unlist(Map(
  function(term, description) sprintf(
    "\\noindent\\textbf{%s}\\hspace{1em}%s\\par\\smallskip",
    latex_text(term),
    latex_text(description)
  ),
  terms,
  descriptions
), use.names = FALSE)

output <- c(
  "% Gerado por scripts/build_acronym_frontmatter.R; não editar manualmente.",
  "\\chapter*{Lista de siglas}",
  "\\markboth{Lista de siglas}{Lista de siglas}",
  "\\begingroup",
  "\\setlength{\\parindent}{0pt}",
  "\\setlength{\\parskip}{0pt}",
  sprintf("%s\\par\\medskip", latex_text(intro)),
  entries,
  "\\endgroup",
  "\\clearpage"
)

writeLines(output, output_path, useBytes = TRUE)
message("Pré-textual de siglas gerado em ", output_path, ".")
