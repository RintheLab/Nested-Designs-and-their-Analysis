
# Data simulation ---------------------------------------------------------

library(purrr)

set.seed(1)

# Means for B (mice) within A (drug kind)
mice_1 <- round(rnorm(5, mean = 10, sd = 1), 0)
mice_2 <- round(rnorm(5, mean = 11, sd = 1), 0)
mice_3 <- round(rnorm(5, mean =  7, sd = 1), 0)

# Means for C (cells) within B (mice)
cells_1 <- unlist(map(mice_1, rnorm, n = 5, sd = sqrt(2)))
cells_2 <- unlist(map(mice_2, rnorm, n = 5, sd = sqrt(2)))
cells_3 <- unlist(map(mice_3, rnorm, n = 5, sd = sqrt(2)))

# Values for expression taking in to account 3 technical replicates 
expr_1 <- unlist(map(cells_1, rnorm, n = 3, sd = sqrt(0.5)))
expr_2 <- unlist(map(cells_2, rnorm, n = 3, sd = sqrt(0.5)))
expr_3 <- unlist(map(cells_3, rnorm, n = 3, sd = sqrt(0.5)))

# Codes for each factor
# Factor A (Drug kind) [fixed]
factor_a <- rep(1:3, each = 75)

# Factor B (Mouse) [random]
factor_b <- rep(1:5, each = 15, times = 3)

# Factor C (Cell) [random]
factor_c <- rep(1:5, each = 3, times = 15)

# Technical replicates 
tech_rep <- rep(1:3, times = 75)

# Matrix design with the expression levels 
matrix_design <- data.frame(
  tech_rep,
  C = factor_c,
  B = factor_b, 
  A = factor_a,
  expr = c(expr_1, expr_2, expr_3) 
)

# Export data as a CSV file 
write.csv(
  matrix_design, 
  file = "data/expression_data.csv", 
  row.names = FALSE
  )
