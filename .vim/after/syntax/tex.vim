" don't highlight underscores
syntax match texInputFile "_"
    \ contains=texStatement,texInputCurlies,texInputFileOpt
