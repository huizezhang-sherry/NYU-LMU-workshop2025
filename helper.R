get_most_common_method <- function(df, cols = c("time_parameter_method",
                                                "humidity_parameter_method",
                                                "temperature_parameter_method")) {
  df %>%
    pivot_decision_tbl_wider() |>
    rowwise() %>%
    mutate(method = {
      vals <- c_across(all_of(cols))
      vals <- vals[!is.na(vals)]
      if (length(vals) == 0) NA_character_
      else names(sort(table(vals), decreasing = TRUE))[1]
    }) %>%
    ungroup() |>
    select(paper, method)
}
