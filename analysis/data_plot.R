
# Plot for expression data ------------------------------------------------

library(ggplot2)
library(dplyr)

# Import data -------------------------------------------------------------

expr_data <- read.csv("data/expression_data.csv")


# Add news columns for groups ---------------------------------------------

expr_data_2 <- expr_data %>% 
  mutate(
    A       = as.factor(A),
    group_a = rep(c(13, 38, 63), each = 75),            # Drug kind
    group_b = rep(seq(3, 73, by = 5), each = 15),       # Mice  
    group_c = rep(1:75, each = 3)                       # Cells 
  )


# Scatter plot -------------------------------------------------------------

# Scatter plot with geom_point

expr_plot <- ggplot(expr_data_2, aes(x = group_c, y = expr)) +
  geom_point(aes(color = A), size = 1) +
  stat_summary(
    fun = mean, geom = "crossbar", width = 0.5, color = "black", size = 0.3
  ) +
  stat_summary(
    aes(x = group_a, y = expr), 
    fun = mean, geom = "crossbar", width = 25, color = "blue", size = 0.3
  ) +
  stat_summary(
    aes(x = group_b, y = expr),
    fun = mean, geom = "crossbar", width = 4.5, color = "red", size = 0.3
  ) +
  labs(color = "Drug", y = "Expression", x = " ") +
  scale_x_continuous(breaks = c(13, 38, 63), labels = c("", "", "")) +
  theme_classic() +
  theme(
    axis.title.y = element_text(face = "bold", color = "black", size = rel(1.3)),
    axis.text.y  = element_text(color = "black", size = rel(1.2)),
    legend.text  = element_text(size = rel(1.1)),
    legend.title = element_text(face = "bold", size = rel(1.2))
    )

# Save the plot
ggsave(
  "graphs/expr_plot.jpeg", 
  plot = expr_plot, 
  units = "cm", width = 20, height = 10,
  dpi = 500
  )
