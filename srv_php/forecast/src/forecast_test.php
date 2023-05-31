<?php

error_reporting(E_ERROR);
ini_set('display_errors', 'On');
require_once('php-libplot.class.php');

const FORECAST_TYPE = 'MONTH'; // MONTH DAY


if (FORECAST_TYPE === 'MONTH') {
    define("WINDOW_SIZE", 3);
    define("FORECAST_SIZE", 2);
} else {
    define("WINDOW_SIZE", 60);
    define("FORECAST_SIZE", 20);
}

echo "<br>FORECAST TYPE=" . FORECAST_TYPE;
echo "<br>WINDOW SIZE=" . WINDOW_SIZE;
echo "<br>FORECAST SIZE=" . FORECAST_SIZE;
echo "<hr>";

function makePlot($data, $Average, $forecast, $label = '')
{
    $plt = new php_plotlib();
    $plt->width($width = 7.4);
    $plt->height($height = 1.8);
    $plt->plot($data, null, '-'); # blue
    $plt->plot($Average, null, 'o'); # orange
    if ($forecast !== null) {
        $forecastPlot = array_merge_recursive($Average, $forecast);
        $plt->plot($forecastPlot, null, '--'); # green
    }
    $plt->title($label . " ");
    echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';
    echo "<hr/>";
}


function showInfo($data, $calculation, $forecast)
{
    // Print the data
    echo "<br><a style='color: blue; font-size: 16pt'>■</a>Data Values:";
    foreach ($data as $value) {
        echo $value . ",";
    }
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Calculation Values:";
    foreach ($calculation as $value) {
        echo $value . ",";
    }
    echo "<br><a style='color: green; font-size: 16pt'>■</a>Forecasted Values:";
    foreach ($forecast as $value) {
        echo $value . ",";
    }
}

foreach (range(0, 99) as $number) {
    try {
        $data[] = random_int(1, 21);
    } catch (Exception $e) {
    }
}


# read csv
$csvFile = file('data/month.csv');
$datatmp = [];
$data = [];
foreach ($csvFile as $line) {
    if (preg_match('/[0-9.]/', $line)) {
        $datatmp = str_getcsv((string)$line);
        $data[] = $datatmp[1];
    }
}
#$data = [17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16]; # # calibration data
$data = [2, 4, 6, 8, 12, 14, 16, 18, 20]; # calibration data


#############################################
# Simple Moving Average
#############################################
//--------------------------------------------------------
echo "<hr>";

#############################################
# Simple Moving Average
#############################################
function calculateMovingAverage2($data, $windowSize): array
{
    $movingAverage = [];
    $numDataPoints = count($data);
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

function forecastMovingAverage2($movingAverage, $forecastSize): array
{
    $numMovingAverage = count($movingAverage);
    $forecast = [];
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

$windowSize = WINDOW_SIZE;
$forecastSize = FORECAST_SIZE;
$resultCalculation = calculateMovingAverage2($data, $windowSize);
$resultForecast = forecastMovingAverage2($resultCalculation, $forecastSize);


echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Average: 4,6,8.66,11.33,14,16,18 ✅";
// https://goodcalculators.com/simple-moving-average-calculator/

showInfo($data, $resultCalculation, $resultForecast);
makePlot($data, $resultCalculation, $resultForecast, 'Simple Moving Average');

//--------------------------------------------------------
echo "<hr>";
#############################################
#  exponential Moving Average
#############################################

function exponentialMovingAverageForecast($data, $periods, $forecastPeriods): array
{
    $alpha = 2 / ($periods + 1);
    $ema = array_slice($data, 0, $periods);
    $forecast = [];
    $ema[] = array_sum($ema) / $periods;
    for ($i = $periods; $i < count($data) + $forecastPeriods; $i++) {
        $emaValue = round($alpha * $data[$i] + (1 - $alpha) * $ema[$i - 1], 2);
        $ema[] = $emaValue;
        if ($i >= count($data)) {
            $forecast[] = $emaValue;
        }
    }
    return $forecast;
}

function exponentialMovingAverage($data, $periods)
{
    $alpha = 2 / ($periods + 1);
    $ema = array_slice($data, 0, $periods);
    for ($i = 1, $iMax = count($data); $i < $iMax; $i++) {
        $ema[$i] = round($alpha * $data[$i] + (1 - $alpha) * $ema[$i - 1], 2);
    }
    return $ema;
}

// Example usage
#$data = [10, 15, 20, 25, 30];
$periods = WINDOW_SIZE;
$forecastPeriods = FORECAST_SIZE;

$resultCalculation = exponentialMovingAverage($data, $periods);
$resultForecast = exponentialMovingAverageForecast($data, $periods, $forecastPeriods);

echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values: 2,3,4.5,6.25,9.12,11.56,13.78,15.89,17.94 ✅";
# https://goodcalculators.com/exponential-moving-average-calculator/

showInfo($data, $resultCalculation, $resultForecast);
makePlot($data, $resultCalculation, $resultForecast, 'Exponential moving Average');

//--------------------------------------------------------
echo "<hr>";
#############################################
#  Exponential smoothing
#############################################

function exponentialSmoothingForecast($data, $alpha, $forecastPeriods): array
{
    $forecast = [];
    if ($alpha < 0 || $alpha > 1) {
        throw new Exception("Invalid alpha value.");
    }
    $forecast[] = $data[0];
    for ($i = 1; $i < $forecastPeriods; $i++) {
        $forecastValue = round($alpha * $data[$i] + (1 - $alpha) * $forecast[$i - 1], 2);
        $forecast[] = $forecastValue;
    }
    return $forecast;
}

function exponentialSmoothing($data, $alpha): array
{
    $smoothedData = [];
    $smoothedData[0] = $data[0];
    for ($i = 1, $iMax = count($data); $i < $iMax; $i++) {
        $smoothedData[$i] = round($alpha * $data[$i] + (1 - $alpha) * $smoothedData[$i - 1], 3);
    }
    return $smoothedData;
}

// Example usage
#$data = [10, 15, 20, 25, 30];
$alpha = 0.5;
$forecastPeriods = FORECAST_SIZE;

$resultCalculation = exponentialSmoothing($data, $alpha);
$resultForecast = exponentialSmoothingForecast($data, $alpha, $forecastPeriods);

echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values: 2, 3, 4.5, 6.25, 9.125, 11.56, 13.78, 15.89, 17.94 ✅";
# https://www.mathcelebrity.com/exposmooth.php

showInfo($data, $resultCalculation, $resultForecast);
makePlot($data, $resultCalculation, $resultForecast, 'Exponential smoothing');


//--------------------------------------------------------
echo "<hr>";
#############################################
#  cumulative Average
#############################################

function cumulativeAverageForecast($data, $forecastPeriods)
{
    $cumulativeAverage = cumulativeAverage($data);
    $forecast = [];

    $lastValue = end($data);

    for ($i = 0; $i < $forecastPeriods; $i++) {
        $forecastValue = round(($lastValue + $cumulativeAverage[count($cumulativeAverage) - 1]) / 2, 2);
        $forecast[] = $forecastValue;
        $lastValue = $forecastValue;
    }

    return $forecast;
}

function cumulativeAverage($data)
{
    $cumulativeAverage = [];
    $sum = 0;

    foreach ($data as $index => $value) {
        $sum += $value;
        $cumulativeAverage[] = round($sum / ($index + 1), 2);
    }

    return $cumulativeAverage;
}

// Example usage
#$data = [10, 15, 20, 25, 30];
$forecastPeriods = FORECAST_SIZE;

$resultCalculation = cumulativeAverage($data);
$resultForecast = cumulativeAverageForecast($data, $forecastPeriods);

echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values: [2.0, 3.0, 4.0, 5.0, 6.4, 7.66, 8.85, 10.0, 11.11]  ✅";

showInfo($data, $resultCalculation, $resultForecast);
makePlot($data, $resultCalculation, $resultForecast, 'Cumulative Average');


//--------------------------------------------------------
echo "<hr>";

#############################################
#  Moving median
#############################################

function movingMedianForecast($data, $windowSize, $forecastPeriods): array
{
    $forecast = [];
    rsort($data);
    for ($i = 0; $i < $forecastPeriods; $i++) {
        $window = array_slice($data, $i, $windowSize);
        $median = calculateMedian($window);
        $forecast[] = $median;
    }
    sort($forecast);
    return $forecast;
}

function movingMedian($data, $windowSize): array
{
    $numData = count($data);
    $halfWindowSize = floor($windowSize / 2);
    $movingMedians = [];
    for ($i = 0; $i < $numData; $i++) {
        $startIndex = max(0, $i - $halfWindowSize);
        $endIndex = min($numData - 1, $i + $halfWindowSize);
        $window = array_slice($data, $startIndex, $endIndex - $startIndex + 1);
        sort($window);
        $medianIndex = floor(count($window) / 2);
        $movingMedians[] = $window[$medianIndex];
    }
    return $movingMedians;
}

function calculateMedian($data)
{
    sort($data);
    $count = count($data);
    $middle = floor(($count - 1) / 2);
    if ($count % 2 === 0) {
        $median = round(($data[$middle] + $data[$middle + 1]) / 2, 2);
    } else {
        $median = $data[$middle];
    }
    return $median;
}

// Example usage
#$data = [10, 15, 20, 25, 30];
$windowSize = WINDOW_SIZE;
$forecastPeriods = FORECAST_SIZE;

$resultCalculation = movingMedian($data, $windowSize);
$resultForecast = movingMedianForecast($resultCalculation, $windowSize, $forecastPeriods);

echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values: [2, 4, 4, 6, 8, 12, 14, 16, 18, 20]  ✅";

$dataTmp = array_map(function ($el) {
    return $el + 2;
}, $data);

showInfo($dataTmp, $resultCalculation, $resultForecast);
makePlot($dataTmp, $resultCalculation, $resultForecast, 'Moving median');

