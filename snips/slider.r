
result_df <- slide_period_dfr(
  .x = df,
  .i = df$date,               # index column (your time column)
  .period = "week",           # slide every 15 minutes
  .origin = min(df$date) + 0, # + whatever gets you to first monday
  .every = 1,                 # slide forward one week at a time
  .f = fn,
  .before = 8,                # look back 8 weeks
  .after =  0,                # up to but not including current week
  .complete = TRUE            # only return complete windows
)                             # extra args pass to fn

