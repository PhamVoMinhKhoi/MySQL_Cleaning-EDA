# MySQL Data Cleaning and EDA

## Project Description
This project focuses on cleaning and analyzing global layoff data using MySQL. The SQL queries are organized into two main phases:

1. **Data Cleaning**: Processing raw data to ensure consistency and prepare it for analysis.
2. **Exploratory Data Analysis (EDA)**: Exploring the data to identify trends, patterns, and outliers.

## Main Components
### 1. Data Cleaning
- **File**: `Data Cleaning.sql`
- **Objectives**:
  - Create a staging table (`layoffs_staging`) to work with the data.
  - Remove duplicate records.
  - Resolve data quality issues for accurate analysis.
- **Key Steps**:
  1. Duplicate the original data into a staging table.
  2. Remove duplicate records based on key columns such as `company` and `industry`.
  3. Apply additional changes as needed.

### 2. Exploratory Data Analysis (EDA)
- **File**: `EDA_layoff.sql`
- **Objectives**:
  - Explore the data to gain insights into layoff trends and patterns.
  - Identify maximum, minimum, and percentage-related statistics to understand the scale of layoffs.
- **Key Steps**:
  1. Calculate maximum values for columns like `total_laid_off`.
  2. Analyze the percentage of layoffs (`percentage_laid_off`) to measure impact.

## How to Use
1. **Requirements**:
   - MySQL database.
   - Dataset structured similarly to the `world_layoffs.layoffs` table.

2. **Running the SQL Scripts**:
   - Run `Data Cleaning.sql` first to clean the data.
   - Then use `EDA_layoff.sql` for data analysis.

3. **Notes**:
   - Ensure your database tables match the expected structure before executing the scripts.
   - Review the results after executing each query to verify correctness.

## Folder Structure
