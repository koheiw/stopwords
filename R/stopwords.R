# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'


#' Collection of stopwords in multiple langauges
#'
#' This function returns stopwrods colated for Stopwords ISO library
#' (\url{https://github.com/stopwords-iso/stopwords-iso}).
#' @param langauge ISO 639-1 language code
#' @return a character cector containing stopwords
#' @export
#'
#' @examples
#' stopwords('en')
#' stopwords('jp')
stopwords <- function(langauge = 'en') {
    if (!(langauge %in% names(stopwords::data_char_stopwords_iso)))
        stop(paste0("\"", kind, "\" is not a iso code for stopwords."))
    stopwords::data_char_stopwords_iso[[langauge]]
}

#' Internal function to update the data file
#' @keywords internal
update_stopwords <- function() {

    url <- 'https://raw.githubusercontent.com/stopwords-iso/stopwords-iso/master/stopwords-iso.json'
    json <- paste0(readLines(url, warn = FALSE), collapse="")
    data <- rjson::fromJSON(json)
    cat('Downloaded stopwords for', length(data), 'langauges\n')
    name <- 'data_char_stopwords_iso.RData'
    save(data, file = name)
    cat('Saved as ', name, '\n')
}


