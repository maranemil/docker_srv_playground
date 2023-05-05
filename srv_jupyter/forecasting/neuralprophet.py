#!/usr/bin/env python
# coding: utf-8

# In[22]:


get_ipython().system('pip install -q pandas')
get_ipython().system('pip install -q matplotlib')
get_ipython().system('pip install -q plotly')
get_ipython().system('pip install -q ipywidgets')
get_ipython().system('pip install -q neuralprophet')
get_ipython().system('pip install -q jupyterlab')
get_ipython().system('pip install -q psutil')


# In[333]:


import numpy as np
import pandas as pd

import plotly.express as px
import matplotlib.pyplot as plt
import plotly.graph_objects as go

from neuralprophet import NeuralProphet, set_log_level


# In[334]:


import pandas as pd

# Load the dataset from the CSV file using pandas
csv_data = pd.read_csv("https://github.com/ourownstory/neuralprophet-data/raw/main/kaggle-energy/datasets/tutorial01.csv")
df = csv_data
df.fillna(0)
df.describe


# In[335]:


# Plot the dataset, showing price (y column) over time (ds column)
plt = df.plot(x="ds", y="y", figsize=(15, 1))


# In[336]:


# Import the NeuralProphet class
from neuralprophet import NeuralProphet, set_log_level

# Disable logging messages unless there is an error
set_log_level("ERROR")

# Create a NeuralProphet model with default parameters
m = NeuralProphet(
    #seasonality_mode="additive", learning_rate=0.01,  # additive multiplicative
    #trend_reg=1,
# Disable change trendpoints
    #n_changepoints=0,
    # Disable seasonality components
    yearly_seasonality=True,
    weekly_seasonality=False,
    daily_seasonality=True,
    #epochs=20,
    #collect_metrics=["MSE", "MAE", "RMSE"],
    #n_lags=1,
    #quantiles=[0.00, 0.99]
    #n_forecasts=1,
    #n_lags=3, 
    #changepoints_range=0.95
)

# Use static plotly in notebooks
m.set_plotting_backend("matplotlib") # 'plotly', 'plotly-resampler' or 'matplotlib'."

# Fit the model on the dataset (this might take a bit)
metrics = m.fit(df, freq="D") # D MS H


# In[337]:


# Create a new dataframe reaching 365 into the future for our forecast, n_historic_predictions also shows historic data
df_future = m.make_future_dataframe(df, n_historic_predictions=True, periods=365) # 365 days # n_historic_predictions  True 365

# Predict the future
forecast = m.predict(df_future)


# In[338]:


fig_forecast = m.plot(forecast,figsize=(16,2))


# In[339]:


fig_components = m.plot_components(forecast,figsize=(16,4))


# In[332]:


fig_model = m.plot_parameters(figsize=(16,4))


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




