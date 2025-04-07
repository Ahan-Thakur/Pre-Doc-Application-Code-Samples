# Pre-Doc-Application-Code-Samples

Each folder on the main branch is associated with a different project

The programming languages for which there are samples are written in brackets in each folder name 

# Development Accounting
Replicating a simplified version of Caselli's (2004) "Accounting for Cross-Country Income Differences" paper. The code:
- Puts together the production function & estimates residual TFP
- Estimates the "Measure of Our Ignorance", both across all countries and countries at different percentiles, using log-variance decomposition
- Generates scatter plots

Completed in Undergraduate Year 1

##

# UG Year-2 Coursework
Applied Econometrics coursework project of running ARDL(p.q) regressions of unemployment on inflation in the US, Mexico. The code:
- Runs the regressions 
- Estimates the coefficients
- Generates plots of the time series

Completed in Undergraduate Year 2

##

# UG Year-3 Dissertation
Estimating the causal effect of institutional change on the proximate causes of growth. (WIP) The code:
- Cleans V-Dem, PWT and state capacity datasets & merges them
- Puts together the production function & estimates residual TFP
- Generates plots of the time series for various countries
- Generates bins of average level of institutions (capture political freedoms) and state capacity across 4 year bands 
- Runs dynamic panel models for combinations of levels and changes in capital per capita, human capital and TFP on past bins institutions, state capacity and a weighted average of both
- Runs these dynamic panel models for countries in different income bands, different regions
- Dynamic panel models use Blundell & Bond (system-GMM) estimators; endogenous variables instrumented with their lags
- All coefficients re-estimated using ridge regressions (LASSO with alpha = 0) to assess impact of multicollinearity 

Work in Progress 
