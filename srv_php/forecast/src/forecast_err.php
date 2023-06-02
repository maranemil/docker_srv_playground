<?php

error_reporting(E_ERROR);
ini_set('display_errors', 'On');
require_once('php-libplot.class.php');

const FORECAST_TYPE = 'MONTH'; // MONTH DAY
const TEST_CALC = false;
const TEST_RANDOM = true;

if (FORECAST_TYPE === 'MONTH') {
    define("WINDOW_SIZE", 3);
    define("FORECAST_SIZE", WINDOW_SIZE);
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
        return $el - 2;
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


$csvFile = file('data/month-sql.csv');


$datatmp = [];
$data = [];
foreach ($csvFile as $line) {
    if (preg_match('/[0-9.]/', $line)) {
        $datatmp = str_getcsv((string)$line);
        $data[] = $datatmp[1];
    }
}


if (TEST_RANDOM) {
    $data = [];
    foreach (range(0, 36) as $number) {
        try {
            $data[] = random_int(11, 21);
        } catch (Exception $e) {
        }
    }
}
if (TEST_CALC) {
    #$data = [2, 4, 6, 8, 12, 14, 16, 18, 20,22,24,26,28,30];
    $data = [17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16, 17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16];
}

#$data = [17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16, 17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16];


/**
 *
 *
 *
 *
 *
 *
 */

function zeroLagEMA3($data, $period): array
{
    $countAverage = count((array)$data);
    $Alpha = 2.0 / ($period + 1);
    $Lag = ceil(($period - 1) / 2.0);
    $calculation = [];
    $ZLEMA = [];
    for ($i = $period; $i < $countAverage; $i++) {
        $PrevZeroLagEMA = $ZLEMA[$i - 1]??0;
        $AppliedPrice = $data[$i];
        $LagAppliedPrice = $data[$Lag - 1] ?? 0;
        $EMA = round($Alpha * (2.0 * $AppliedPrice - $LagAppliedPrice) + (1.0 - $Alpha) * $PrevZeroLagEMA, 2);
        #$EMA = $data[$i] + ($data[$i] - $LagAppliedPrice);
        $calculation[] = $EMA;
        $ZLEMA[] = $calculation[$Lag]??0;
    }
    return $calculation;
}

function zeroLagEMAForecast3($data, $period): array
{
    $dataTmp = array_slice($data, count($data) / 4);
    $countAverage = count((array)$dataTmp);
    $Alpha = 2.0 / ($period + 1);
    $Lag = Ceil(($period - 1) / 2.0);
    //$LagAppliedPrice – $AppliedPrice on Lag bar;
    $calculation = [];
    for ($i = $period; $i < $countAverage; $i++) {
        $PrevZeroLagEMA = $dataTmp[$i - 1];
        $AppliedPrice = $dataTmp[$i];
        $LagAppliedPrice = $dataTmp[$i - 1];
        $ZeroLagEMA = round($Alpha * (2.0 * $AppliedPrice - $LagAppliedPrice) + (1.0 - $Alpha) * $PrevZeroLagEMA, 2);
        $calculation[] = $ZeroLagEMA;
    }
    return $calculation;
}


// Example usage
#$data = [10, 15, 20, 25, 30];
$period = WINDOW_SIZE;
$forecastPeriods = FORECAST_SIZE;
$resultCalculation = zeroLagEMA3($data, $period);
$resultForecast = array_slice(zeroLagEMAForecast3($resultCalculation, $period), count($resultCalculation) / 2);

showInfo($data, $resultCalculation, $resultForecast);
try {
    makePlot($data, $resultCalculation, $resultForecast, 'Zero lag EMA3');
} catch (Exception $e) {
}
errorsCalculator($data, $resultCalculation, WINDOW_SIZE);
//--------------------------------------------------------
echo "<hr>";

/**
 *
 *
 *
 *
 *
 *
 */

function zeroLagEMA2($data, $period): array
{
    $lag = ($period - 1) / 2;
    $countAverage = count((array)$data);
    $calculation = [];
    $Alpha = 2.0 / ($period + 1);
    $ZLEMAArr = [];
    for ($i = $period; $i < $countAverage; $i++) {
        $PrevZLEMAArr = $ZLEMAArr[$lag] ?? 0;
        $ZLEMA = $Alpha * ($data[$i] + ($data[$i - 1]  + (1.0 - $Alpha) * $PrevZLEMAArr));
        $calculation[] = $ZLEMA??0;
        $ZLEMAArr[] = $ZLEMA;
    }
    return $calculation;
}

function zeroLagEMAForecast2($resultCalculation, $period): array
{
    #$resultCalculationTmp = array_slice($resultCalculation, count($resultCalculation) / 2);
    $lag = ($period - 1) / 2;
    $countAverage = count((array)$resultCalculation);
    $calculation = [];
    $ZLEMAArr = [];
    $Alpha = 2.0 / ($period + 1);
    for ($i = $period; $i < $countAverage; $i++) {
        $prev = $ZLEMAArr[$lag] ?? 0;
        $ZLEMA = $Alpha * ($resultCalculation[$i] + ($resultCalculation[$i] - $prev));
        $calculation[] = $ZLEMA;
        $ZLEMAArr[] = $ZLEMA;
    }
    return $calculation;
}


// Example usage
#$data = [10, 15, 20, 25, 30];
$period = WINDOW_SIZE;
$forecastPeriods = FORECAST_SIZE;
$resultCalculation = zeroLagEMA2($data, $period);
$resultForecast = array_slice(zeroLagEMAForecast2($resultCalculation, $period), count($resultCalculation) / 2);
if (TEST_CALC) {
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values: [ nan, nan,  6.0, 8.0, 12.00, 14.00, 16.0, 18.0, 20.0 ] ❌";
}
showInfo($data, $resultCalculation, $resultForecast);
try {
    makePlot($data, $resultCalculation, $resultForecast, 'Zero lag EMA2');
} catch (Exception $e) {
}
errorsCalculator($data, $resultCalculation, WINDOW_SIZE);
//--------------------------------------------------------
echo "<hr>";

/**
 *
 *
 *
 *
 *
 *
 */

###################################################
# Relative Moving Average
###################################################

function RelativeMovingAverage($data, $windowSize): array
{
    #print_r($data);
    $countAverage = count((array)$data);
    $calculation = [];
    for ($i = 0; $i < $countAverage; $i++) {
        $RMA = 0;
        if ($i > $windowSize) {
            $RMA = round((1 / $windowSize) * $data[$i] + (1 - (1 / $windowSize)) * $data[$i - 1][1], 2) * $windowSize;
        }
        if ($RMA) {
            $calculation[$i] = $RMA;
        }
    }
    return $calculation;
}


$resultCalculation = RelativeMovingAverage($data, WINDOW_SIZE);
$resultForecast = RelativeMovingAverage(array_chunk($resultCalculation, count($data) / 3)[2], FORECAST_SIZE);
#$resultForecast = RelativeMovingAverage($resultCalculation, FORECAST_SIZE);
#$resultForecast = [];
showInfo($data, $resultCalculation, $resultForecast);

foreach (range(1, WINDOW_SIZE) as $i) {
    $arr_rand_values[] = $i;
}
try {
    makePlot(
        $data,
        array_merge_recursive(array_rand($arr_rand_values, WINDOW_SIZE), $resultCalculation),
        array_merge_recursive($resultForecast),
        'Relative Moving Average'
    );
} catch (Exception $e) {
}
errorsCalculator($data, $resultCalculation, WINDOW_SIZE);

/**
 *
 *
 *
 *
 *
 *
 */

###################################################
#Rolling Moving Average RMA
###################################################

/*
https://download.esignal.com/products/workstation/help/charts/studies/rmi.htm
Formula
RMA = ((RMA(t-1) * (n-1)) + Xt) / n
n = The length of the Moving Average
X = Price
*/

function RollingMovingAverage($data, $windowSize): array
{
    $countAverage = count((array)$data);
    $calculation = [];
    for ($i = 0; $i < $countAverage; $i++) {
        $RMA = 0;
        $k = $i - 1;
        if ($i > $windowSize && isset($data[$i]) > 0 && $k > 0) {
            $RMA = round((($calculation[$k] * ($windowSize - 1)) + $data[$i]) / $windowSize, 2);
        }
        if ($RMA) {
            $calculation[$i] = $RMA;
        }
    }

    return $calculation;
}

$resultCalculation = RollingMovingAverage($data, WINDOW_SIZE);
#$resultCalculationTmp = array_chunk($resultCalculation, count($data) / 2)[1];
$resultCalculationTmp = array_slice($resultCalculation, count($resultCalculation) / 2, -1);
#print_r($resultCalculationTmp);
$resultForecast = RollingMovingAverage($resultCalculationTmp, FORECAST_SIZE);
#$resultForecast = [];
showInfo($data, $resultCalculation, $resultForecast);

try {
    makePlot(
        $data,
        array_merge_recursive($resultCalculation),
        array_merge_recursive($resultForecast),
        'Rolling Moving Average'
    );
} catch (Exception $e) {
}
errorsCalculator($data, $resultCalculation, WINDOW_SIZE);

/**
 *
 *
 *
 *
 *
 *
 */


###################################################
# WMA SMA
###################################################

function WeightedMovingAverage($data, $windowSize): array
{
    /*foreach (range(1, $windowSize) as $i) {
        $weights[] = $i / 10;
        #$weights[] = rand(1,2); // user random 1,2 weights
    }*/

    /*
     * # jump from x to x
     * -----------------------------------
     * $numAverage = count($data);
    #$vals[-1] = [$data[0],$data[1],$data[2]];
    for ($i = 0; $i <= $windowSize; $i++) {
        $end = $numAverage - ($i + 1);
        $start = $end - ($windowSize - 1);
        echo "start=" . $start . " end=" . $end . "<br>";
        for ($j = $start; $j <= $end; $j++) {
            $vals[$i][] = $data[$j];
        }
    }
    sort($vals);*/

    $groupValues = [];
    $countAverage = count($data);
    for ($i = 0; $i < $countAverage - $windowSize; $i++) {
        $end = $countAverage - ($i + 1);
        $start = $end - ($windowSize - 1);
        #echo "start=" . $start . " end=" . $end . "<br>";
        for ($j = $start; $j <= $end; $j++) {
            $groupValues[$i][] = $data[$j];
        }
    }
    $calculation = [];
    foreach ($groupValues as $groupValue) {
        $sum = 0;
        for ($i = 0; $i < $windowSize; $i++) {
            $sum += $groupValue[$i]; // * $weights[$i];
        }
        $calculation[] = round((($sum / $windowSize) * 100) / 100, 2);
    }

    return $calculation;
}

function forecastWeightedMovingAverage($movingAverage, $forecastSize): array
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

#$data = [2,3,4,6,8,12,14,16,18,20];
$resultCalculation = WeightedMovingAverage($data, WINDOW_SIZE);
$resultForecast = forecastWeightedMovingAverage(array_merge($resultCalculation), FORECAST_SIZE);
showInfo($data, $resultCalculation, $resultForecast);

if (TEST_CALC) {
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values N=3: [4.0, 6.0, 8.66, 11.33, 14.0, 16.0, 18.0] ";
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values N=3: [4.0, 6.0, 8.5, 11.5, 14.0, 16.0, 18.0] ";
}

foreach (range(1, WINDOW_SIZE) as $i) {
    $arr_rand_values[] = $i;
}
try {
    makePlot(
        $data,
        array_merge_recursive(array_rand($arr_rand_values, WINDOW_SIZE), $resultCalculation),
        array_merge_recursive($resultForecast),
        'WMA - Weighted Moving Average'
    );
} catch (Exception $e) {
}
errorsCalculator($data, $resultCalculation, WINDOW_SIZE);

/**
 *
 *
 *
 *
 *
 *
 */

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
errorsCalculator($data, $resultCalculation, WINDOW_SIZE);

//--------------------------------------------------------
echo "<hr>";

/**
 *
 *
 *
 *
 *
 *
 */


#############################################
#  zero Lag EMA
#############################################

function zeroLagEMAForecast($data, $windowSize)
{
    $Average = [];

    $numDataPoints = count($data);
    for ($i = $windowSize - 1; $i < $numDataPoints; $i++) {
        $sum = 0;
        for ($j = $i; $j >= $i - ($windowSize - 1); $j--) {
            $sum += $data[$j];
        }
        $average = $sum / $windowSize;
        $Average[] = round($average, 2);
    }
    return $Average;
}


/*function zeroLagEMAForecast($resultCalculation, $period, $forecastPeriods): array
{
    $zlemaAll = zeroLagEMA($resultCalculation, $period);
    $zlemaTmp = array_chunk($zlemaAll, 3);
    $zlema = $zlemaTmp[2];
    $forecast = [];
    for ($i = 0; $i < $forecastPeriods; $i++) {
        $lastValue = end($resultCalculation);
        $forecastValue = zeroLagEMACalc(
            $lastValue,
            $period
        ); // trim(round((2 * $lastValue) - $zlema[count($zlema) - 1], 2));
        #$forecastValue =  trim(round(( 2* $lastValue) - $zlema[count($zlema) - 1], 2));
        $forecast[] = ($forecastValue);
        // Update the data array and recalculate the ZLEMA
        $resultCalculation[] = ($forecastValue);
        $zlema = zeroLagEMA($resultCalculation, $period);
    }
    return $forecast;
}*/

function zeroLagEMACalc($value, $period): float
{
    $multiplier = 2 / ($period + 1);
    $ema1 = $ema2 = $ema3 = $ema4 = $ema5 = null;
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
    return round(6 * $ema1 - 15 * $ema2 + 20 * $ema3 - 15 * $ema4 + 6 * $ema5, 2);
}

function zeroLagEMA($data, $period): array
{
    $zlema = [];
    foreach ($data as $value) {
        $zlema[] = zeroLagEMACalc($value, $period);
    }
    return $zlema;
}

// Example usage
#$data = [10, 15, 20, 25, 30];
$period = WINDOW_SIZE;
$forecastPeriods = FORECAST_SIZE;
$resultCalculation = zeroLagEMA($data, $period);
$resultForecast = zeroLagEMAForecast($resultCalculation, $period);
if (TEST_CALC) {
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values: [ nan, nan,  6.0, 8.0, 12.00, 14.00, 16.0, 18.0, 20.0 ] ❌";
}
showInfo($data, $resultCalculation, $resultForecast);
try {
    makePlot($data, $resultCalculation, $resultForecast, 'Zero lag EMA');
} catch (Exception $e) {
}
errorsCalculator($data, $resultCalculation, WINDOW_SIZE);
//--------------------------------------------------------
echo "<hr>";


/**
 *
 *
 *
 *
 *
 *
 */

#############################################
# Moving Average Crossover  MAC
##############################################

/*
 * Simple Moving Average Formulas  5-day simple moving average
-----------------------------
Daily Closing Prices: 11,12,13,14,15,16,17
First day of 5-day SMA: (11 + 12 + 13 + 14 + 15) / 5 = 13
Second day of 5-day SMA: (12 + 13 + 14 + 15 + 16) / 5 = 14
Third day of 5-day SMA: (13 + 14 + 15 + 16 + 17) / 5 = 15

Exponential Moving Average Formulas
-----------------------------
Initial SMA: 10-period sum / 10
Multiplier: (2 / (Time periods + 1) ) = (2 / (10 + 1) ) = 0.1818 (18.18%)
EMA: {Close - EMA(previous day)} x multiplier + EMA(previous day).

The Weighting Multiplier
-----------------------------
Time Period = (2 / Percentage) - 1
3% Example:  Time Period = (2 / 0.03) - 1 = 65.67 time periods

*/

/**
 *
 *
 *
 *
 *
 *
 */

#############################################
#  Moving weights
#############################################
/*
function AlternativeWeightedMovingAverageForecast($data, $weights, $forecastPeriods): array
{
    $forecast = [];
    #*if (count($weights) !== count($data)) {
    #    throw new RuntimeException("The number of weights must match the data size.");
    #}

    $sumWeights = array_sum($weights);
    #$weights = array_map(static function ($weight) use ($sumWeights) {
    #    return $weight / $sumWeights;
    #}, $weights);

    for ($i = count($weights); $i < $forecastPeriods; $i++) {
        $forecastValue = 0;
        $windowSize = min($i + 1, count($data));
        for ($j = 0; $j < $windowSize; $j++) {
            $forecastValue += round($weights[$j] * $data[$i - $j], 2);
        }
        $forecast[] = $forecastValue;
    }
    return $forecast;
}

function AlternativeWeightedMovingAverage($data, $weights): array
{
    $numData = count($data);
    $numWeights = count($weights);
    $halfNumWeights = floor($numWeights / 2);
    $weightedMovingAverages = [];

    for ($i = $numWeights; $i < $numData; $i++) {
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
foreach (range(1, WINDOW_SIZE * 2) as $i) {
    $weights[] = $i / 10;
}

$resultCalculation = AlternativeWeightedMovingAverage($data, $weights);
$resultCalculationTmp = array_chunk((array)$resultCalculation, count($resultCalculation) / 4)[3];
#print_r($resultCalculationTmp);

$resultForecast = AlternativeWeightedMovingAverage(
    $resultCalculationTmp,
    $weights
);

if (TEST_CALC) {
    echo "<br><a style='color: orange; font-size: 16pt'>■</a>Expected Values: 7.6, 10.1, 12.5, 14.8, 17 ❌";
}
# Vector of Weights 0.1,0.15,0.2,0.25,0.3
# https://goodcalculators.com/weighted-moving-average-calculator/

showInfo($data, $resultCalculation, $resultForecast);
foreach (range(1, WINDOW_SIZE) as $i) {
    $arr_rand_values[] = $i;
}
try {
    makePlot(
        $data,
        array_merge_recursive(array_rand($arr_rand_values, WINDOW_SIZE), $resultCalculation),
        array_merge_recursive($resultForecast),
        'Alternative Weighted Moving Average'
    );
} catch (Exception $e) {
}
errorsCalculator($data, $resultCalculation, WINDOW_SIZE);

//--------------------------------------------------------
echo "<hr>";
*/

/**
 *
 *
 *
 *
 *
 *
 */

#############################################
#  running Total
#############################################
/*
function runningTotalForecast($data, $forecastPeriods): array
{
    $runningTotal = array_sum($data);
    $forecast = [];
    for ($i = 0; $i < $forecastPeriods; $i++) {
        $forecastValue = $runningTotal;
        $forecast[] = $forecastValue / 10;
        $runningTotal += $forecastValue;
    }
    return $forecast;
}

function runningTotal($data): array
{
    $runningTotal = [0];
    $sum = 0;
    foreach ($data as $value) {
        $sum += $value;
        $runningTotal[] = round($sum / count($runningTotal), 2);
    }
    return $runningTotal;
}

// Example usage
#$data = [10, 15, 20, 25, 30];
$forecastPeriods = FORECAST_SIZE;

$resultCalculation = runningTotal($data);
$resultCalculationTmp = array_chunk($resultCalculation, 4)[3];
$resultForecast = runningTotalForecast($resultCalculationTmp, $forecastPeriods);
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
errorsCalculator($data, $resultCalculation, WINDOW_SIZE);
*/

/**
 *
 *
 *
 *
 *
 *
 */

#############################################
#  Rising moving Average
#############################################

/*
function risingMovingAverageForecast($data, $windowSize, $forecastPeriods): array
{
    $forecast = [];
    if ($windowSize <= 0 || $windowSize > count($data)) {
        throw new RuntimeException("Invalid window size.");
    }

    for ($i = 0; $i < $forecastPeriods; $i++) {
        $window = array_slice($data, -$windowSize);
        $average = array_sum($window) / $windowSize;
        $forecastValue = round($average + ($i > 0 ? $forecast[$i - 1] : 0), 2) / 2;
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
        'RMA - Rising Moving Average'
    );
} catch (Exception $e) {
}
errorsCalculator($data, $resultCalculation, WINDOW_SIZE);

*/