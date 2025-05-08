# Analytics-for-Decision-Support

# COVID-19 Prediction Model Analysis

## Technologies Used
- R

## Techniques Employed
- Linear Regression Modeling
- Sampling and Resampling
- Residual Analysis
- Model Evaluation Metrics:
  - Residual Standard Error (RSE)
  - R-squared and Adjusted R-squared
  - Root Mean Square Error (RMSE)
  - Mean Absolute Error (MAE)
  - F-statistics and p-values
- Feature Significance Assessment
- Overfitting Detection

---

## Overview

This project analyzes how different sample sizes impact the predictive performance of regression models using COVID-19-related healthcare data. The goal is to predict healthcare costs based on factors like age, length of stay, patient disposition, procedure codes, and severity of illness. 

Model performance is evaluated using various statistical metrics across sample sizes ranging from 10,000 to 50,000 rows.

---

## Model Performance Metrics by Sample Size

### Sample Size: 10,000 Rows
- **Residual Standard Error (RSE)**: 45,610 on 19,102 degrees of freedom
- **Multiple R-squared**: 0.6899
- **Adjusted R-squared**: 0.6835
- **F-statistic**: 107.3 on 396 and 19,102 DF
- **p-value**: < 2.2e-16
- **RMSE**: 43,517.96
- **MAE**: 21,397.73

### Sample Size: 30,000 Rows
- **Residual Standard Error (RSE)**: 45,610 on 19,102 degrees of freedom
- **Multiple R-squared**: 0.6899
- **Adjusted R-squared**: 0.6835
- **F-statistic**: 107.3 on 396 and 19,102 DF
- **p-value**: < 2.2e-16
- **RMSE**: 95,014.78
- **MAE**: 52,236.02

### Sample Size: 40,000 Rows
- **Residual Standard Error (RSE)**: 41,930 on 25,606 degrees of freedom
- **Multiple R-squared**: 0.7187
- **Adjusted R-squared**: 0.7144
- **F-statistic**: 166.5 on 393 and 25,606 DF
- **p-value**: < 2.2e-16
- **RMSE**: 46,391.66
- **MAE**: 19,019.50

### Sample Size: 50,000 Rows
- **Residual Standard Error (RSE)**: 43,730 on 32,095 degrees of freedom
- **Multiple R-squared**: 0.688
- **Adjusted R-squared**: 0.6841
- **F-statistic**: 177 on 400 and 32,095 DF
- **p-value**: < 2.2e-16
- **RMSE**: 43,396.93
- **MAE**: 19,199.49

---

## Conclusion

### Residual Standard Error (RSE)
Lower RSE indicates better model accuracy. The lowest RSE occurred with 40,000 rows, suggesting improved precision with larger datasets — up to a point.

### Adjusted R-squared
The 40,000-row model had the highest Adjusted R-squared, implying the best variance explanation. However, increasing beyond that (to 50,000 rows) showed diminishing returns.

### F-statistic and p-value
All models are statistically significant (p < 2.2e-16). The F-statistic increases with sample size, indicating stronger model reliability.

### RMSE and MAE
Despite better fit metrics in larger samples, the 10,000-row model had the lowest RMSE and MAE — indicating better prediction accuracy, possibly due to less overfitting or noise.

---

## Key Insights

- **10,000 Rows**: Lowest RMSE and MAE; best prediction accuracy.
- **40,000 Rows**: Best model fit (lowest RSE, highest Adjusted R²).
- **50,000 Rows**: Slight performance drop; possible overfitting or diminishing returns.
- **Overall**: Bigger datasets don't always equal better predictions.

---

## Recommendations for Future Work

1. **Feature Refinement**: Focus on significant predictors (e.g., age 70+, length of stay, severity).
2. **Granular Data**: Incorporate more detailed medical codes and hospital infrastructure data.
3. **Combat Overfitting**: Use regularization or reduce model complexity with large samples.
4. **Full Dataset Analysis**: Identify and consolidate overlapping or redundant data categories.

---

## Final Thoughts

Bigger isn't always better. While larger samples improve model fit, they don’t guarantee better predictions. A smart feature selection and noise handling strategy may yield more accurate models than simply scaling up data.
