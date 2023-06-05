#' @title do this task
#' 
#' @description a longer description
#' 
#' @param x A number.
#' @param y A number.
#'
#' @returns A numeric vector.
#'
#' @example
#'
#' @export
#'
function_name <- function(df) {
  type = class(df) 
  dt = data.table::copy(data.table::setDT(df))

  return (restore_class(dt))
}

