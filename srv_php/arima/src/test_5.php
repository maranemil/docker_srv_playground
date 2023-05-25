<?php
#############################################
# Moving Average
#############################################

function calculateMovingAverage($data, $windowSize)
{
    $movingAverage = [];
    $numDataPoints = count($data);

    // Calculate the moving average for the existing dataset
    for ($i = $windowSize - 1; $i < $numDataPoints; $i++) {
        $sum = 0;
        for ($j = $i; $j >= $i - ($windowSize - 1); $j--) {
            $sum += $data[$j];
        }
        $average = $sum / $windowSize;
        $movingAverage[] = round($average, 2);
    }

    return $movingAverage;
}

function forecastMovingAverage($movingAverage, $forecastSize)
{
    $numMovingAverage = count($movingAverage);
    $forecast = [];

    // Forecast future values based on the moving average
    for ($i = 0; $i < $forecastSize; $i++) {
        $sum = 0;
        $start = $numMovingAverage - ($i + 1);
        $end = $start - ($forecastSize - 1);

        for ($j = $start; $j >= $end; $j--) {
            $sum += $movingAverage[$j];
        }
        $average = $sum / $forecastSize;
        $forecast[] = round($average, 2);
    }

    return $forecast;
}

// Example usage
$data = [12, 18, 20, 15, 22, 17, 21, 16];
$windowSize = 3;
$forecastSize = 3;

$movingAverage = calculateMovingAverage($data, $windowSize);
$forecast = forecastMovingAverage($movingAverage, $forecastSize);

// Print the moving average
echo "Moving Average:\n";
foreach ($movingAverage as $value) {
    echo $value . "\n";
}

// Print the forecasted values
echo "\nForecasted Values:\n";
foreach ($forecast as $value) {
    echo $value . "\n";
}


#############################################
# Decompositional pseudocode
#############################################
# https://github.com/AnkurGel/statsample-timeseries
# https://packagist.org/packages/dcvn/moving-average

// Import the TimeSeries library (requires installation via composer)
require 'vendor/autoload.php';
function forecastDecompositional($data, $seasonLength, $forecastSize)
{
    // Convert the data to a TimeSeries object
    $timeSeries = new TimeSeries($data);

    // Decompose the time series using STL algorithm
    $decomposition = $timeSeries->stl($seasonLength);

    // Get the trend, seasonal, and residual components
    $trend = $decomposition->getTrend();
    $seasonal = $decomposition->getSeasonal();
    $residual = $decomposition->getResidual();

    // Forecast future values
    $forecast = [];
    $numDataPoints = count($data);

    for ($i = 1; $i <= $forecastSize; $i++) {
        $seasonIndex = ($numDataPoints + $i - 1) % $seasonLength;
        $forecastValue = $trend[$numDataPoints - 1] + $seasonal[$seasonIndex] + $residual[$numDataPoints - 1];
        $forecast[] = round($forecastValue, 2);
    }

    return $forecast;
}

// Example usage
$data = [12, 18, 20, 15, 22, 17, 21, 16];
$seasonLength = 4;
$forecastSize = 3;

$forecast = forecastDecompositional($data, $seasonLength, $forecastSize);

// Print the forecasted values
echo "Forecasted Values:\n";
foreach ($forecast as $value) {
    echo $value . "\n";
}



