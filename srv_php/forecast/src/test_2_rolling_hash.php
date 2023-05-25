<?php

declare(strict_types=1);
error_reporting(E_ERROR);
ini_set('display_errors', 'On');
require_once('php-libplot.class.php');

// Fast implementation of rolling hash in PHP
// https://stackoverflow.com/questions/30829101/fast-implementation-of-rolling-hash-in-php
// https://www.php.net/manual/de/function.hash.php

#$contents = "addagtrtz45646dda";
#$ords = array_values(unpack("C*", $contents)); // make 0-based array

foreach (range(0, 56) as $number) {
    try {
        $data[] = random_int(10, 29);
    } catch (Exception $e) {
    }
}
$data = [17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16, 17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16];
function calculateRollingHash($data,$windosSize){
    $a = 1;
    $b = 0; // hash low and high words
    $arrRollingHash = [];
    foreach ($data as $i => $ord) {
        if ($i < $windosSize) {
            $a = ($a + $ord) % 65521;
            $b = ($b + $a) % 65521;
        } else {
            $removed = $data[$i - $windosSize];
            $a = ($a + $ord - $removed + 65521) % 65521;
            $b = ($b + $a - 1 - $windosSize * $removed + 65521) % 65521;
        }
        if ($i >= $windosSize - 1) {
            /*echo $i - $len + 1, "---", $i, ": ",
            substr($i - $len + 1, $len), " => ",
                round(($b * 65536 + $a)/100000,2), "<br>";*/
            $arrRollingHash[] = round(($b * 65536 + $a) / 100000, 2);
        }
    }
    return $arrRollingHash;
}


function forecastRollingHash($movingAverage, $forecastSize): array
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

$windosSize = 2; // the window length
$forecastSize = 2;
$arrRollingHash = calculateRollingHash($data,$windosSize);
$forecast = forecastRollingHash($arrRollingHash, $forecastSize);
$forecastPlot = array_merge_recursive($arrRollingHash, $forecast);

// Print the data
echo "<br><a style='color: blue; font-size: 16pt'>■</a>Data: ";
foreach ($data as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: orange; font-size: 16pt'>■</a>Rolling Hash: ";
foreach ($arrRollingHash as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: green; font-size: 16pt'>■</a>Forecast: ";
foreach ($forecast as $value) {
    echo $value . "\n";
}

$plt = new php_plotlib();
$plt->width($width = 7.4);
$plt->height($height = 1.8);
$plt->plot($data, null, '-'); # blue
$plt->plot($arrRollingHash, null, 'o'); # orange
$plt->plot($forecastPlot, null, '--'); # orange
$plt->title("RollingHash 2");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';
echo "<hr/>";

///////////////////////////////////////////

$windosSize = 4; // the window length
$forecastSize = 2;
$arrRollingHash = calculateRollingHash($data,$windosSize);
$forecast = forecastRollingHash($arrRollingHash, $forecastSize);
$forecastPlot = array_merge_recursive($arrRollingHash, $forecast);

// Print the data
echo "<br><a style='color: blue; font-size: 16pt'>■</a>Data: ";
foreach ($data as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: orange; font-size: 16pt'>■</a>Rolling Hash: ";
foreach ($arrRollingHash as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: green; font-size: 16pt'>■</a>Forecast: ";
foreach ($forecast as $value) {
    echo $value . "\n";
}

$plt = new php_plotlib();
$plt->width($width = 7.4);
$plt->height($height = 1.8);
$plt->plot($data, null, '-'); # blue
$plt->plot($arrRollingHash, null, 'o'); # orange
$plt->plot($forecastPlot, null, '--'); # orange
$plt->title("RollingHash 4");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';
echo "<hr/>";


////////////////////////////////////////////////////


$windosSize = 6; // the window length
$forecastSize = 6;
$arrRollingHash = calculateRollingHash($data,$windosSize);
$forecast = forecastRollingHash($arrRollingHash, $forecastSize);
$forecastPlot = array_merge_recursive($arrRollingHash, $forecast);

// Print the data
echo "<br><a style='color: blue; font-size: 16pt'>■</a>Data: ";
foreach ($data as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: orange; font-size: 16pt'>■</a>Rolling Hash: ";
foreach ($arrRollingHash as $value) {
    echo $value . "\n";
}

// Print the moving average
echo "<br><a style='color: green; font-size: 16pt'>■</a>Forecast: ";
foreach ($forecast as $value) {
    echo $value . "\n";
}

$plt = new php_plotlib();
$plt->width($width = 7.4);
$plt->height($height = 1.8);
$plt->plot($data, null, '-'); # blue
$plt->plot($arrRollingHash, null, 'o'); # orange
$plt->plot($forecastPlot, null, '-'); # orange
$plt->title("RollingHash 6");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';
echo "<hr/>";