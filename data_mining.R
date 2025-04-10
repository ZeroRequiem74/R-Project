# Load required library
library(arules)

# ----- R Data Types -----
numeric_val <- 42.0               # Numeric
char_val <- "Association Rules"   # Character
logical_val <- TRUE               # Logical
data_list <- list()               # List
df_example <- data.frame(Name = c("A", "B"), Value = c(1, 2))  # Data Frame

cat("Various R Data Types Used:\n")
cat("Numeric:", numeric_val, "\n")
cat("Character:", char_val, "\n")
cat("Logical:", logical_val, "\n")
cat("Data Frame:\n")
print(df_example)

# ----- Read and Process CSV -----
# Convert to transaction format
cat("\nReading CSV and processing transactions...\n")
raw_data <- read.transactions("transactions.csv", format = "basket", sep = ",", rm.duplicates = TRUE)

# Summary
cat("\nTransaction Summary:\n")
summary(raw_data)

# ----- Mine Association Rules -----
rules <- apriori(raw_data, parameter = list(supp = 0.4, conf = 0.6))

# ----- Case block for output options -----
output_option <- "summary"  # Change to "inspect" or "loop" to see other behaviors

cat("\nOutput option selected:", output_option, "\n")
switch(output_option,
       "summary" = {
         cat("\nSummary of Rules:\n")
         summary(rules)
       },
       "inspect" = {
         cat("\nInspecting Rules:\n")
         inspect(rules)
       },
       "loop" = {
         cat("\nLooping through Rules:\n")
         rules_list <- as(rules, "list")
         for (i in seq_along(rules_list)) {
           cat(sprintf("Rule %d: %s\n", i, rules_list[[i]]))
         }
       },
       {
         cat("Invalid option\n")
       }
)

cat("\nDone mining association rules!\n")
