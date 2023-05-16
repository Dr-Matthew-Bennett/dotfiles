ggplot(df, aes(x, y, color = z, group = z)) +
    geom_line() +
    geom_point()

