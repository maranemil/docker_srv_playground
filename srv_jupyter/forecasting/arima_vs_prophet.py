#!/usr/bin/env python
# coding: utf-8

# In[ ]:


#!/usr/bin/env python
# coding: utf-8

import os
os.environ['CUDA_VISIBLE_DEVICES'] = '-1'
os.environ['TF_ENABLE_ONEDNN_OPTS'] = '0'
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '1'


# In[1]:


# export TF_ENABLE_ONEDNN_OPTS=0


# In[2]:


get_ipython().system('pip install -q pmdarima')
get_ipython().system('pip install -q keras')
get_ipython().system('pip install -q tensorflow')


# In[3]:


import numpy as np
import pandas as pd
from statsmodels.tsa.statespace.sarimax import SARIMAX
from statsmodels.graphics.tsaplots import plot_acf,plot_pacf 
from statsmodels.tsa.seasonal import seasonal_decompose 
from pmdarima import auto_arima                        
from sklearn.metrics import mean_squared_error
from statsmodels.tools.eval_measures import rmse

import tensorflow as tf
tf.config.set_visible_devices([], 'GPU')
from tensorflow import keras
from tensorflow.keras import layers



import warnings
warnings.filterwarnings("ignore")

#TF_ENABLE_ONEDNN_OPTS=0
#CUDA_VISIBLE_DEVICES=""


# In[4]:


# https://alkaline-ml.com/pmdarima/setup.html
# https://pypi.org/project/pmdarima/
# https://medium.com/@cdabakoglu/time-series-forecasting-arima-lstm-prophet-with-python-e73a750a9887


# In[5]:


csv_data = pd.read_csv("https://github.com/ourownstory/neuralprophet-data/raw/main/kaggle-energy/datasets/tutorial01.csv")
df = csv_data
df.head()


# In[6]:


df.info()


# In[7]:


df.ds = pd.to_datetime(df.ds)
df = df.set_index("ds")
df.head()


# In[8]:


df.index.freq = 'D'
ax = df['y'].plot(figsize = (16,2), title = "y")
ax.set(xlabel='ds', ylabel='y');


# In[ ]:





# In[9]:


a = seasonal_decompose(df["y"], model = "add")
a.plot();


# In[10]:


import matplotlib.pyplot as plt
plt.figure(figsize = (16,2))
a.seasonal.plot();


# In[11]:


#auto_arima(df['y'], seasonal=True, m=12,max_p=7, max_d=5,max_q=7, max_P=4, max_D=4,max_Q=4).summary()
auto_arima(df['y'], seasonal=True, m=1, suppress_warnings=False, error_action="ignore",trace=True,).summary()
# m : int, optional (default=1)


# In[12]:


train_data = df[:len(df)-12]
test_data = df[len(df)-12:]
#arima_model = SARIMAX(train_data['y'], freq='D' order = (2,1,1), seasonal_order = (4,0,3,12))
arima_model = SARIMAX(train_data['y'], freq='D', order = (1,1,1), seasonal_order = (1, 0, 0, 12))
arima_result = arima_model.fit(disp=False)
arima_result.summary()


# In[40]:


#arima_pred = arima_result.predict(start = len(train_data), end = len(df)-1, typ="levels").rename("ARIMA_Predictions")
arima_pred = arima_result.predict(start = len(train_data), end = len(df)-1, typ="levels")
arima_pred


# In[41]:


test_data['ARIMA_Predictions'] = arima_pred


# In[42]:


"""
model = auto_arima(
	df_train["VWAP"],
	exogenous=df_train[exogenous_features],
	trace=True,
	error_action="ignore",
	suppress_warnings=True)
forecast = model.predict(n_periods=len(df_valid),  exogenous=df_valid[exogenous_features])
"""


# In[43]:


test_data['y'].plot(figsize = (16,2), legend=True)
arima_pred.plot(legend = True);


# In[44]:


arima_rmse_error = rmse(test_data['y'], arima_pred)
arima_mse_error = arima_rmse_error**2
mean_value = df['y'].mean()
print(f'MSE Error: {arima_mse_error}\nRMSE Error: {arima_rmse_error}\nMean: {mean_value}')


# In[ ]:





# In[ ]:





# In[45]:


from sklearn.preprocessing import MinMaxScaler
scaler = MinMaxScaler()
scaler.fit(train_data)
scaled_train_data = scaler.transform(train_data)
scaled_test_data = scaler.transform(test_data)


# In[46]:


from keras.preprocessing.sequence import TimeseriesGenerator

n_input = 12
n_features= 1
generator = TimeseriesGenerator(scaled_train_data, scaled_train_data, length=n_input, batch_size=1)
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import LSTM

lstm_model = Sequential()
lstm_model.add(LSTM(200, activation='relu', input_shape=(n_input, n_features)))
lstm_model.add(Dense(1))
lstm_model.compile(optimizer='adam', loss='mse')

lstm_model.summary()


# In[47]:


lstm_model.fit_generator(generator,epochs=10) # train 


# In[48]:


losses_lstm = lstm_model.history.history['loss']
plt.figure(figsize=(12,2))
plt.xlabel("Epochs")
plt.ylabel("Loss")
plt.xticks(np.arange(0,21,1))
plt.plot(range(len(losses_lstm)),losses_lstm);


# In[49]:


lstm_predictions_scaled = list()

batch = scaled_train_data[-n_input:]
current_batch = batch.reshape((1, n_input, n_features))

for i in range(len(test_data)):   
    lstm_pred = lstm_model.predict(current_batch)[0]
    lstm_predictions_scaled.append(lstm_pred) 
    current_batch = np.append(current_batch[:,1:,:],[[lstm_pred]],axis=1)


# In[50]:


lstm_predictions_scaled


# In[51]:


lstm_predictions = scaler.inverse_transform(lstm_predictions_scaled)
lstm_predictions


# In[52]:


test_data['LSTM_Predictions'] = lstm_predictions
test_data


# In[53]:


test_data['y'].plot(figsize = (12,2), legend=True)
test_data['LSTM_Predictions'].plot(legend = True);


# In[54]:


lstm_rmse_error = rmse(test_data['y'], test_data["LSTM_Predictions"])
lstm_mse_error = lstm_rmse_error**2
mean_value = df['y'].mean()

print(f'MSE Error: {lstm_mse_error}\nRMSE Error: {lstm_rmse_error}\nMean: {mean_value}')


# In[ ]:





# In[ ]:





# In[55]:


# Prophet Forecast
get_ipython().system('pip install prophet')


# In[56]:


df.info()


# In[57]:


df_pr = df.copy()
df_pr = df.reset_index()
df_pr.columns = ['ds','y'] # To use prophet column names should be like that
train_data_pr = df_pr.iloc[:len(df)-12]
test_data_pr = df_pr.iloc[len(df)-12:]
from prophet import Prophet
m = Prophet()
m.fit(train_data_pr)
future = m.make_future_dataframe(periods=12,freq='MS')
prophet_pred = m.predict(future)
prophet_pred.tail()


# In[58]:


prophet_pred = pd.DataFrame({"Date" : prophet_pred[-12:]['ds'], "Pred" : prophet_pred[-12:]["yhat"]})
prophet_pred = prophet_pred.set_index("Date")
prophet_pred.index.freq = "MS"
prophet_pred


# In[59]:


test_data["Prophet_Predictions"] = prophet_pred['Pred'].values
import seaborn as sns
plt.figure(figsize=(16,5))
ax = sns.lineplot(x= test_data.index, y=test_data["y"])
sns.lineplot(x=test_data.index, y = test_data["Prophet_Predictions"]);


# In[69]:


rmse_errors = [arima_rmse_error, lstm_rmse_error, prophet_rmse_error]
#mse_errors = [arima_mse_error, lstm_mse_error, prophet_mse_error]
errors = pd.DataFrame({"Models" : ["ARIMA", "LSTM", "Prophet"]}) # ,"RMSE Errors" : rmse_errors, "MSE Errors" : mse_errors
plt.figure(figsize=(16,4))
plt.plot_date(test_data.index, test_data["y"], linestyle="-")
plt.plot_date(test_data.index, test_data["ARIMA_Predictions"], linestyle="-.")
plt.plot_date(test_data.index, test_data["LSTM_Predictions"], linestyle="--")
plt.plot_date(test_data.index, test_data["Prophet_Predictions"], linestyle=":")
plt.legend()
plt.show()


# In[66]:


prophet_rmse_error = rmse(test_data['y'], test_data["Prophet_Predictions"])
prophet_mse_error = prophet_rmse_error**2
mean_value = df['y'].mean()
print(f'MSE Error: {prophet_mse_error}\nRMSE Error: {prophet_rmse_error}\nMean: {mean_value}')


# In[ ]:





# In[67]:


print(f"Mean: {test_data['y'].mean()}")
errors


# In[68]:


test_data


# In[ ]:





# In[82]:


import pmdarima as pm
from pmdarima.model_selection import train_test_split
import numpy as np
import matplotlib.pyplot as plt

# Load/split your data
#y = pm.datasets.load_wineind()
y = df
half = round(len(y)/8)
train, test = train_test_split(y, train_size=half)

# Fit your model
model = pm.auto_arima(train, seasonal=True, m=1)

# make your forecasts
forecasts = model.predict(test.shape[0])  # predict N steps into the future

# Visualize the forecasts (blue=train, green=forecasts)
x = np.arange(y.shape[0])
plt.plot(x[:half],train, c='blue')
plt.plot(x[half:], forecasts, c='green')
plt.show()


# In[ ]:





# In[ ]:




