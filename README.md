# Analytics-for-Decision-Support

# COVID-19 Prediction Model Analysis

## Overview
This project analyzes the predictive performance of different sample sizes on COVID-19-related data. It focuses on building regression models to predict healthcare costs, using key variables such as age, length of stay, patient disposition, procedure codes, and severity of illness. The analysis explores how increasing the sample size impacts model performance across various metrics, including residual standard error (RSE), R-squared values, F-statistics, RMSE, and MAE.

## Key Metrics
For each sample size, the following model performance metrics were calculated:

### 10,000 Rows Sampled
- **Residual Standard Error**: 45,610 on 19,102 degrees of freedom
- **Multiple R-squared**: 0.6899, **Adjusted R-squared**: 0.6835
- **F-statistic**: 107.3 on 396 and 19,102 DF, **p-value**: < 2.2e-16
- **RMSE**: 43,517.96
- **MAE**: 21,397.73

### 30,000 Rows Sampled
- **Residual Standard Error**: 45,610 on 19,102 degrees of freedom
- **Multiple R-squared**: 0.6899, **Adjusted R-squared**: 0.6835
- **F-statistic**: 107.3 on 396 and 19,102 DF, **p-value**: < 2.2e-16
- **RMSE**: 95,014.78
- **MAE**: 52,236.02

### 40,000 Rows Sampled
- **Residual Standard Error**: 41,930 on 25,606 degrees of freedom
- **Multiple R-squared**: 0.7187, **Adjusted R-squared**: 0.7144
- **F-statistic**: 166.5 on 393 and 25,606 DF, **p-value**: < 2.2e-16
- **RMSE**: 46,391.66
- **MAE**: 19,019.50

### 50,000 Rows Sampled
- **Residual Standard Error**: 43,730 on 32,095 degrees of freedom
- **Multiple R-squared**: 0.688, **Adjusted R-squared**: 0.6841
- **F-statistic**: 177 on 400 and 32,095 DF, **p-value**: < 2.2e-16
- **RMSE**: 43,396.93
- **MAE**: 19,199.49

## Conclusion

### Residual Standard Error (RSE)
The RSE provides insight into the typical deviation between observed and predicted outcomes. A lower RSE indicates better model accuracy. The highest RSE was observed with 10,000 rows, while the lowest was with 40,000 rows. This suggests that increasing the sample size can improve model precision, but there's a point where further increases in sample size may not significantly reduce error.

### Adjusted R-squared
The Adjusted R-squared value accounts for the number of predictors relative to the number of observations. The model with 40,000 rows had the highest Adjusted R-squared, suggesting it explained the most variance. Despite the larger sample size, the 50,000-row model showed a slight drop in Adjusted R-squared, indicating diminishing returns in performance improvement with larger datasets.

### F-statistic and p-value
All models showed a p-value < 2.2e-16, indicating statistical significance. As sample size increases, the F-statistic also increases, signifying greater predictive power in larger datasets.

### RMSE and MAE
While larger sample sizes generally resulted in better RSE and Adjusted R-squared values, the smallest sample (10,000 rows) demonstrated the lowest RMSE and MAE, which suggests the highest prediction accuracy. The models with 40,000 and 50,000 rows, despite their better fit in terms of RSE and R-squared, performed worse in terms of prediction accuracy, likely due to overfitting or increased noise.

### Key Insights
- **Small Sample Sizes (10,000 rows)**: This sample had the lowest RMSE and MAE, meaning it made the most accurate predictions.
- **Larger Sample Sizes (40,000 and 50,000 rows)**: These models had a better fit (lower RSE, higher Adjusted R-squared), but the prediction accuracy (RMSE and MAE) was worse, possibly due to overfitting or noise.
- **Best Model Balance**: The model with 40,000 rows seems to strike a balance between variance explained and prediction accuracy.

### Recommendations for Future Work
1. **Refining Model Features**: Focus on the most significant features such as age (70+), length of stay, patient disposition, certain procedure codes, and severity of illness, which all contribute significantly to predicting healthcare costs.
2. **Increasing Data Granularity**: Consider collecting more granular data, including healthcare infrastructure or medical codes, to improve predictive power.
3. **Address Overfitting**: Explore regularization techniques or reduce complexity to prevent overfitting in larger datasets.
4. **Exploring the Full Dataset**: Examine the full dataset for insights on categories that show statistical significance and combine or remove overlapping information in the next iteration.

## Conclusion
In this analysis, larger sample sizes do not always improve model prediction accuracy. While models with 40,000 rows or more have better variance explanation, smaller datasets (e.g., 10,000 rows) performed better in terms of prediction accuracy. Moving forward, the next steps include fine-tuning the model using domain-specific insights, particularly focusing on significant predictors such as patient age, length of stay, and severity of illness.

