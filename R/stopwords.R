#' Collection of stopwords in multiple langauges
#'
#' This function returns stopwrods colated for Stopwords ISO library
#' (\url{https://github.com/stopwords-iso/stopwords-iso}).
#' @param langauge specify language of stopwords by ISO 639-1 code
#' @return a character cector containing stopwords
#' @export
#'
#' @examples
#' languages() # returns all available languages
#' stopwords('en')
#' stopwords('jp')
stopwords <- function(langauge = 'en') {
    langauge <- tolower(langauge)
    load('data/data_char_stopwords_iso.RData')
    if (!langauge %in% names(data_char_stopwords_iso))
        stop(paste0("\"", langauge, "\" is not in Stopwords ISO library."))
    data_char_stopwords_iso[[langauge]]
}

#' Returns all the ISO 639-1 code available in the Stopwords ISO library
#'
#' See \url{https://en.wikipedia.org/wiki/ISO_639-1} for details of the language code.
#' @export
#' @examples
#' languages()
languages <- function() {
    load('data/data_char_stopwords_iso.RData')
    code <- names(data_char_stopwords_iso)
    labels <- na.omit(ISOcodes::ISO_639_2[,c('Alpha_2', 'Name')])
    names(code) <- labels$Name[match(code, labels$Alpha_2)]
    return(code)
}

#' Internal function to update the data file
#' @keywords internal
#' @examples
#' stopwords:::update_stopwords()
update_stopwords <- function() {

    url <- 'https://raw.githubusercontent.com/stopwords-iso/stopwords-iso/master/stopwords-iso.json'
    json <- paste0(readLines(url, warn = FALSE), collapse="")
    data_char_stopwords_iso <- rjson::fromJSON(json)
    cat('Downloaded stopwords for', length(data), 'langauges.\n')
    path <- 'data/data_char_stopwords_iso.RData'
    save(data_char_stopwords_iso, file = path)
    cat('Saved to', path, '.\n')

}

#' RData file created from Stopwords ISO library
#'
#' @name data_char_stopwords_iso
#' @docType data
#' @keywords data
NULL

