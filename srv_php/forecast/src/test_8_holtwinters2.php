<?php
//////////////////////////////////////////////////
// Exponential smoothing (Holt Winters) forecastHoltWinters
//////////////////////////////////////////////////

error_reporting(E_ERROR);
ini_set('display_errors', 'On');
require_once('php-libplot.class.php');
include('forecastHoltWinters.php');

foreach (range(0, 36) as $number) {
    try {
        $data[] = random_int(10, 29);
    } catch (Exception $e) {
    }
}
$data = [17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16, 17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16];

###################################################
###################################################

[$newdata, $deviations] = forecastHoltWinters(
    $data,
    $nForecast = 4,
    $nSeasonLength = 4,
    $nAlpha = 0.2,
    $nBeta = 0.01,
    $nGamma = 0.01,
    $nDevGamma = 0.1
);
$newdata = array_map(function ($v) {
    return round($v, 2);
}, $newdata);
$deviations = array_map(function ($v) {
    return round($v, 2);
}, $deviations);

// Print the moving average
echo "<br><a style='color: blue; font-size: 16pt'>■</a> Data:";
foreach ($data as $value) {
    echo $value . "\n";
}
echo "<br><a style='color: blue; font-size: 16pt'>■</a> deviations:";
foreach ($deviations as $value) {
    echo $value . "\n";
}
echo "<br><a style='color: orange; font-size: 16pt'>■</a>  forecast Data:";
foreach ($newdata as $value) {
    echo $value . "\n";
}

$newdata = array_merge_recursive($data, $newdata);
$plt = new php_plotlib();
$plt->width($width = 7.4);
$plt->height($height = 1.8);
$plt->plot($data, null, 's'); # blue
$plt->plot($newdata, null, 'x'); # orange
$plt->plot($deviations, null, '-'); # orange
$plt->title("Holt Winters season_length 4");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';
echo "<hr/>";