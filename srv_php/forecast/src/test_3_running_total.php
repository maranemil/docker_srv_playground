<?php

error_reporting(E_ERROR);
ini_set('display_errors', 'On');
require_once('php-libplot.class.php');

// Running total / Cumulative average
// https://en.wikipedia.org/wiki/Running_total

/*
 * Method
Consider the sequence <   5   8   3   2   >.
What is the total of this sequence?
Answer: 5 + 8 + 3 + 2 = 18.
This is arrived at by simple summation of the sequence.
Now we insert the number 6 at the end of the sequence to get <   5   8   3   2   6   >. What is the total of that sequence?
Answer: 5 + 8 + 3 + 2 + 6 = 24.

This is arrived at by simple summation of the sequence.
But if we regarded 18 as the running total, we need only
 add 6 to 18 to get 24. So, 18 was, and 24 now is, the running total.
In fact, we would not even need to know the sequence at all,
but simply add 6 to 18 to get the new running total;
as each new number is added, we get a new running total.
 * */

function calculateRunningTotal($data, $windowSize): array
{
    $movingAverage = [];
    $numDataPoints = count($data);
    // Calculate the moving average for the existing dataset
    for ($i = $windowSize - 1; $i < $numDataPoints; $i++) {
        $sum = 0;
        for ($j = $i; $j >= $i - ($windowSize - 1); $j--) {
            $sum += $data[$j];
        }
        $average = $sum/$windowSize;
        $movingAverage[] = round($average, 2);
    }

    return $movingAverage;
}

function forecastRunningTotal($arrRunningTotal, $forecastSize): array
{
    $numMovingAverage = count($arrRunningTotal);
    $forecast = [];
    // Forecast future values based on the moving average
    for ($i = 0; $i < $forecastSize; $i++) {
        $sum = 0;
        $start = $numMovingAverage - ($i + 1);
        $end = $start - ($forecastSize - 1);
        for ($j = $start; $j >= $end; $j--) {
            $sum += $arrRunningTotal[$j];
        }
        $average = $sum/$forecastSize;
        $forecast[] = round($average, 2);
    }
    return $forecast;
}

foreach (range(0, 56) as $number) {
    try {
        $data[] = random_int(4, 29);
    } catch (Exception $e) {
    }
}
$data = [17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16, 17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16];

////////////////////////////////////////////////////
///
$windowSize = 2;
$forecastSize = 2;
$arrRunningTotal = calculateRunningTotal($data, $windowSize);
$arrForecast = forecastRunningTotal($arrRunningTotal, $forecastSize);

// Print the data
echo "<br><a style='color: blue; font-size: 16pt'>■</a>Data :";
foreach ($data as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: orange; font-size: 16pt'>■</a>Running total:";
foreach ($arrRunningTotal as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: green; font-size: 16pt'>■</a>Forecast:";
foreach ($arrForecast as $value) {
    echo $value . "\n";
}

$arrForecast = array_merge_recursive($data,$arrForecast);
$plt = new php_plotlib();
$plt->width($width = 7.4);
$plt->height($height = 1.8);
$plt->plot($data, null, '--'); # blue
$plt->plot($arrRunningTotal,null, 'o');
$plt->plot($arrForecast,null, '-');
$plt->title("Running total 2");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';
echo "<hr/>";


////////////////////////////////////////////////////
///
$windowSize = 4;
$forecastSize = 4;
$arrRunningTotal = calculateRunningTotal($data, $windowSize);
$arrForecast = forecastRunningTotal($arrRunningTotal, $forecastSize);

// Print the data
echo "<br><a style='color: blue; font-size: 16pt'>■</a>Data :";
foreach ($data as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: orange; font-size: 16pt'>■</a>Running total:";
foreach ($arrRunningTotal as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: green; font-size: 16pt'>■</a>Forecast:";
foreach ($arrForecast as $value) {
    echo $value . "\n";
}

$arrForecast = array_merge_recursive($data,$arrForecast);
$plt = new php_plotlib();
$plt->width($width = 7.4);
$plt->height($height = 1.8);
$plt->plot($data, null, '--'); # blue
$plt->plot($arrRunningTotal,null, 'o');
$plt->plot($arrForecast,null, '-');
$plt->title("Running total 4");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';
echo "<hr/>";



////////////////////////////////////////////////////
///
$windowSize = 6;
$forecastSize = 6;
$arrRunningTotal = calculateRunningTotal($data, $windowSize);
$arrForecast = forecastRunningTotal($arrRunningTotal, $forecastSize);

// Print the data
echo "<br><a style='color: blue; font-size: 16pt'>■</a>Data :";
foreach ($data as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: orange; font-size: 16pt'>■</a>Running total:";
foreach ($arrRunningTotal as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: green; font-size: 16pt'>■</a>Forecast:";
foreach ($arrForecast as $value) {
    echo $value . "\n";
}

$arrForecast = array_merge_recursive($data,$arrForecast);
$plt = new php_plotlib();
$plt->width($width = 7.4);
$plt->height($height = 1.8);
$plt->plot($data, null, '--'); # blue
$plt->plot($arrRunningTotal,null, 'o');
$plt->plot($arrForecast,null, '-');
$plt->title("Running total 6");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';
echo "<hr/>";