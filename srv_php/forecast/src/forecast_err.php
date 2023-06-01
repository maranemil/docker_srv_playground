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
                'error1'  => $error1,
                'error2'  => $error2,
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


/*
#############################################
#  moving Average
#############################################
function movingAverageForecast($data, $windowSize, $forecastPeriods): array
{
    $forecast = [];
    for ($i = 0; $i < $forecastPeriods; $i++) {
        $window = array_slice($data, $i, $windowSize);
        $average = array_sum($window) / $windowSize;
        $forecast[] = round($average, 2);
    }
    return $forecast;
}

function calculateMovingAverage($data, $windowSize): array
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

// Example usage
#$data = [10, 15, 20, 25, 30];
$windowSize = WINDOW_SIZE;
$forecastPeriods = FORECAST_SIZE;
$resultCalculation = calculateMovingAverage($data, $windowSize);
$resultForecast = movingAverageForecast($data, $windowSize, $forecastPeriods);

showInfo($data, $resultCalculation, $resultForecast);
makePlot($data, $resultCalculation, $resultForecast, 'Moving Average');
*/

#############################################
#  Moving weights
#############################################
function movingWeightsForecast($data, $weights, $forecastPeriods): array
{
    $forecast = [];
    if (count($weights) !== count($data)) {
        throw new RuntimeException("The number of weights must match the data size.");
    }

    $sumWeights = array_sum($weights);
    $weights = array_map(static function ($weight) use ($sumWeights) {
        return $weight / $sumWeights;
    }, $weights);

    for ($i = 0; $i < $forecastPeriods; $i++) {
        $forecastValue = 0;
        $windowSize = min($i + 1, count($data));
        for ($j = 0; $j < $windowSize; $j++) {
            $forecastValue += round($weights[$j] * $data[$i - $j], 2);
        }
        $forecast[] = $forecastValue;
    }
    return $forecast;
}

function weightedMovingAverage($data, $weights): array
{
    $numData = count($data);
    $numWeights = count($weights);
    $halfNumWeights = floor($numWeights / 2);
    $weightedMovingAverages = [];
    for ($i = 0; $i < $numData; $i++) {
        $startIndex = max(0, $i - $halfNumWeights);
        $endIndex = min($numData - 1, $i + $halfNumWeights);
        $window = array_slice($data, $startIndex, $endIndex - $startIndex + 1);
        $windowSize = count($window);
        $weightedSum = 0;
        for ($j = 0; $j < $windowSize; $j++) {
            $weightedSum += round($window[$j] * $weights[$j], 2);
        }
        $weightedMovingAverages[] = round($weightedSum / array_sum($weights), 2);
    }
    return $weightedMovingAverages;
}

// Example usage
#$data = [10, 15, 20, 25, 30];
#$weights = [0.5, 0.2, 0.3, 0.4, 0.1];
foreach (range(1, count($data)) as $i) {
    $weights[] = $i / 10;
}
$forecastPeriods = 5;
$resultCalculation = weightedMovingAverage($data, $weights);
$resultForecast = movingWeightsForecast($data, $weights, $forecastPeriods);

if (TEST_CALC) {
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values: 7.6, 10.1, 12.5, 14.8, 17 ❌";
}
# Vector of Weights 0.1,0.15,0.2,0.25,0.3
# https://goodcalculators.com/weighted-moving-average-calculator/

showInfo($data, $resultCalculation, $resultForecast);
try {
    makePlot(
        $data,
        array_merge_recursive($resultCalculation),
        array_merge_recursive($resultForecast),
        'Weighted Moving Average'
    );
} catch (Exception $e) {
}


//--------------------------------------------------------
echo "<hr>";
#############################################
#  Moving Average crossover
#############################################

function movingAverageCrossoverForecast($data, $shortPeriod, $longPeriod, $forecastPeriods): array
{
    $shortMA = simpleMovingAverageCross(array_slice($data, -$shortPeriod));
    $longMA = simpleMovingAverageCross(array_slice($data, -$longPeriod));
    $forecast = [];
    for ($i = 0; $i < $forecastPeriods; $i++) {
        if ($shortMA > $longMA) {
            $forecastValue = 1;
        } else {
            $forecastValue = -1;
        }
        $forecast[] = $forecastValue;
        array_shift($data); // Remove the oldest data point
        $shortMA = simpleMovingAverageCross(array_slice($data, -$shortPeriod));
        $longMA = simpleMovingAverageCross(array_slice($data, -$longPeriod));
    }
    return $forecast;
}

function movingAverageCrossover($data, $shortPeriod, $longPeriod): array
{
    $shortMA = [];
    $longMA = [];
    $crossoverPoints = [];
    for ($i = $longPeriod - 1, $iMax = count($data); $i < $iMax; $i++) {
        $shortMA[$i] = array_sum(array_slice($data, $i - $shortPeriod + 1, $shortPeriod)) / $shortPeriod;
        $longMA[$i] = array_sum(array_slice($data, $i - $longPeriod + 1, $longPeriod)) / $longPeriod;
        if ($i > $longPeriod - 1 && $shortMA[$i] > $longMA[$i - 1] && $shortMA[$i - 1] <= $longMA[$i - 1]) {
            $crossoverPoints[] = $i;
        } elseif ($i > $longPeriod - 1 && $shortMA[$i] < $longMA[$i - 1] && $shortMA[$i - 1] >= $longMA[$i - 1]) {
            $crossoverPoints[] = -$i;
        }
    }
    return $crossoverPoints;
}

function simpleMovingAverageCross($data)
{
    return array_sum($data) / count($data);
}

// Example usage
#$data = [10, 15, 20, 25, 30, 35, 40, 45, 50];
$shortPeriod = 2; // 3
$longPeriod = 3; // 6
$forecastPeriods = FORECAST_SIZE;

$resultCalculation = movingAverageCrossover($data, $shortPeriod, $longPeriod);
$resultForecast = movingAverageCrossoverForecast($data, $shortPeriod, $longPeriod, $forecastPeriods);
if (TEST_CALC) {
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values: [4.0, 6.0, 8.66, 11.33, 14.0, 16.0, 18.0] ❌";
}
showInfo($data, $resultCalculation, $resultForecast);
try {
    makePlot(
        $data,
        array_merge_recursive($data, $resultCalculation),
        array_merge_recursive($resultForecast),
        'Moving Average crossover'
    );
} catch (Exception $e) {
}

//--------------------------------------------------------
echo "<hr>";
#############################################
#  Rising moving Average
#############################################

/**
 * @throws Exception
 */
function risingMovingAverageForecast($data, $windowSize, $forecastPeriods): array
{
    $forecast = [];
    if ($windowSize <= 0 || $windowSize > count($data)) {
        throw new RuntimeException("Invalid window size.");
    }

    for ($i = 0; $i < $forecastPeriods; $i++) {
        $window = array_slice($data, -$windowSize);
        $average = array_sum($window) / $windowSize;
        $forecastValue = round($average + ($i > 0 ? $forecast[$i - 1] : 0), 2);
        $forecast[] = $forecastValue;
    }

    return $forecast;
}

function risingMovingAverage($data, $period): array
{
    $movingAverages = [];
    for ($i = $period - 1, $iMax = count($data); $i < $iMax; $i++) {
        $sum = array_sum(array_slice($data, $i - $period + 1, $period));
        $average = $sum / $period;
        $movingAverages[] = round($average, 2);
    }
    return $movingAverages;
}

// Example usage
#$data = [10, 15, 20, 25, 30];
$windowSize = WINDOW_SIZE;
$forecastPeriods = FORECAST_SIZE;

$resultCalculation = risingMovingAverage($data, $windowSize);
try {
    $resultForecast = risingMovingAverageForecast($data, $windowSize, $forecastPeriods);
} catch (Exception $e) {
}

showInfo($data, $resultCalculation, $resultForecast);
try {
    makePlot(
        $data,
        array_merge_recursive($resultCalculation),
        array_merge_recursive([], $resultForecast),
        'Rising moving Average'
    );
} catch (Exception $e) {
}

//--------------------------------------------------------
echo "<hr>";

#############################################
#  running Total
#############################################

function runningTotalForecast($data, $forecastPeriods): array
{
    $runningTotal = array_sum($data);
    $forecast = [];
    for ($i = 0; $i < $forecastPeriods; $i++) {
        $forecastValue = $runningTotal;
        $forecast[] = $forecastValue;
        $runningTotal += $forecastValue;
    }
    return $forecast;
}

function runningTotal($data): array
{
    $runningTotal = [];
    $sum = 0;
    foreach ($data as $value) {
        $sum += $value;
        $runningTotal[] = $sum;
    }
    return $runningTotal;
}

// Example usage
#$data = [10, 15, 20, 25, 30];
$forecastPeriods = FORECAST_SIZE;

$resultCalculation = runningTotal($data);
$resultForecast = runningTotalForecast($data, $forecastPeriods);
if (TEST_CALC) {
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values: 11.11 ❌";
}
# https://3roam.com/running-total-calculator/
# Runinng total 100
# Running total average 11.11

showInfo($data, $resultCalculation, $resultForecast);

try {
    makePlot(
        $data,
        array_merge_recursive($resultCalculation),
        array_merge_recursive($resultForecast),
        'Running total'
    );
} catch (Exception $e) {
}


//--------------------------------------------------------
echo "<hr>";
#############################################
#  zero Lag EMA
#############################################

function zeroLagEMAForecast($data, $period, $forecastPeriods): array
{
    $zlema = zeroLagEMA($data, $period);
    $forecast = [];

    for ($i = 0; $i < $forecastPeriods; $i++) {
        $lastValue = end($data);
        $forecastValue = round((2 * $lastValue) - $zlema[count($zlema) - 1], 2);
        $forecast[] = $forecastValue;

        // Update the data array and recalculate the ZLEMA
        $data[] = $forecastValue;
        $zlema = zeroLagEMA($data, $period);
    }

    return $forecast;
}

function zeroLagEMA($data, $period): array
{
    $zlema = [];
    $multiplier = 2 / ($period + 1);
    $ema1 = $ema2 = $ema3 = $ema4 = $ema5 = null;

    foreach ($data as $value) {
        if ($ema1 === null) {
            // Initialize the first EMA value with the first data point
            $ema1 = $ema2 = $ema3 = $ema4 = $ema5 = $value;
        } else {
            $ema1 = ($value - $ema1) * $multiplier + $ema1;
            $ema2 = ($ema1 - $ema2) * $multiplier + $ema2;
            $ema3 = ($ema2 - $ema3) * $multiplier + $ema3;
            $ema4 = ($ema3 - $ema4) * $multiplier + $ema4;
            $ema5 = ($ema4 - $ema5) * $multiplier + $ema5;
        }

        $zlema[] = round(6 * $ema1 - 15 * $ema2 + 20 * $ema3 - 15 * $ema4 + 6 * $ema5, 2);
    }

    return $zlema;
}

// Example usage
#$data = [10, 15, 20, 25, 30];
$period = WINDOW_SIZE;
$forecastPeriods = FORECAST_SIZE;

$resultCalculation = zeroLagEMA($data, $period);
$resultForecast = zeroLagEMAForecast($data, $period, $forecastPeriods);
if (TEST_CALC) {
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values: [ nan, nan,  6.0, 8.0, 12.00, 14.00, 16.0, 18.0, 20.0 ] ❌";
}
showInfo($data, $resultCalculation, $resultForecast);
try {
    makePlot($data, $resultCalculation, $resultForecast, 'Zero lag EMA');
} catch (Exception $e) {
}

//--------------------------------------------------------
echo "<hr>";
