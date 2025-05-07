#reading small file
meddata <- read.csv("HospitalDischargesSmall.csv")
#understanding the data in the small file
str(meddata)
summary(meddata)

#installing fread to read read large file
#install.packages("data.table")
library(data.table)
#my_data <- fread("HospitalDischarges.csv")
#my_data <- fread("HD3.csv")
my_data <- fread("HospitalDischargesSmall.csv")
#understanding the data in the large file
str(my_data)
summary(my_data)
head(my_data)

#cleaning data to remove + icon from length of stay column
my_data$`Length of Stay`[my_data$`Length of Stay` == '120 +'] <- 120
#force it to read as numeric data
my_data$`Length of Stay` <- as.numeric(my_data$`Length of Stay`)
#viewing data from length of stay column
summary(my_data$`Length of Stay`)
table(my_data$`Length of Stay`)
my_data[, .N, by = `Length of Stay`]


#remove commas from total charges column, not needed as data doesn't contian it
#my_data$`Total Charges` <- gsub(',', '', my_data$`Total Charges`)
#remove $ and read as numeric
my_data$`Total Charges` <- as.numeric(gsub('\\$', '', my_data$`Total Charges`))
#viewing data from total charges column
summary(my_data$`Total Charges`)
table(my_data$`Total Charges`)


#remove commas from total costs column, not needed as data doesn't contian it
#my_data$`Total Costs` <- gsub(',', '', my_data$`Total Costs`)
#remove $ and read as numeric
my_data$`Total Costs` <- as.numeric(gsub('\\$', '', my_data$`Total Costs`))
#viewing data from total costs column
summary(my_data$`Total Costs`)
table(my_data$`Total Costs`)

#seeing what else may need to be cleaned
View(my_data)
head(my_data)

#finding the number of unique values within each column
for(column_name in names(my_data)) {
  unique_values <- unique(my_data[[column_name]])
  unique_values_count <- length(unique_values)
  
  cat("Column:", column_name, "\n")
  cat("Number of unique values:", unique_values_count, "\n")
  
  if(unique_values_count > 100) {
    cat("Unique values: More than 100 unique values, listing first 10:", toString(head(unique_values, 10)), "\n\n")
  } else {
    cat("Unique values:", toString(unique_values), "\n\n")
  }
}


# Create the scatter plot of total charges against illness code
library(scales)
ggplot(my_data, aes(x = `APR Severity of Illness Code`, y = `Total Charges`)) +
  geom_point() +
  theme_minimal() +
  labs(title = "Scatter Plot of Total Charges vs. APR Severity of Illness Code",
       x = "APR Severity of Illness Code",
       y = "Total Charges") +
  scale_y_continuous(labels = label_number())


# Create the scatter plot of total charges against illness code
ggplot(my_data, aes(x = `Length of Stay`, y = `Total Charges`)) +
  geom_point() +
  
  labs(title = "Scatter Plot of Total Charges vs. Length of Stay",
       x = "Length of Stay",
       y = "Total Charges") +
  scale_y_continuous(labels = label_number())
# Count occurrences of each unique value
# Sort counts in ascending order
counts <- table(my_data$`APR MDC Code`)
sorted_counts <- sort(counts)
print(sorted_counts)



# Visualize the distribution of counts
barplot(sorted_counts, main = "Category Counts in 'APR MDC Code'", xlab = "Categories", ylab = "Counts")
cumsum_counts <- cumsum(sorted_counts) / sum(sorted_counts) * 100
# Plot the cumulative frequency plot
plot(cumsum_counts, type = 's', xlab = "Categories", ylab = "Cumulative Percentage", main = "Cumulative Distribution of Category Counts")

# Add a cutoff line at 10%
abline(h = 10, col = "red", lty = 2)

# Adding text or arrow to highlight the cutoff
text(x = which.min(abs(cumsum_counts - 10)), y = 10, labels = "10% Cutoff", pos = 4, col = "red")

# Find the last category that is part of the cumulative sum before it exceeds 10%
last_category_under_10 <- max(which(cumsum_counts <= 10))

# Get the names of the categories that are below this 10% cutoff
categories_under_10 <- names(sorted_counts)[1:last_category_under_10]

# Print the list of categories
print(categories_under_10)

# Find the number of categories that represent the lowest 10% of the data
categories_under_10_percent <- sum(cumsum_counts <= 10)

# Calculate the percentage these categories represent of the total number of categories
total_categories <- length(sorted_counts)
percentage_of_total_categories <- (categories_under_10_percent / total_categories) * 100

# Output the results
categories_under_10_percent
percentage_of_total_categories


# Count occurrences of each unique value
# Sort counts in ascending order
counts <- table(my_data$`APR DRG Code`)
sorted_counts <- sort(counts)
print(sorted_counts)

# Count occurrences of each unique value
# Sort counts in ascending order
counts <- table(my_data$`CCS Procedure Code`)
sorted_counts <- sort(counts)
print(sorted_counts)

# Count occurrences of each unique value
# Sort counts in ascending order
counts <- table(my_data$`CCS Diagnosis Code`)
sorted_counts <- sort(counts)
print(sorted_counts)

# Install ggplot2
#install.packages("ggplot2")  
library(ggplot2) 

# bar chart for age group
ggplot(my_data, aes(x = `Age Group`)) +
  geom_bar() +  
  geom_text(stat = 'count', aes(label = ..count..), vjust = -0.5, position = position_dodge(width = 0.9)) + 
  theme_minimal() +
  labs(title = "Distribution of Age Group", x = "Age Group", y = "Count") + 
  theme(
    plot.title = element_text(hjust = 0.5), # Center the title
    axis.text.x = element_text(angle = 45, hjust = 1) # Adjust x-axis labels
  )

# bar chart for type of admission

ggplot(my_data, aes(x = `Type of Admission`)) +
  geom_bar() +  
  geom_text(stat = 'count', aes(label = ..count..), vjust = -0.5, position = position_dodge(width = 0.9)) +
  theme_minimal() +
  labs(title = "Distribution of Type of Admission", x = "Type of Admission", y = "Count") +
  theme(
    plot.title = element_text(hjust = 0.5), # Center the title
    axis.text.x = element_text(angle = 45, hjust = 1) # Adjust x-axis labels
  )


#histogram for Length of Stay
library(scales) 
ggplot(my_data, aes(x = `Length of Stay`)) +
  geom_histogram(fill = "blue", color = "black", binwidth = 1) +  
  scale_x_continuous(breaks = seq(min(my_data$`Length of Stay`), max(my_data$`Length of Stay`), by = 10), 
                     labels = function(x) format(x, big.mark = ",", scientific = FALSE)) +
  scale_y_continuous(labels = comma) + 
  theme_minimal() +
  labs(title = "Length of Stay", x = "Length of Stay", y = "Frequency") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 


# This plots the boxplot for Total Charges
ggplot(my_data, aes(x = `Age Group`, y = `Total Charges`)) +
  geom_boxplot(outlier.colour = "blue", fill = "gray", color = "black") +  # Outliers in blue, box in gray
  stat_summary(fun = mean, geom = "point", shape = 20, size = 3, color = "green",  # Mean in green
               position = position_dodge(width = 0.75)) +
  theme_minimal() +
  labs(title = "Boxplot of Total Charges Across Age Groups", x = "Age Group", y = "Total Charges") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ylim(c(0, 20000)) 


# This plots the boxplot for Total Costs
ggplot(my_data, aes(x = `Age Group`, y = `Total Costs`)) +
  geom_boxplot(outlier.colour = "blue", fill = "gray", color = "black") +  # Outliers in blue, box in gray
  stat_summary(fun = mean, geom = "point", shape = 20, size = 3, color = "green",  # Mean in green
               position = position_dodge(width = 0.75)) +
  theme_minimal() +
  labs(title = "Boxplot of Total Costs Across Age Groups", x = "Age Group", y = "Total Costs") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ylim(c(0, 20000)) 


#calculate difference between the charges and costs
my_data$Difference = my_data$`Total Charges` - my_data$`Total Costs`

#create boxplot for the differences
ggplot(my_data, aes(x = `Age Group`, y = Difference)) +
  geom_boxplot(outlier.colour = "blue", fill = "gray", color = "black") +
  stat_summary(fun = mean, geom = "point", shape = 20, size = 3, color = "green",
               position = position_dodge(width = 0.75)) +
  theme_minimal() +
  labs(title = "Boxplot of Difference Across Age Groups", x = "Age Group", y = "Difference") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) + ylim(c(0, 30000)) 

#create a scatterplot for the difference
ggplot(my_data, aes(x = `Age Group`, y = Difference)) +
  geom_point(alpha = 0.5) +  
  labs(title = "Scatterplot of Difference Across Age Groups", x = "Age Group", y = "Difference") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

# Create histogram for the difference in charges vs costs
ggplot(my_data, aes(x = Difference)) +
  geom_histogram(binwidth = 5000, fill = "blue", color = "black") +  
  theme_minimal() +
  labs(title = "Histogram of Differences Between Total Charges and Total Costs",
       x = "Difference",
       y = "Frequency") + xlim(c(-10000, 150000))

#color coded stacked bar chart of age group against type of admission
ggplot(my_data, aes(x = `Age Group`, fill = `Type of Admission`)) +
  geom_bar(position = position_dodge(width = 0.9), aes(label = ..count..), stat = "count") +
  geom_text(stat = 'count', aes(label = ..count..), vjust = -0.5, position = position_dodge(width = 0.9)) +
  theme_minimal() +
  labs(title = "Number of Cases by Age Group and Type of Admission",
       x = "Age Group",
       y = "Number of Cases") +
  scale_y_continuous(labels = scales::comma) + # Ensure y-axis labels are full numbers
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) # Improve x-axis labels readability

#see pie chart for gender distribution

gender_counts <- table(my_data$Gender)
gender_df <- as.data.frame(gender_counts)
gender_df$Percentage <- gender_df$Freq / sum(gender_df$Freq) * 100
names(gender_df) <- c("Gender", "Count", "Percentage")

ggplot(gender_df, aes(x = "", y = Percentage, fill = Gender)) +
  geom_bar(width = 1, stat = "identity", color = "black") +
  coord_polar("y", start = 0) +
  geom_text(aes(label = paste(Gender, ":", round(Percentage, 1), "%")), position = position_stack(vjust = 0.5)) +
  scale_fill_manual(values = c("M" = "lightblue", "F" = "pink", "U" = "purple")) +
  theme_void() +
  labs(title = "Gender Distribution")

#see pie chart for race distribution
race_counts <- table(my_data$Race)
race_df <- as.data.frame(race_counts)
race_df$Percentage <- race_df$Freq / sum(race_df$Freq) * 100
names(race_df) <- c("Race", "Count", "Percentage")


ggplot(race_df, aes(x = "", y = Percentage, fill = Race)) +
  geom_bar(width = 1, stat = "identity", color = "black") +
  coord_polar("y", start = 0) +
  geom_text(aes(label = paste(Race, ":", round(Percentage, 1), "%")), position = position_stack(vjust = 0.5)) +
  scale_fill_brewer(palette = "Set3") 
  theme_void() +
  labs(title = "Race Distribution")
  
#Hospital Admission Type by Race
ggplot(my_data, aes(x = Race, fill = `Type of Admission`)) +
  geom_bar(position = position_dodge(width = 0.75), stat = "count") +
  geom_text(aes(label = ..count..), stat = "count", position = position_dodge(width = 0.75), vjust = -0.25) +
  scale_y_continuous(labels = scales::comma) + # y-axis labels are full numbers
  labs(title = "Hospital Admission Type by Race",
       x = "Race",
       y = "Count of Admissions") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# average length of stay by race  
ggplot(my_data, aes(x = Race, y = `Length of Stay`)) +
  stat_summary(fun.y = mean, geom = "bar", aes(fill = Race), na.rm = TRUE) +
  stat_summary(fun.y = mean, geom = "text", aes(label = sprintf("%.2f", ..y..)), vjust = -0.5, na.rm = TRUE) +
  labs(title = "Average Length of Stay by Race",
       x = "Race",
       y = "Average Length of Stay (days)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.title = element_blank())

#Average Cost per race
ggplot(my_data, aes(x = Race, y = `Total Charges`)) +
  stat_summary(fun.y = mean, geom = "bar", aes(fill = Race), na.rm = TRUE) +
  stat_summary(fun.y = mean, geom = "text", aes(label = sprintf("%.2f", ..y..)), vjust = -0.5, na.rm = TRUE) +
  labs(title = "Average Cost of Stay by Race",
       x = "Race",
       y = "Average Cost of Stay") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.title = element_blank())

#Cost Type of admission by race
ggplot(my_data, aes(x = `Type of Admission`, y = `Total Charges`, fill = `Race`)) +
  stat_summary(fun = mean, geom = "bar", position = position_dodge(), na.rm = TRUE) +
  stat_summary(fun = mean, geom = "text", aes(label = sprintf("%.2f", ..y..)),
               position = position_dodge(width = 0.9), vjust = -0.5, na.rm = TRUE) +
  labs(title = "Average Cost for Each Type of Admission by Race",
       x = "Type of Admission", 
       y = "Average Cost") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.title = element_blank())


#lets do some regression 
library(caTools)

set.seed(22) 
split <- sample.split(my_data$`Total Charges`, SplitRatio = 0.65)

train_data <- subset(my_data, split == TRUE)
test_data <- subset(my_data, split == FALSE)

model <- lm(`Total Charges` ~ . - `Total Costs`, data = train_data)

options(max.print=1000000)
summary(model)

#didnt work, lets make the necessary data manipulations
# Check for NA values in each column
columns_with_nas <- sapply(my_data, function(x) any(is.na(x)))

# Print names of columns that contain NA values
na_columns <- names(columns_with_nas[columns_with_nas == TRUE])
print(na_columns)

sum(is.na(my_data$`Operating Certificate Number`))
sum(is.na(my_data$`Facility Id`))
sum(is.na(my_data$`Attending Provider License Number`))
sum(is.na(my_data$`Operating Provider License Number`))
sum(is.na(my_data$`Other Provider License Number`))


# Filter for rows where Facility Id is NA and select Facility Name
na_facility_names <- my_data[is.na(my_data$`Facility Id`), ]$`Facility Name`
# Print the Facility Names with NA in Facility Id
print(na_facility_names)
# Get unique names from the list
unique_na_facility_names <- unique(na_facility_names)
# Print the unique Facility Names with NA in Facility Id
print(unique_na_facility_names)  

#checking same for Attending Provider License Number
na_facility_names <- my_data[is.na(my_data$`Attending Provider License Number`), ]$`Facility Name`
print(na_facility_names)
unique_na_facility_names <- unique(na_facility_names)
print(unique_na_facility_names)  

na_opln <- my_data[is.na(my_data$`Operating Provider License Number`), ]$`Facility Name`
print(na_opln)
unique_na_opln <- unique(na_opln)
print(unique_na_opln)  


#check number of 'U's relative ot others in gender column
gender_counts <- table(my_data$Gender)

# Display the counts
print(gender_counts)


# Get the frequency 'Length of Stay'
length_of_stay_distribution <- table(my_data$`Length of Stay`)
print(length_of_stay_distribution)


# Get the frequency 'Patient Disposition'
Patient_Disposition_distribution <- table(my_data$`Patient Disposition`)
print(Patient_Disposition_distribution)

######### WORK TO FIGURE OUT WHAT CATEGORIES TO COMBINE ###########
# Get the frequency 'CCS Diagnosis Code'
CCS_distribution <- table(my_data$`CCS Diagnosis Code`)
print(sort(CCS_distribution))
# Convert the counts to proportions and then to percentages
CCS_percentages <- prop.table(CCS_distribution) * 100
# Sort the percentages in descending order for better readability
sorted_percentages <- sort(CCS_percentages, decreasing = TRUE)
# Print the sorted percentages
print(sorted_percentages)

# Filter for categories representing less than 0.1% of the data
AA <- sorted_percentages[sorted_percentages < 0.1]
# Count the number of such categories
num_categories <- length(AA)
print(num_categories)
#Calculate the total number of categories
total_categories <- length(sorted_percentages)
print(total_categories)
#Calculate the percentage of categories less than 0.1%
percentage_of_categories <- (num_categories / total_categories) * 100
print(percentage_of_categories)
# Sum of percentages of categories representing less than 0.1% of the data
total_percentage <- sum(AA)
print(total_percentage)

# Get the frequency 'CCS Procedure Code'
CCS_P_distribution <- table(my_data$`CCS Procedure Code`)
print(sort(CCS_P_distribution))
# Convert the counts to proportions and then to percentages
CCS_P_percentages <- prop.table(CCS_P_distribution) * 100
# Sort the percentages in descending order for better readability
sorted_percentages_CCS_P <- sort(CCS_P_percentages, decreasing = TRUE)
# Print the sorted percentages
print(sorted_percentages_CCS_P)

# Filter for categories representing less than 0.1% of the data
AA <- sorted_percentages_CCS_P[sorted_percentages_CCS_P < 0.1]
# Count the number of such categories
num_categories <- length(AA)
print(num_categories)
#Calculate the total number of categories
total_categories <- length(sorted_percentages_CCS_P)
print(total_categories)
#Calculate the percentage of categories less than 0.1%
percentage_of_categories <- (num_categories / total_categories) * 100
print(percentage_of_categories)
# Sum of percentages of categories representing less than 0.1% of the data
total_percentage <- sum(AA)
print(total_percentage)


# Get the frequency 'APR DRG Code'
APR_distribution <- table(my_data$`APR DRG Code`)
print(sort(APR_distribution))
# Convert the counts to proportions and then to percentages
APR_percentages <- prop.table(APR_distribution) * 100
# Sort the percentages in descending order for better readability
sorted_percentages_APR <- sort(APR_percentages, decreasing = TRUE)
# Print the sorted percentages
print(sorted_percentages_APR)

# Filter for categories representing less than 0.1% of the data
AA <- sorted_percentages_APR[sorted_percentages_APR < 0.1]
# Count the number of such categories
num_categories <- length(AA)
print(num_categories)
print(total_categories)
#Calculate the total number of categories
total_categories <- length(sorted_percentages_APR)
print(total_categories)
#Calculate the percentage of categories less than 0.1%
percentage_of_categories <- (num_categories / total_categories) * 100
print(percentage_of_categories)
# Sum of percentages of categories representing less than 0.1% of the data
total_percentage <- sum(AA)
print(total_percentage)


# Get the frequency 'APR MDC Code'
MDC_distribution <- table(my_data$`APR MDC Code`)
print(sort(MDC_distribution))
# Convert the counts to proportions and then to percentages
MDC_percentages <- prop.table(MDC_distribution) * 100
# Sort the percentages in descending order for better readability
sorted_percentages_MDC <- sort(MDC_percentages, decreasing = TRUE)
# Print the sorted percentages
print(sorted_percentages_MDC)

###### Remove the columns we do not want or need ######
names(my_data)
write.csv(my_data, "HD2.csv", row.names = FALSE)

my_data <- fread("HD2.csv")

my_data$'Operating Certificate Number' <- NULL
my_data$'Facility Id' <- NULL
my_data$'Discharge Year' <- NULL
my_data$'CCS Diagnosis Description' <- NULL
my_data$'CCS Procedure Description' <- NULL
my_data$'APR DRG Description' <- NULL
my_data$'APR MDC Description' <- NULL
my_data$'APR Severity of Illness Description' <- NULL


write.csv(my_data, "HD3.csv", row.names = FALSE)


#### load data from here for regression model #####

my_data <- fread("HD3.csv")
names(my_data)
summary(my_data)
str(my_data)
###### Read the columns like we want them to be read (as factors)
my_data$`Zip Code - 3 digits` <- as.factor(my_data$`Zip Code - 3 digits`)
my_data$`CCS Diagnosis Code` <- as.factor(my_data$`CCS Diagnosis Code`)
my_data$`CCS Procedure Code` <- as.factor(my_data$`CCS Procedure Code`)
my_data$`APR DRG Code` <- as.factor(my_data$`APR DRG Code`)
my_data$`APR MDC Code` <- as.factor(my_data$`APR MDC Code`)
my_data$`APR Severity of Illness Code` <- as.factor(my_data$`APR Severity of Illness Code`)
my_data$`Attending Provider License Number` <- as.factor(my_data$`Attending Provider License Number`)
my_data$`Operating Provider License Number` <- as.factor(my_data$`Operating Provider License Number`)
my_data$`Other Provider License Number` <- as.factor(my_data$`Other Provider License Number`)
str(my_data)
summary(my_data)


######### grouping rare events (<0.1%) into single category ##############

# Grouping of rare instances  'CCS Diagnosis Code'
CCS_distribution <- table(my_data$`CCS Diagnosis Code`)
CCS_percentages <- prop.table(CCS_distribution) * 100
total_categories <- length(CCS_percentages)
print(total_categories)
AA <- CCS_percentages[CCS_percentages < 0.1]
underrepresented_categories <- names(AA)
my_data$CSS_Diag_Code_Cleaned <- ifelse(my_data$`CCS Diagnosis Code` %in% underrepresented_categories, 'rare', as.character(my_data$`CCS Diagnosis Code`))
percentage_rare <- mean(my_data$CSS_Diag_Code_Cleaned == "rare") * 100
#should be 4.919
print(percentage_rare)

# Grouping of rare instances  'CCS Procedure Code'
CCS_PD_distribution <- table(my_data$`CCS Procedure Code`)
CCS_PD_percentages <- prop.table(CCS_PD_distribution) * 100

AA <- CCS_PD_percentages[CCS_PD_percentages < 0.1]
underrepresented_categories_PD <- names(AA)
my_data$CSS_P_Code_Cleaned <- ifelse(my_data$`CCS Procedure Code` %in% underrepresented_categories_PD, 'rare', as.character(my_data$`CCS Procedure Code`))
percentage_rare_PD <- mean(my_data$CSS_P_Code_Cleaned == "rare") * 100
#should be 3.633
print(percentage_rare_PD)

# Grouping of rare instances  'APR DRG Code'
APR_distribution <- table(my_data$`APR DRG Code`)
APR_percentages <- prop.table(APR_distribution) * 100

AA <- APR_percentages[APR_percentages < 0.1]
underrepresented_categories_APR <- names(AA)
my_data$APR_Cleaned <- ifelse(my_data$`APR DRG Code` %in% underrepresented_categories_APR, 'rare', as.character(my_data$`APR DRG Code`))
percentage_rare_APR <- mean(my_data$APR_Cleaned == "rare") * 100
#should be 6.385
print(percentage_rare_APR)



# Creating Training and Testing Sets
#install.packages("caTools")
library(caTools)

set.seed(22)

# Split the dataset
split <- caTools::sample.split(my_data$`Total Charges`, SplitRatio = 0.65)

# Subset the data into training and test sets
train_set <- subset(my_data, split == TRUE)
test_set <- subset(my_data, split == FALSE)

sapply(train_set, function(x) if(is.factor(x)) length(unique(x)) else NA)

save.image(file = "my_workspace_small.RData")
load("my_workspace_small.RData")

#before any refining
# Fit the linear regression model with specified predictors
model <- lm(`Total Charges` ~ `Health Service Area` + `Hospital County` + `Facility Name` + 
              `Age Group` + `Zip Code - 3 digits` + `Gender` + `Race` + `Ethnicity` + 
              `Length of Stay` + `Type of Admission` + `Patient Disposition` + 
              `CSS_Diag_Code_Cleaned` + `CSS_P_Code_Cleaned` + `APR_Cleaned` + 
              `APR MDC Code` + `APR Severity of Illness Code` + `APR Risk of Mortality` + 
              `APR Medical Surgical Description` + `Payment Typology 1` + 
              `Payment Typology 2` + `Payment Typology 3` + `Birth Weight` + 
              `Abortion Edit Indicator` + `Emergency Department Indicator`, 
            data = train_set)

# Summary of the model
options(max.print=10000)
summary(model)
# summary output to text
capture.output(summary(model), file = "model_summary_small.txt")


# After Refining - removed hospital county and facility name because of the NAs
model <- lm(`Total Charges` ~ `Health Service Area` +  
              `Age Group` + `Zip Code - 3 digits` + `Gender` + `Race` + `Ethnicity` + 
              `Length of Stay` + `Type of Admission` + `Patient Disposition` + 
              `CSS_Diag_Code_Cleaned` + `CSS_P_Code_Cleaned` + `APR_Cleaned` + 
              `APR MDC Code` + `APR Severity of Illness Code` + `APR Risk of Mortality` + 
              `APR Medical Surgical Description` + `Payment Typology 1` + 
              `Payment Typology 2` + `Payment Typology 3` + `Birth Weight` + 
              `Abortion Edit Indicator` + `Emergency Department Indicator`, 
            data = train_set)

# Summary of the model
options(max.print=10000)
summary(model)
# summary output to text
capture.output(summary(model), file = "model_summary_small_2.txt")


# After Refining v2 - removed Abortion edit indicator
model <- lm(`Total Charges` ~ `Health Service Area` +  
              `Age Group` + `Zip Code - 3 digits` + `Gender` + `Race` + `Ethnicity` + 
              `Length of Stay` + `Type of Admission` + `Patient Disposition` + 
              `CSS_Diag_Code_Cleaned` + `CSS_P_Code_Cleaned` + `APR_Cleaned` + 
              `APR MDC Code` + `APR Severity of Illness Code` + `APR Risk of Mortality` + 
              `APR Medical Surgical Description` + `Payment Typology 1` + 
              `Payment Typology 2` + `Payment Typology 3` + `Birth Weight` + `Emergency Department Indicator`, 
            data = train_set)

# Summary of the model
options(max.print=10000)
summary(model)
# summary output to text
capture.output(summary(model), file = "model_summary_small_3.txt")


# Count the number of occurrences of "47" in the APR_Cleaned column
num_47 <- sum(my_data$APR_Cleaned == "47", na.rm = TRUE)
# Calculate the total number of non-NA entries in the APR_Cleaned column
total_non_na <- sum(!is.na(my_data$APR_Cleaned))
# Calculate the percentage
percentage_47 <- (num_47 / total_non_na) * 100
# Print the percentage
print(paste("Percentage of '47' in APR_Cleaned:", percentage_47, "%"))

# After Refining #removed zip code because area already there and removed doagnosis code because procedure is what actually happened and cost
model <- lm(`Total Charges` ~ `Health Service Area` +  
              `Age Group` +  `Gender` + `Race` + `Ethnicity` + 
              `Length of Stay` + `Type of Admission` + `Patient Disposition` + 
               `CSS_P_Code_Cleaned` + `APR_Cleaned` + 
              `APR MDC Code` + `APR Severity of Illness Code` + `APR Risk of Mortality` + 
              `APR Medical Surgical Description` + `Payment Typology 1` + 
              `Payment Typology 2` + `Payment Typology 3` + `Birth Weight` + `Emergency Department Indicator`, 
            data = train_set)

# Summary of the model
options(max.print=10000)
summary(model)
# summary output to text
capture.output(summary(model), file = "model_summary_small_4.txt")

num_descNA <- sum(my_data$'APR Medical Surgical Description' == "Not Applicable", na.rm = TRUE)
num_descNA

num_riskMod <- sum(my_data$'APR Risk of Mortality' == "Moderate", na.rm = TRUE)
num_riskMod

#removed 2 records of the APR Medical Surgical Description being not applicable.
my_data <- my_data[my_data$`APR Medical Surgical Description` != "Not Applicable", ]

#redo split of data
split <- caTools::sample.split(my_data$`Total Charges`, SplitRatio = 0.65)

# Subset the data into training and test sets
train_set <- subset(my_data, split == TRUE)
test_set <- subset(my_data, split == FALSE)

sapply(train_set, function(x) if(is.factor(x)) length(unique(x)) else NA)

# After Refining #removed PR Medical Surgical Description being not applicable
model <- lm(`Total Charges` ~ `Health Service Area` +  
              `Age Group` +  `Gender` + `Race` + `Ethnicity` + 
              `Length of Stay` + `Type of Admission` + `Patient Disposition` + 
              `CSS_P_Code_Cleaned` + `APR_Cleaned` + 
              `APR MDC Code` + `APR Severity of Illness Code` + `APR Risk of Mortality` + 
              `APR Medical Surgical Description` + `Payment Typology 1` + 
              `Payment Typology 2` + `Payment Typology 3` + `Birth Weight` + `Emergency Department Indicator`, 
            data = train_set)

# Summary of the model
options(max.print=10000)
summary(model)
# summary output to text
capture.output(summary(model), file = "model_summary_small_5.txt")


# Predict the Total Charges for the test set
predictions <- predict(model, newdata = test_set)

# Calculate the residuals (difference between actual and predicted values)
residuals <- test_set$`Total Charges` - predictions

# Calculate the RMSE
rmse <- sqrt(mean(residuals^2))

# Print the RMSE
print(paste("RMSE:", rmse))

# Calculate MAE
mae <- mean(abs(test_set$`Total Charges` - predictions))
cat("MAE: ", mae, "\n")

save.image(file = "my_workspace_small.RData")
load("my_workspace_small.RData")


nrow(my_data)




########### WORKING WITH SAMPLES FROM LARGE DATASET
#sample data for different number of rows and run tests
my_data_large <- fread("HD3.csv")
sampled_data <- my_data_large[sample(nrow(my_data_large), 5000), ]

sampled_data$`Zip Code - 3 digits` <- as.factor(sampled_data$`Zip Code - 3 digits`)
sampled_data$`CCS Diagnosis Code` <- as.factor(sampled_data$`CCS Diagnosis Code`)
sampled_data$`CCS Procedure Code` <- as.factor(sampled_data$`CCS Procedure Code`)
sampled_data$`APR DRG Code` <- as.factor(sampled_data$`APR DRG Code`)
sampled_data$`APR MDC Code` <- as.factor(sampled_data$`APR MDC Code`)
sampled_data$`APR Severity of Illness Code` <- as.factor(sampled_data$`APR Severity of Illness Code`)
sampled_data$`Attending Provider License Number` <- as.factor(sampled_data$`Attending Provider License Number`)
sampled_data$`Operating Provider License Number` <- as.factor(sampled_data$`Operating Provider License Number`)
sampled_data$`Other Provider License Number` <- as.factor(sampled_data$`Other Provider License Number`)


# Grouping of rare instances  
CCS_distribution <- table(sampled_data$`CCS Diagnosis Code`)
CCS_percentages <- prop.table(CCS_distribution) * 100
AA <- CCS_percentages[CCS_percentages < 0.1]
underrepresented_categories <- names(AA)
sampled_data$CSS_Diag_Code_Cleaned <- ifelse(sampled_data$`CCS Diagnosis Code` %in% underrepresented_categories, 'rare', as.character(sampled_data$`CCS Diagnosis Code`))

# Grouping of rare instances  'CCS Procedure Code'
CCS_PD_distribution <- table(sampled_data$`CCS Procedure Code`)
CCS_PD_percentages <- prop.table(CCS_PD_distribution) * 100
AA <- CCS_PD_percentages[CCS_PD_percentages < 0.1]
underrepresented_categories_PD <- names(AA)
sampled_data$CSS_P_Code_Cleaned <- ifelse(sampled_data$`CCS Procedure Code` %in% underrepresented_categories_PD, 'rare', as.character(sampled_data$`CCS Procedure Code`))

# Grouping of rare instances  'APR DRG Code'
APR_distribution <- table(sampled_data$`APR DRG Code`)
APR_percentages <- prop.table(APR_distribution) * 100
AA <- APR_percentages[APR_percentages < 0.1]
underrepresented_categories_APR <- names(AA)
sampled_data$APR_Cleaned <- ifelse(sampled_data$`APR DRG Code` %in% underrepresented_categories_APR, 'rare', as.character(sampled_data$`APR DRG Code`))

#removed records of the APR Medical Surgical Description being not applicable.
sampled_data <- sampled_data[sampled_data$`APR Medical Surgical Description` != "Not Applicable", ]

#redo split of data
split <- caTools::sample.split(sampled_data$`Total Charges`, SplitRatio = 0.65)

# Subset the data into training and test sets
train_set <- subset(sampled_data, split == TRUE)
test_set <- subset(sampled_data, split == FALSE)

sapply(train_set, function(x) if(is.factor(x)) length(unique(x)) else NA)

# After Refining #removed PR Medical Surgical Description being not applicable
model <- lm(`Total Charges` ~ `Health Service Area` +  
              `Age Group` +  `Gender` + `Race` + `Ethnicity` + 
              `Length of Stay` + `Type of Admission` + `Patient Disposition` + 
              `CSS_P_Code_Cleaned` + `APR_Cleaned` + 
              `APR MDC Code` + `APR Severity of Illness Code` + `APR Risk of Mortality` + 
              `APR Medical Surgical Description` + `Payment Typology 1` + 
              `Payment Typology 2` + `Payment Typology 3` + `Birth Weight` + `Emergency Department Indicator`, 
            data = train_set)

# Summary of the model
options(max.print=10000)
summary(model)
# summary output to text
capture.output(summary(model), file = "model_summary_sample_5k.txt")


# Predict the Total Charges for the test set
predictions <- predict(model, newdata = test_set)

# Calculate the residuals (difference between actual and predicted values)
residuals <- test_set$`Total Charges` - predictions

# Calculate the RMSE
rmse <- sqrt(mean(residuals^2))

# Print the RMSE
print(paste("RMSE:", rmse))

# Calculate MAE
mae <- mean(abs(test_set$`Total Charges` - predictions))
cat("MAE: ", mae, "\n")


########## Regression TREE
library(rpart)

model <- rpart(`Total Charges` ~ ., data = my_data, method = "anova",
               control = rpart.control(minbucket = 50, cp = 0.001, maxdepth = 5))

# summary of the tree
summary(model)

# Plot the tree with rpart.plot
rpart.plot(model, type=4, extra=101)

#prune the tree as its currently un-viewable

optimal_cp <- 0.003675391
sink("Trees.txt",append=TRUE,split=TRUE)
pruned_model <- prune(model, cp = optimal_cp)

# Plot the pruned tree
rpart.plot(pruned_model, type=4, extra=101) 


# Predicting and evaluating the pruned model if you have a test set
predicted_values <- predict(pruned_model, newdata=test_set)
mse_pruned <- mean((test_set$`Total Charges` - predicted_values)^2)
print(paste("MSE of Pruned Model: ", mse_pruned))

#try simple tree
simple_model <- rpart(`Total Charges` ~ ., data = my_data, method = "anova",
                      control = rpart.control(cp = 0.003675391,  # Higher cp for a simpler model
                                              minsplit = 20,  
                                              maxdepth = 2))  #lower max depth
# Plotting the tree with detailed settings
rpart.plot(simple_model, 
           type = 4,       # Enhanced visualization type
           extra = 101)    # Show node number, sample size, and prediction


summary(simple_model)


predictions <- predict(simple_model, newdata = test_set)
install.packages("Metrics")
library(Metrics)

# Calculate MSE
mse <- mse(test_set$`Total Charges`, predictions)
# Calculate MAE
mae <- mae(test_set$`Total Charges`, predictions)
# Calculate RMSE
rmse <- sqrt(mse)  # RMSE is the square root of MSE

# Print the results
print(paste("MSE:", mse))
print(paste("MAE:", mae))
print(paste("RMSE:", rmse))



#### hieracheal clustering
library(dplyr)

set.seed(12) 
subsample <- my_data[sample(nrow(my_data), 1000), ]  

data_for_clustering <- scale(subsample[, c("Total Charges", "Health Service Area", "Zip Code - 3 digits" , "Length of Stay" , "CSS_Diag_Code_Cleaned" , 
                                           "CSS_P_Code_Cleaned" , "APR_Cleaned" , 
                                             "APR MDC Code" , "APR Severity of Illness Code" )])

numeric_cols <- sapply(subsample[, c("Total Charges", "Zip Code - 3 digits", "Length of Stay",
                                     "CSS_P_Code_Cleaned", "APR_Cleaned", 
                                     "APR MDC Code", "APR Severity of Illness Code")], is.numeric)

numeric_cols <- sapply(subsample, is.numeric)

# Only scale numeric columns: use the logical vector directly to subset columns
data_for_clustering <- scale(subsample[, numeric_cols])

# Perform hierarchical clustering on the subset
hc <- hclust(dist(data_for_clustering), method = "ward.D2")

# Plot the dendrogram
plot(hc, main = "Dendrogram of Hierarchical Clustering", xlab = "Index of Points", ylab = "Height")

# Color branches by the 4-cluster solution
plot(hc, labels = FALSE, main = "Dendrogram of Hierarchical Clustering")
rect.hclust(hc, k = 7, border = 2:5)  


k <- 7  # chose 7 based on the dendrogram
clusters <- cutree(hc, k = k)

# Attach cluster labels back to the original data
subsample$cluster <- clusters

aggregate(subsample[, c("Total Charges")], by = list(subsample$cluster), mean)


install.packages("dummies")

library(dplyr)
library(dummies)
