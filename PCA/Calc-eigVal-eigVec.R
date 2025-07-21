# Function to read a matrix from the clipboard
read_matrix_from_clipboard <- function() {
  matrix_data <- read.table("clipboard", header = FALSE)
  return(as.matrix(matrix_data))
}

# Function to compute eigenvalues and eigenvectors
compute_eigen <- function(mat) {
  eigen_results <- eigen(mat)
  return(eigen_results)
}

# Function to format a matrix as a string for clipboard
format_matrix_for_clipboard <- function(mat) {
  mat_str <- apply(mat, 1, paste, collapse = "\t")
  return(paste(mat_str, collapse = "\n"))
}

# Main script
# Step 1: Read the matrix from the clipboard
matrix_from_clipboard <- read_matrix_from_clipboard()

# Step 2: Compute the eigenvalues and eigenvectors
eigen_results <- compute_eigen(matrix_from_clipboard)

# Step 3: Set options to print in decimal format
options(scipen = 999)

# Step 4: Print the results
cat("Eigenvalues:\n")
print(eigen_results$values)
cat("\n\n")

cat("Eigenvectors:\n")
print(eigen_results$vectors)
cat("\n")

# Step 5: Format results for copying to clipboard
formatted_results <- list(Eigenvalues = format(eigen_results$values, digits = 6),
                          Eigenvectors = format(eigen_results$vectors, digits = 6))

# Step 6: Convert to data frame for easier formatting
formatted_df <- lapply(formatted_results, function(x) {
  if (is.matrix(x)) {
    x <- t(x)
  }
  return(data.frame(t(x)))
})

# Step 7: Combine into a single data frame
combined_df <- do.call(rbind, formatted_df)

# Step 8: Write combined data frame to clipboard
write.table(combined_df, "clipboard", sep = "\t", row.names = FALSE, col.names = TRUE)

