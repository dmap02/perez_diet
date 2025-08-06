# Step 0: Install and load all required CRAN and Bioconductor packages

# CRAN packages
cran_packages <- c(
  # Tidyverse (includes dplyr, tidyr, ggplot2, etc.)
  "tidyverse",
  
  # Individual tidyverse elements listed for clarity
  "dplyr", "tidyr", "ggplot2",
  
  # Visualization and plotting
  "ggpubr", "ggprism", "gridExtra", "ggbeeswarm", "ggrepel", "VennDiagram",
  
  # Statistical modeling
  "lmerTest", "rstatix", "broom", "broom.mixed", "vegan",
  
  # Data import and path management
  "readxl", "here"
)

# Bioconductor packages
bioc_packages <- c(
  "dada2", "phyloseq", "microbiome", "phangorn",
  "msa", "genefilter", "ALDEx2"
)

# Install BiocManager if missing
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

# Install and load CRAN packages
for (pkg in cran_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
  library(pkg, character.only = TRUE)
}

# Install and load Bioconductor packages
for (pkg in bioc_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    BiocManager::install(pkg, ask = FALSE)
  }
  library(pkg, character.only = TRUE)
}