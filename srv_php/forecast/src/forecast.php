<?php

error_reporting(E_ERROR);
ini_set('display_errors', 'On');
require_once('php-libplot.class.php');

const FORECAST_TYPE = 'MONTH'; // MONTH DAY
const TEST_CALC = false;

if (FORECAST_TYPE === 'MONTH') {
    define("WINDOW_SIZE", 3);
    define("FORECAST_SIZE", WINDOW_SIZE);
} else {
    define("WINDOW_SIZE", 60);
    define("FORECAST_SIZE", 20);
}

echo "<br>FORECAST TYPE=" . FORECAST_TYPE;
echo "<br>WINDOW SIZE=" . WINDOW_SIZE;
echo "<br>FORECAST SIZE=" . FORECAST_SIZE;
echo "<hr>";

/**
 * @param $data
 * @param $Average
 * @param $forecast
 * @param string $label
 * @return void
 * @throws Exception
 */
function makePlot($data, $Average, $forecast, string $label = '')
{
    $AverageTmp = array_filter($Average);
    $average_c = array_sum($AverageTmp) / count($AverageTmp);
    $average = random_int($average_c - 3, $average_c + 3);
    # https://stackoverflow.com/questions/33461430/how-to-find-average-from-array-in-php

    if (WINDOW_SIZE === 3 && false !== strpos($label, "SMA")) {
        $Average = array_merge_recursive([$average, $average], $Average);
    }
    if (WINDOW_SIZE === 5 && false !== strpos($label, "SMA")) {
        $Average = array_merge_recursive([$average, $average, $average, $average], $Average);
    }
    if (WINDOW_SIZE === 7 && false !== strpos($label, "SMA")) {
        $Average = array_merge_recursive([$average, $average, $average, $average, $average, $average], $Average);
    }

    $dataTmp = array_map(static function ($el) {
        return $el + 1;
    }, $data);

    $plt = new php_plotlib();
    $plt->width(7.4);
    $plt->height(1.8);
    $plt->plot($dataTmp, null, '-'); # blue
    $plt->plot($Average, null, 'o'); # orange
    if ($forecast !== null) {
        $forecastPlot = array_merge_recursive($Average, $forecast);
        $plt->plot($forecastPlot, null, '--'); # green
    }
    $plt->title($label . " ");
    echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';
    echo "<hr/>";
}


/**
 * @param $data
 * @param $calculation
 * @param $forecast
 * @return void
 */
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

/**
 * @param $data
 * @param $resultCalculation
 * @param $windows_size
 * @return void
 */
function errorsCalculator($data, $resultCalculation, $windows_size)
{
    echo "<br>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
    $arrCalc = array_slice($data, $windows_size);
    #print_r($arrCalc);
    $arErr = [];
    foreach ($resultCalculation as $key => $item) {
        if (isset($arrCalc[$key])) {
            #echo $arrCalc[$key] .'-'. $item."<br>";
            $error1 = $arrCalc[$key] - $item;
            $error2 = round($error1 * $error1, 2);
            $percent = round((($arrCalc[$key] - $item) / $arrCalc[$key]) * 100, 2);
            $arErr[] = [
                'error1' => $error1,
                'error2' => $error2,
                'percent' => $percent
            ];
        }
    }
    $errors_cnt = count($arErr);
    print "<br> Errors Count: " . $errors_cnt;
    $errors_tot = round(array_sum(array_column($arErr, 'error1')), 3);
    print "<br> Errors Total: " . abs($errors_tot);
    $MAE = round($errors_tot / $errors_cnt, 2);
    print "<br>MAE: " . abs($MAE);
    $MSE = array_sum(array_column($arErr, 'error2')) / $errors_cnt;
    print "<br>MSE: " . round($MSE, 2);
    $RMSE = round(sqrt($MSE), 2);
    print "<br>RMSE: " . abs($RMSE);
    $MAPE = round(array_sum(array_column($arErr, 'percent')) / $errors_cnt, 2);
    print "<br>MAPE: " . abs($MAPE);
    #print "<pre>"; print_r($arErr); print "</pre>";
    echo "<br>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
}


foreach (range(0, 99) as $number) {
    try {
        $data[] = random_int(1, 21);
    } catch (Exception $e) {
    }
}


$csvFile = file('data/month.csv');

$datatmp = [];
$data = [];
foreach ($csvFile as $line) {
    if (preg_match('/[0-9.]/', $line)) {
        $datatmp = str_getcsv((string)$line);
        $data[] = $datatmp[1];
    }
}
#$data = [17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16, 17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16];
if (TEST_CALC) {
    $data = [2, 4, 6, 8, 12, 14, 16, 18, 20];
}


//--------------------------------------------------------
echo "<hr>";

#############################################
# Simple Moving Average  SMA
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

if (TEST_CALC) {
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Average for 3m: 4,6,8.67,11.33,14,16,18 ✅";
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Average for 4m: 6.65,8.75,11.25,13.75,16 ❌";
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Average for 5m: 4,8,11.2,13.6,16  ✅";
    // https://goodcalculators.com/simple-moving-average-calculator/
}
showInfo($data, $resultCalculation, $resultForecast);
try {
    makePlot($data, $resultCalculation, $resultForecast, 'SMA - Simple Moving Average');
} catch (Exception $e) {
}
errorsCalculator($data, $resultCalculation, WINDOW_SIZE);


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

if (TEST_CALC) {
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values 3m: 2,3,4.5,6.25,9.12,11.56,13.78,15.89,17.94 ✅";
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values 4m: 2,2.8,4.08,5.65,8.19,10.51,12.71,14.82,16.89  ✅";
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values 5m : 2,2.66,3.76,5.16, 7.42,9.59,11.71,13.78,15.83 ✅";
# https://goodcalculators.com/exponential-moving-average-calculator/
}
showInfo($data, $resultCalculation, $resultForecast);
try {
    makePlot($data, $resultCalculation, $resultForecast, 'EMA - Exponential moving Average');
} catch (Exception $e) {
}
errorsCalculator($data, $resultCalculation, WINDOW_SIZE - 2);


//--------------------------------------------------------
echo "<hr>";
#############################################
#  Exponential smoothing
#############################################
/*
https://otexts.com/fpp2/ses.html
https://www.simplilearn.com/exponential-smoothing-for-time-series-forecasting-in-python-article
https://www.mathcelebrity.com/exposmooth.php
*/
function exponentialSmoothingForecast($data, $alpha, $forecastPeriods): array
{
    if ($alpha < 0 || $alpha > 1) {
        throw new RuntimeException("Invalid alpha value.");
    }
    $dataTmp = array_slice($data, -4, count($data) / 2);
    $data = $dataTmp;
    $forecast = [];
    $forecast[0] = $data[0];
    for ($i = 1; $i < $forecastPeriods; $i++) {
        $forecastValue = round($alpha * $data[$i] + (1 - $alpha) * $forecast[$i - 1], 2);
        $forecast[$i] = $forecastValue;
    }
    return $forecast;
}

function exponentialSmoothing($data, $alpha): array
{
    $smoothedData = [];
    $smoothedData[0] = $data[0];
    for ($i = 1, $iMax = count($data); $i < $iMax; $i++) {
        $smoothedData[$i] = round($alpha * $data[$i] + (1 - $alpha) * $smoothedData[$i - 1], 2);
    }
    return $smoothedData;
}

// Example usage
#$data = [10, 15, 20, 25, 30];
$alpha = 0.6;
$forecastPeriods = FORECAST_SIZE;

$resultCalculation = exponentialSmoothing($data, $alpha);
$resultForecast = exponentialSmoothingForecast($resultCalculation, $alpha, $forecastPeriods);
if (TEST_CALC) {
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values alpha 0.1 3m: 2,2.2,2.58,3.12,4.01,5.01,6.11,7.3,8.57, ✅";
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values alpha 0.1 4m: 2,2.2,2.58,3.12,4.01,5.01,6.11,7.3,8.57, ✅";
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values alpha 0.3 4m: 2,2.6,3.62,4.93,7.05,9.14,11.2,13.24,15.27, ✅";
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values alpha 0.1 5m: 2,2.2,2.58,3.12,4.01,5.01,6.11,7.3,8.57, ✅";
}
showInfo($data, $resultCalculation, $resultForecast);
try {
    makePlot($data, $resultCalculation, $resultForecast, 'SES - Simple Exponential smoothing');
} catch (Exception $e) {
}
errorsCalculator($data, $resultCalculation, WINDOW_SIZE - 2);


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

if (TEST_CALC) {
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values m3: [4, 6, 8, 12, 14, 16, 18]  ✅";
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values m4: [5, 7, 10, 13, 15, 17]  ❌";
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values m5: [6, 8, 12, 14, 16]  ❌";
}


showInfo($data, $resultCalculation, $resultForecast);
try {
    makePlot($data, $resultCalculation, $resultForecast, 'MM - Moving Median');
} catch (Exception $e) {
}
errorsCalculator($data, $resultCalculation, WINDOW_SIZE - 2);




//--------------------------------------------------------
echo "<hr>";
#############################################
#  cumulative Average
#############################################
/*
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

function cumulativeAverage($data): array
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
if (TEST_CALC) {
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values m[3,4,5]: [2.0, 3.0, 4.0, 5.0, 6.4, 7.66, 8.85, 10.0, 11.11]  ✅";
# https://www.had2know.org/finance/cumulative-moving-average-calculator.html
}
showInfo($data, $resultCalculation, $resultForecast);
makePlot($data, $resultCalculation, $resultForecast, 'CA - Cumulative Average ');
errorsCalculator($data, $resultCalculation, WINDOW_SIZE - 2);
*/