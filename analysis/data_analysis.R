
# Data Analysis -----------------------------------------------------------

library(GAD)
library(lme4)
library(multcomp)
library(agricolae)
library(dplyr)

# Import Data -------------------------------------------------------------

expr_data <- read.csv(file = "data/expression_data.csv")


# Analysis with GAD package -----------------------------------------------

drug_kind <- as.fixed(expr_data$A)
mice <- as.random(expr_data$B)
cell <- as.random(expr_data$C)

data_aov <- aov(
  expr ~ drug_kind + mice:drug_kind + cell:mice:drug_kind,
  data = expr_data
  )

model_anova <- gad(data_aov)

write.csv(model_anova, file = "data/model_anova.csv", na = "")

# Analysis with lme4 package ----------------------------------------------

expr_data_2 <- expr_data %>% 
  mutate(
    A = as.factor(A),
    B = as.factor(B), 
    C = as.factor(C)
  )

data_lme <- lmer(
  expr ~ 1 + A + (1|B:A) + (1|C:B:A), 
  data = expr_data_2
  )

lme_sum <- summary(data_lme)

capture.output(lme_sum, file = "data/lme_sum.txt")


# Post hoc tests (Tukey) --------------------------------------------------

lght_sum <- summary(glht(data_lme, linfct = mcp(A = "Tukey")))
capture.output(lght_sum, file = "data/lght_sum.txt")

tukey_hsd <- with(expr_data, HSD.test(expr, A, DFerror = 12, MSerror = 29.05))
capture.output(tukey_hsd, file = "data/tukey_hsd.txt")
