# Main script to run the analysis -----------------------------------------

# Preferably, before you run this script restart your R session: 
# Ctrl+Shift+F10 if you are using RStudio

# 1 Data Simulation
source("analysis/data_simulation.R")

# 2 Data Visualization
source("analysis/data_plot.R")

# 3 Data Analysis
source("analysis/data_analysis.R")

# 5 Session info
capture.output(sessionInfo(), file = "Session_Info.txt")