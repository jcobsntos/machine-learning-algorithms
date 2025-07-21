# Read data from clipboard
data <- read.table("clipboard", header = TRUE)

# Perform PCA
pca <- prcomp(data, scale. = TRUE)

# Biplot of PCA
biplot(pca, cex = 0.8, col = c("blue", "red"))

