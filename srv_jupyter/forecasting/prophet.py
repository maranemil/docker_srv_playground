#!/usr/bin/env python
# coding: utf-8

# In[236]:


get_ipython().system('pip install -q pandas')
get_ipython().system('pip install -q matplotlib')
get_ipython().system('pip install -q prophet')
get_ipython().system('pip install -q plotly')
get_ipython().system('pip install -q ipywidgets')
get_ipython().system('pip install -q jupyterlab')
get_ipython().system('pip install -q psutil')


# In[413]:


import numpy as np
import pandas as pd

import plotly.express as px
import matplotlib.pyplot as plt
import plotly.graph_objects as go

from prophet import Prophet
from prophet.plot import plot_plotly, plot_components_plotly, plot_cross_validation_metric
from prophet.diagnostics import performance_metrics, cross_validation


# In[414]:


# Read data
#csv_data = pd.read_csv('https://raw.githubusercontent.com/facebook/prophet/main/examples/example_wp_log_peyton_manning.csv')
csv_data = pd.read_csv("https://github.com/ourownstory/neuralprophet-data/raw/main/kaggle-energy/datasets/tutorial01.csv")


# In[415]:


df = csv_data


# In[416]:


df.fillna(0)
df.describe


# In[417]:


fig = df.plot( x='ds', y='y', title='Demand',figsize=(18,1))


# In[ ]:





# In[418]:


########## Prophet ###############
# fit model and store output
#m = Prophet(yearly_seasonality=True, daily_seasonality=False, changepoint_range = 0.9, changepoint_prior_scale = 0.5, seasonality_mode = "additive") # additive multiplicative
#m = Prophet(interval_width=0.95, weekly_seasonality=True, daily_seasonality=True) # seasonality_mode = "additive", 
m = Prophet(weekly_seasonality=False, daily_seasonality=True,yearly_seasonality=True )
m.fit(df)
# create forecast
future = m.make_future_dataframe(periods=365, freq='d')
#future = m.make_future_dataframe(periods=365, freq='MS') # 50 d m  MS
#future = m.make_future_dataframe(periods=50, freq='d')
forecast = m.predict(future)


# In[419]:


# show samples plots
future.tail()[:3]


# In[420]:


forecast = m.predict(future)
forecast[["ds","yhat","yhat_lower","yhat_upper"]].tail()[:3]


# In[421]:


fig1 = m.plot(forecast,figsize=(16,2))
fig1.show()


# In[422]:


fig2 = m.plot_components(forecast,figsize=(16, 4))
fig2.show()


# In[ ]:





# In[ ]:





# In[ ]:




