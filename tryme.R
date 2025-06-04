library(tidyverse)
library(text)
library(dossier)
library(ggdendro)
library(ggrepel)
library(patchwork)
source("helper.R")

######################################################################
################################ easy ################################
######################################################################
paper_df <- read_rds("data/papers_df.rds")

# calculate decision similarity and paper similarity
embed_df <- paper_df |> compute_text_embed()
(distance_decision_df <- calc_decision_similarity(paper_df, embed = embed_df))
(distance_df <- distance_decision_df |> calc_paper_similarity())

# diagnostic table
# There are two paper pairs that calculate the paper similarity based on three decisions.
# This accounts for 13.3% of all the paper pairs and their average similarity score is0.194
diag_decision_ppp(distance_decision_df, distance_df)
view_pairs(paper_df, distance_decision_df, "ostro", "peel")
# cluster the paper by hierarchical clustering and multi-dimensional scaling
hclust_res <- run_hclust(distance_df, "ave")
mds_res <- run_mds(distance_df)

# find the most common method for each paper for plotting
method_df <- paper_df |> get_most_common_method() # from `helper.R`
hclust_res$labels <- hclust_res$labels |> left_join(method_df, by = c("label" = "paper"))
mds_df <- mds_res |> left_join(method_df, by = "paper")

# plot the dendrogram and multi-dimensional scaling
p2 <- ggplot() +
  geom_segment(data = segment(hclust_res), aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_text(data = hclust_res$labels,
            aes(x = x, y = y, label = label, color = method, hjust = 0),
            size = 3) +
  coord_flip() +
  theme_void() +
  scale_color_brewer(palette = "Dark2") +
  scale_y_reverse(expand = c(0.2, 0))

p3 <- mds_df |> ggplot(aes(x = V1, y = V2)) +
  ggrepel::geom_text_repel(aes(label = paper, color = method)) +
  theme_bw() +
  theme(aspect.ratio = 1) +
  scale_color_brewer(palette = "Dark2") +
  ggtitle("Multi-dimensional scaling")

(p2 | p3) & theme(legend.position = "bottfom")


########################################################################
################################ medium ################################
########################################################################
# Goal: from the LLM output, we would like to take a subset of all variables to compare
raw_df <- readr::read_csv(system.file("papers.csv", package = "dossier"))
(tbl_df <- as_decision_tbl(raw_df))

# select the variable-type pair to compare papers
count_variable_type(tbl_df)
paper_df <- tbl_df |> filter_var_type(n = 6) # first 6 variable-type pairs
paper_df2 <- tbl_df |> filter_var_type(n_value = 3) # cut-off value of n = 3
identical(paper_df, paper_df2)

# preview the number of decisions each paper pair will compare on
count_paper_pair_decisions(paper_df)
# `paper_df` here is what you read in from data/ in the easy section

########################################################################
################################ hard ##################################
########################################################################
# use the `ellmer` package to extract the decisions from the paper (pdf)
# For both Gemini and Claude, you will need to obtain an API key
# include them in your .Renviron file (`usethis::edit_r_environ()`):
# ANTHROPIC_API_KEY="YOURKEY"
# GOOGLE_API_KEY="YOURKEY"
# You will need $5 for Claude but Gemini offers free plan.

# create a result directory
fs::dir_create("res")
files <- list.files("papers", full.names = TRUE)
purrr::walk(files, ~extract_decisions(
  prompt_file = system.file("prompt.md", package = "dossier"),
  pdf = .x, llm_model = "gemini",
  file = paste0("res/", tools::file_path_sans_ext(basename(.x)), ".md")
))

map_dfr(list.files("res/", full.names = TRUE), clean_md)

# Explore the reproducibility of LLM output
purrr::walk(1:5, ~extract_decisions(
  prompt_file = system.file("prompt.md", package = "dossier"),
  pdf = files[1], llm_model = "gemini",
  file = paste0("res/braga-", .x, ".md")
))

map(list.files("res/", pattern = "braga-", full.names = TRUE), clean_md)

# To have a more stable LLM output, consider including temperature and seed argument
purrr::walk(1:5, ~extract_decisions(
  prompt_file = system.file("prompt.md", package = "dossier"),
  pdf = files[1], llm_model = "gemini", temperature = 0, seed = 123,
  file = paste0("res/braga-", .x, ".md")
))

map(list.files("res/", pattern = "braga-", full.names = TRUE), clean_md)

