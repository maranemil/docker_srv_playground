<?php

error_reporting(E_ERROR);
ini_set('display_errors', 'On');
require_once('php-libplot.class.php');
function calculateWeightAverage($data, $windowSize): array
{
    $WeightAverage = [];
    $numDataPoints = count($data);
    #$arWeight = [(4 / 10), (3 / 10), (2 / 10), (1 / 10)]; # 4 elem windowSize
    foreach(range($windowSize,1) as $i){
        $arWeight[] = $i/10;
    }
    for ($i = $windowSize - 1; $i < $numDataPoints; $i++) {
        $count = 0;
        $WMA = 0;
        for ($j = $i; $j >= $i - ($windowSize - 1); $j--) {
            $WMA += $data[$j] * $arWeight[$count];
            $count++;
        }
        $WeightAverage[] = round($WMA, 2);
    }
    return $WeightAverage;
}

function forecastWeightAverage($arrWeightAverage, $forecastSize): array
{
    $numMovingAverage = count($arrWeightAverage);
    $forecast = [];
    // Forecast future values based on the moving average
    for ($i = 0; $i < $forecastSize; $i++) {
        $sum = 0;
        $start = $numMovingAverage - ($i + 1);
        $end = $start - ($forecastSize - 1);
        for ($j = $start; $j >= $end; $j--) {
            $sum += $arrWeightAverage[$j];
        }
        $average = $sum / $forecastSize;
        $forecast[] = round($average, 2);
    }
    return $forecast;
}

$data = [17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16, 17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16];

////////////////////////////////////////////////////


$windowSize = 4;
$forecastSize = 4;
$arrWeightAverage = calculateWeightAverage($data, $windowSize);
$forecastWeightAverage = forecastWeightAverage($arrWeightAverage, $forecastSize);

// Print the data
echo "<br><a style='color: blue; font-size: 16pt'>■</a>Data :";
foreach ($data as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: orange; font-size: 16pt'>■</a>Weight Average:";
foreach ($arrWeightAverage as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: green; font-size: 16pt'>■</a>Forecast:";
foreach ($forecastWeightAverage as $value) {
    echo $value . "\n";
}

$arrForecastPlot = array_merge_recursive($arrWeightAverage, $forecastWeightAverage);
$plt = new php_plotlib();
$plt->width($width = 7.4);
$plt->height($height = 1.8);
$plt->plot($data, null, '--'); # blue
$plt->plot($arrWeightAverage, null, 'o'); # orange
$plt->plot($arrForecastPlot, null, '-'); # green
$plt->title("Weight Average 4");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';
echo "<hr/>";


////////////////////////////////////////////////////


$windowSize = 6;
$forecastSize = 6;
$arrWeightAverage = calculateWeightAverage($data, $windowSize);
$forecastWeightAverage = forecastWeightAverage($arrWeightAverage, $forecastSize);

// Print the data
echo "<br><a style='color: blue; font-size: 16pt'>■</a>Data :";
foreach ($data as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: orange; font-size: 16pt'>■</a>Weight Average:";
foreach ($arrWeightAverage as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: green; font-size: 16pt'>■</a>Forecast:";
foreach ($forecastWeightAverage as $value) {
    echo $value . "\n";
}

$arrForecastPlot = array_merge_recursive($arrWeightAverage, $forecastWeightAverage);
$plt = new php_plotlib();
$plt->width($width = 7.4);
$plt->height($height = 1.8);
$plt->plot($data, null, '--'); # blue
$plt->plot($arrWeightAverage, null, 'o'); # orange
$plt->plot($arrForecastPlot, null, '-'); # green
$plt->title("Weight Average 6");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';
echo "<hr/>";

