Cricket ODI Score and Win Prediction Using Machine Learning: 
This repository contains the code and resources for predicting scores and win probabilities in One Day International (ODI) cricket matches using advanced machine learning techniques. The project leverages various regression algorithms to analyze and predict match outcomes based on historical data and match conditions.

Overview:
The primary objective of this project is to develop a robust machine learning model that can accurately predict the scores and win probabilities for ODI cricket matches. The model takes into account several features, including team statistics, venue details, toss outcomes, and other match-specific conditions.

Key Features:
- Data Collection and Preprocessing: Scripts for collecting and preprocessing historical ODI match data.
- Feature Engineering: Techniques to extract and engineer relevant features from raw data.
- Model Training: Implementation of multiple regression algorithms including XGBRegressor , Lasso Regression , Ridge Regression , CatBoost, Gradient Boosting , LGBM, and Linear Regression.
- Model Evaluation: Evaluation of models based on performance metrics such as R-squared, Mean Absolute Error (MAE), Root Mean Squared Error (RMSE), and Mean Squared Error (MSE).
- Best Model Selection: XGBRegressor identified as the most effective model for this task.
- App Deployment: Development of a user-friendly mobile application using Flask and Flutter framework for real-time predictions.

Algorithms Used:
  - XGBRegressor : Achieved the highest accuracy among the evaluated models.
  - Lasso Regression
  - Ridge Regression
  - CatBoost
  - Gradient Boosting
  - LGBM
  - Linear Regression

  Usage:
  The repository includes Jupyter notebooks for data exploration, feature engineering, and model training. The main application can be run to provide real-time predictions for ODI matches.
