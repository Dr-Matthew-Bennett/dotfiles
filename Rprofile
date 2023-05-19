### environment and options ###################################################

# specify which cran mirror to use so I don't have to pick on startup
local({r <- getOption("repos")
        r["CRAN"] <- "https://cran.r-project.org" 
        options(repos=r)
        })

# error when using if condition logical vector of greater than length 1
Sys.setenv("_R_CHECK_LENGTH_1_CONDITION_" = "true")

# when subsetting a data frame with df$var, tell me if var was not in there but
# some other column partially matched (i.e. variance)
options(warnPartialMatchDollar = TRUE)

# always warn when R 'takes advantage' of partial matching of arguments
options(warnPartialMatchArgs = TRUE)

# print as wide as possible (but adjust as terminal is resized)
# options(width = Sys.getenv("COLUMNS"))
options(width = 210)
options(setWidthOnResize = TRUE)

### aliasing and functions ####################################################
cl <- function() {
    system('clear')
}

pwd <- function() {
    system('pwd')
}

