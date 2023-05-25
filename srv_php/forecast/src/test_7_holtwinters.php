<?php
//////////////////////////////////////////////////
// Exponential smoothing (Holt Winters)
//////////////////////////////////////////////////

error_reporting(E_ERROR);
ini_set('display_errors', 'On');
require_once('php-libplot.class.php');
//include('forecastHoltWinters.php');
include('holtwinters.php');

foreach (range(0, 36) as $number) {
    try {
        $data[] = random_int(10, 29);
    } catch (Exception $e) {
    }
}
$data = [17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16, 17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16];

###################################################
###################################################

list($newdata, $deviations) = holt_winters(
    $data,
    $season_length = 4,
    $alpha = 0.2,
    $beta = 0.02,
    $gamma = 0.02,
    $dev_gamma = 0.1
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
echo "<br><a style='color: orange; font-size: 16pt'>■</a> new Data:";
foreach ($newdata as $value) {
    echo $value . "\n";
}
echo "<br><a style='color: green; font-size: 16pt'>■</a> deviations:";
foreach ($deviations as $value) {
    echo $value . "\n";
}


$plt = new php_plotlib();
$plt->width($width = 7.4);
$plt->height($height = 1.8);
$plt->plot($data, null, '--'); # blue
$plt->plot($newdata, null, 'o'); # orange
$plt->plot($deviations, null, '-'); # green
$plt->title("Holt Winters season_length 4");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';
echo "<hr/>";

###################################################
###################################################

list($newdata, $deviations) = holt_winters(
    $data,
    $season_length = 12,
    $alpha = 0.2,
    $beta = 0.02,
    $gamma = 0.02,
    $dev_gamma = 0.1
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
echo "<br><a style='color: orange; font-size: 16pt'>■</a> new Data:";
foreach ($newdata as $value) {
    echo $value . "\n";
}
echo "<br><a style='color: green; font-size: 16pt'>■</a> deviations:";
foreach ($deviations as $value) {
    echo $value . "\n";
}

$plt = new php_plotlib();
$plt->width($width = 7.4);
$plt->height($height = 1.8);
$plt->plot($data, null, '--'); # blue
$plt->plot($newdata, null, 'o'); # orange
$plt->plot($deviations, null, '-'); # green
$plt->title("Holt Winters season_length 12");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';
echo "<hr/>";