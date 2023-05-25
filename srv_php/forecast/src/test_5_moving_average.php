<?php

error_reporting(E_ERROR);
ini_set('display_errors', 'On');
require_once('php-libplot.class.php');

#############################################
# Moving Average
#############################################
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

function forecastMovingAverage($movingAverage, $forecastSize): array
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
foreach (range(0, 99) as $number) {
    try {
        $data[] = random_int(1, 21);
    } catch (Exception $e) {
    }
}
#$data = [17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16];
$data = [17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16, 17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16];

########################################################################
# MA 2
########################################################################

$windowSize = 2;
$forecastSize = 2;
$movingAverage = calculateMovingAverage($data, $windowSize);
$forecast = forecastMovingAverage($movingAverage, $forecastSize);

// Print the data
echo "<br><a style='color: blue; font-size: 16pt'>■</a>Data :";
foreach ($data as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: orange; font-size: 16pt'>■</a>Moving Average:";
foreach ($movingAverage as $value) {
    echo $value . "\n";
}

// Print the forecasted values
echo "<br><a style='color: green; font-size: 16pt'>■</a>Forecasted Values:";
foreach ($forecast as $value) {
    echo $value . "\n";
}

$movingAveragePlot = $movingAverage; // array_merge_recursive($data, $movingAverage);
$forecastPlot = array_merge_recursive($movingAveragePlot, $forecast);
$plt = new php_plotlib();
$plt->width($width = 7.4);
$plt->height($height = 1.8);
$plt->plot($data, null, '-'); # blue
$plt->plot($movingAveragePlot, null, 'o'); # orange
$plt->plot($forecastPlot, null, '--'); # green
$plt->title("MA 2");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';
echo "<hr/>";

########################################################################
# MA 4
########################################################################

$windowSize = 4;
$forecastSize = 4;
$movingAverage = calculateMovingAverage($data, $windowSize);
$forecast = forecastMovingAverage($movingAverage, $forecastSize);

// Print the data
echo "<br><a style='color: blue; font-size: 16pt'>■</a>Data :";
foreach ($data as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: orange; font-size: 16pt'>■</a>Moving Average:";
foreach ($movingAverage as $value) {
    echo $value . "\n";
}

// Print the forecasted values
echo "<br><a style='color: green; font-size: 16pt'>■</a>Forecasted Values:";
foreach ($forecast as $value) {
    echo $value . "\n";
}

$movingAveragePlot = $movingAverage; // array_merge_recursive($data, $movingAverage);
$forecastPlot = array_merge_recursive($movingAveragePlot, $forecast);
$plt = new php_plotlib();
$plt->width($width = 7.4);
$plt->height($height = 1.8);
$plt->plot($data, null, '-'); # blue
$plt->plot($movingAveragePlot, null, 'o'); # orange
$plt->plot($forecastPlot, null, '--'); # green
$plt->title("MA 4");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';
echo "<hr/>";


########################################################################
# MA 6
########################################################################

$windowSize = 6;
$forecastSize = 6;
$movingAverage = calculateMovingAverage($data, $windowSize);
$forecast = forecastMovingAverage($movingAverage, $forecastSize);

// Print the data
echo "<br><a style='color: blue; font-size: 16pt'>■</a>Data :";
foreach ($data as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: orange; font-size: 16pt'>■</a>Moving Average:";
foreach ($movingAverage as $value) {
    echo $value . "\n";
}

// Print the forecasted values
echo "<br><a style='color: green; font-size: 16pt'>■</a>Forecasted Values:";
foreach ($forecast as $value) {
    echo $value . "\n";
}

#$movingAverage = array_map(function($n){ return $n-7; },$movingAverage);
$movingAveragePlot = $movingAverage; // array_merge_recursive($data, $movingAverage);
$forecastPlot = array_merge_recursive($movingAveragePlot, $forecast);
$plt = new php_plotlib();
$plt->width($width = 7.4);
$plt->height($height = 1.8);
$plt->plot($data, null, '-'); # blue
$plt->plot($movingAveragePlot, null, 'o'); # orange
$plt->plot($forecastPlot, null, '--'); # green
$plt->title("MA 6");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';
echo "<hr/>";
