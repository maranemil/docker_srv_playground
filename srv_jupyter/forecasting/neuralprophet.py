#!/usr/bin/env python
# coding: utf-8

# In[1]:


#!/usr/bin/env python
# coding: utf-8

get_ipython().system('pip install -q pandas')
get_ipython().system('pip install -q matplotlib')
get_ipython().system('pip install -q plotly')
get_ipython().system('pip install -q ipywidgets')
get_ipython().system('pip install -q neuralprophet')
get_ipython().system('pip install -q jupyterlab')
get_ipython().system('pip install -q psutil')

import numpy as np
import pandas as pd
import plotly.express as px
import matplotlib.pyplot as plt
import matplotlib as mpl
import plotly.graph_objects as go
from neuralprophet import NeuralProphet, set_log_level

g_epochs = 20


# In[65]:


# Load the dataset from the CSV file using pandas
csv_data = pd.read_csv("https://github.com/ourownstory/neuralprophet-data/raw/main/kaggle-energy/datasets/tutorial01.csv")
df = csv_data
#df.fillna(0)
#df.describe
#df.info()
df.head()[:2]


# In[66]:


df.describe()


# In[67]:


"""
df_max_scaled = df.copy()  
# apply normalization
column = 'y'
df_max_scaled[column] = np.log(df_max_scaled[column] /df_max_scaled[column].abs().max())
plt = df_max_scaled.plot(x="ds", y="y", figsize=(5, 4))
#display(df_max_scaled)
"""


# In[68]:


plt = df.plot(x="ds", y="y", figsize=(8, 4))


# In[69]:


#df['y'] = np.log(df['y']) # np.log2(df['y']) np.log10(df['y'])
#df.head()[:2]
#plt = df.plot(x="ds", y="y", figsize=(5, 4))


# In[70]:


df.describe()


# In[71]:


# Import the NeuralProphet class
from neuralprophet import NeuralProphet, set_log_level

# Disable logging messages unless there is an error
set_log_level("ERROR")


# In[72]:


# Create a NeuralProphet model with default parameters
"""
m = NeuralProphet(  
    
    seasonality_mode = "additive",  # additive multiplicative
    learning_rate = 0.01,  # 0.01    (try values ~0.001-10).
    #trend_reg=1,
    growth='linear', # off , default 'linear
    #trend_reg_threshold = True,
    #newer_samples_weight = 4,
    #seasonality_reg=0.5,
    #season_global_local= 'global',
    #ar_reg=5.5,
    #ar_layers=10,
    #n_forecasts=3,
    #loss_func = 'Huber', # (default) Huber, MSE, MAE
    #normalize = 'off', # off, default soft
    #global_normalization = True,
    #accelerator='auto',
  
      
    # Disable change trendpoints
    #n_changepoints=2,
    
    # Disable or enable seasonality components
    yearly_seasonality = True,
    weekly_seasonality = False,
    daily_seasonality = True,
    
    epochs=20, # def 200
    collect_metrics=["MSE", "MAE", "RMSE"],
    #n_lags=2, # Previous time series steps to include in auto-regression.
    #quantiles=[0.00, 0.99]
    #n_lags=3, 
    #changepoints_range=0.95
)
"""


# In[73]:


# https://neuralprophet.com/code/forecaster.html
# https://rdrr.io/github/AlbertoAlmuinha/neuralprophet/man/neural_prophet.html
m = NeuralProphet(
        growth="linear", # linear  off
        ##changepoints=None,
        ##n_changepoints=50, # 5
        ##changepoints_range=0.9, # 0.8 0.95
        ##trend_reg=1,
        ##trend_reg_threshold=False,
        yearly_seasonality="auto",
        weekly_seasonality=False, #"auto",
        daily_seasonality=True, # "auto",
        seasonality_mode="additive", # multiplicative
        seasonality_reg=0,
        n_forecasts=1, # 1
        n_lags=12,     # 0
        #batch_size=16,
        #learning_rate=None,
        ##learning_rate=0.03, # 0.0.01 - 1.0
        epochs=g_epochs,
        ##loss_func="Huber",
        normalize="auto",
        impute_missing=True,
        #collect_metrics=["MSE", "MAE", "RMSE"]          
)


# In[74]:


# Use static plotly in notebooks
m.set_plotting_backend("matplotlib") # 'plotly', 'plotly-resampler' or 'matplotlib'."
# Fit the model on the dataset (this might take a bit)
metrics = m.fit(df, freq="D") # D MS H 5min, D, MS or auto - Multiplicative Seasonality
metrics.tail()


# In[75]:


# Create a new dataframe 
l_df = round(len(df)/2)
df_future = m.make_future_dataframe(df, periods=356, n_historic_predictions=l_df)  # n_historic_predictions=len(df), n_historic_predictions=True, n_historic_predictions=24
# Predict the future
forecast = m.predict(df_future)
#forecast[['ds', 'yhat1','trend']].tail()
forecast.tail()


# In[ ]:





# In[76]:


fig_forecast = m.plot(forecast,figsize=(12,3))


# In[77]:


#m = m.highlight_nth_step_ahead_of_each_forecast(1)
#fig = m.plot(forecast[144:6*288],figsize=(12,3))


# In[78]:


"""
import matplotlib.pyplot as plt
import matplotlib as mpl
#SMALL_SIZE = 8
#MEDIUM_SIZE = 10
#BIGGER_SIZE = 12
#plt.rc('font', size=SMALL_SIZE)          # controls default text sizes
#plt.rc('axes', titlesize=SMALL_SIZE)     # fontsize of the axes title
#plt.rc('axes', labelsize=MEDIUM_SIZE)    # fontsize of the x and y labels
#plt.rc('xtick', labelsize=SMALL_SIZE)    # fontsize of the tick labels
#plt.rc('ytick', labelsize=SMALL_SIZE)    # fontsize of the tick labels
#plt.rc('legend', fontsize=SMALL_SIZE)    # legend fontsize
#plt.rc('figure', titlesize=BIGGER_SIZE)  # fontsize of the figure title
#mpl.rc('xtick', labelsize=8) 
#mpl.rc('ytick', labelsize=8) 
#plt.rcParams.update({'font.size': 8})
fig, ax = plt.subplots(figsize=(12, 4),dpi=80)
m.plot(forecast, xlabel="Date", ylabel="Amount", ax=ax)
ax.xaxis.label.set_size(12)
ax.yaxis.label.set_size(12)
ax.tick_params(axis='both', which='major', labelsize=9)
ax.set_title("Mean", fontsize=10, fontweight="bold")
#fig.savefig("mean.png", **savefig_options)
plt.close
"""


# In[79]:


# fig_components = m.plot_components(forecast,figsize=(15,8))


# In[80]:


fig_components = m.plot_parameters(forecast,figsize=(15,8))


# In[ ]:





# In[81]:


# folds = m.crossvalidation_split_df(df, k = 2, fold_pct = 0.2, global_model_cv_type = 'intersect')


# In[82]:


# fig_components = m.plot_parameters(folds,figsize=(15,8))


# In[ ]:





# In[83]:


import seaborn as sns
sns.set(rc={'figure.figsize':(11.7,1.27)})
df['ds'] = pd.to_datetime(df['ds'])
#plt.figure(figsize=(20,4))
sns.lineplot(data = df.set_index('ds'))


# In[84]:


########################################
# Prophet Forecast
########################################
m_baseline = NeuralProphet(epochs=g_epochs)
df_train, df_test = m_baseline.split_df(df, freq='D') # , valid_p = 0.20
#plt.figure(figsize=(20,4))
metrics = m_baseline.fit(df_train, freq='D',validation_df=df_test)


# In[85]:


# Validate Prophet Forecast
forecast_baseline = m_baseline.predict(df)
fig_components = m.plot(forecast_baseline,figsize=(15,4))


# In[86]:


# Enable Neural Prophet AR model
m_add_lag = NeuralProphet(n_lags=12*24, epochs=g_epochs)
df_train, df_test = m_add_lag.split_df(df, freq='D', valid_p = 0.20)
metrics_lag = m_add_lag.fit(df_train, freq='D',validation_df=df_test)
metrics_lag.tail()


# In[87]:


forecast_ar = m_add_lag.predict(df)
fig_components = m.plot(forecast_ar,figsize=(15,4))


# In[ ]:





# In[88]:


mbc = NeuralProphet(
    n_forecasts=6,
    n_lags=12,
    n_changepoints=50,
    learning_rate=1.0,
    #n_changepoints=100,
    #loss_func="MSE",
    growth='linear',
    yearly_seasonality=True,
    weekly_seasonality=False,
    daily_seasonality=True,
    #n_lags=24*3, 
    #learning_rate=0.003,
    epochs=g_epochs,
)
#df_train, df_valid = df[:int(len(df)*0.8)], df[int(len(df)*0.8):]
#df_valid, df_test = df_valid[:len(df_valid)//2], df_valid[len(df_valid)//2:]

df_train, df_test = mbc.split_df(df, valid_p=0.2)
#df_train, df_valid = mbc.split_df(df, valid_p=0.1)
#df_valid, df_test = mbc.split_df(df_valid, valid_p=0.1)
#train_metrics = mbc.fit(df_train)
#test_metrics = mbc.test(df_test)
#print(len(df_train), len(df_test), len(df_valid))
print(len(df_train), len(df_test))


#df_train_mbc, df_test_mbc = mbc.split_df(df, freq='D') # , 
#df_train, df_test = m.split_df(df[["ds","y"]], freq='D') # 
#df_train, df_test = m.split_df(df[["ds","y"]], freq='D') # , valid_p = 1.0/12
#metrics_mb = mbc.fit(df_train_mbc, freq='D', validation_df=df_test_mbc) # ,  epochs=20
#metrics_mb.tail(1)


# In[89]:


#future_mbc =mbc.make_future_dataframe(df, periods=60, n_historic_predictions=True)
#forecast_mbc= mbc.predict(future_mbc)
#print(forecast)
#forecast[['ds', 'yhat1','trend']].tail()
#fig3 = mbc.plot(forecast_mbc)


# In[90]:


metrics = mbc.fit(df_train, freq='D', validation_df=df_test,epochs=g_epochs)
metrics.tail()


# In[91]:


future_mbc = mbc.make_future_dataframe(df, periods=356, n_historic_predictions=True) # n_historic_predictions=len(df)
forecast_mbc = mbc.predict(future_mbc)
forecast_mbc


# In[ ]:





# In[92]:


fig_forecast = m.plot(forecast_mbc,figsize=(15,4))


# In[93]:


fig_components = m.plot_components(forecast_mbc,figsize=(15,4))


# In[94]:


import matplotlib.pyplot as plt
fig, ax = plt.subplots()
ax.plot(metrics["MAE"], '-o', label="Training Loss")  
ax.plot(metrics["MAE_val"], '-r', label="Validation Loss")
ax.legend(loc='center right', fontsize=10)
ax.tick_params(axis='both', which='major', labelsize=8)
ax.set_xlabel("Epoch", fontsize=8)
ax.set_ylabel("Loss", fontsize=8)
ax.set_title("Model Loss (MAE)", fontsize=8)


# In[95]:


fig = plt.figure(figsize=(10,6))
ax = fig.add_subplot(111)
ax.plot(df_train['ds'].dt.to_pydatetime(), df_train["y"], color='#1f76b4', label='Training Set')
#ax.plot(df_valid['ds'].dt.to_pydatetime(), df_valid["y"], color='#fc7d0b', label='Validation Set')
ax.plot(df_test['ds'].dt.to_pydatetime(), df_test["y"], color='#CDC7E5', label='Test Set')
ax.legend()
plt.show()


# In[ ]:





# In[ ]:





# In[ ]:




