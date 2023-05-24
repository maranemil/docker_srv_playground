<style>
    body {
        background: #ff9900;
    }
</style>
<?php
error_reporting(E_ERROR);
ini_set('display_errors', 'On');

include('forecastHoltWinters.php');
include('holtwinters.php');
require_once('php-libplot.class.php');

# docker run --rm -d -p 80:80/tcp -p 8081:8081/tcp test_web-php:latest 

function generateARIMAData(){

    $years = range(2022, 2022);
    $months = range(1, 1);
    $days = range(1, 15);

    foreach ($years as $year) {
        foreach ($months as $month) {
            foreach ($days as $day) {
                #$indexdata = $year.'-'.$month.'-'.$day;
                $indexdata = $year . $month . $day;
                try {
                    $anData[] = random_int(20, 60);
                } catch (Exception $e) {
                }
            }
        }
    }
    return $anData;
}

$anData = generateARIMAData();

#print_r($anData);

/*
$anYear1 = array();
$anYear2 = array();
$nStop = 10;
for ($i = 1; $i <= 12; $i++) {
    $anYear1[$i] = rand(100, 400);
    if ($i <= $nStop) {
        $anYear2[$i + 12] = rand(200, 600);
    }
}
#print_r($anYear1);
#print_r($anYear2);

$anData = array_merge($anYear1, $anYear2);
print_r($anData);*/
#echo "<br>-------------------" . PHP_EOL;
#print_r(array_keys($anData)[count($anData) - 1]);
#echo "<br>-------------------" . PHP_EOL;
#print_r(array_values($anData)[count($anData) - 1]);
//echo "forecastHoltWinters".PHP_EOL;
//print_r(forecastHoltWinters($anData));
//echo "-------------------".PHP_EOL;
//echo "holt_winters".PHP_EOL;
echo "-------------------" . PHP_EOL;
#print_r(holt_winters($anData, $season_length = 1, $alpha = 0.2, $beta = 0.01, $gamma = 0.01, $dev_gamma = 0.1));
#list($newdata, $deviations) = holt_winters($anData,  $season_length = 2, $alpha = 0.2, $beta = 0.01, $gamma = 0.01, $dev_gamma = 0.1);
list($newdata, $deviations) = holt_winters($anData);

$deviationInt = 3;

echo "<br/>New data<br/>";
echo "<textarea cols=95 rows=6>";
// Echo it out in a format to paste into to the charts JS
foreach ($newdata as $key => $d) {
    $x[] = 1; // $key;
    $y[] = $d;
    $y2[] = ($d + $deviationInt * $deviations[$key]);
    $y3[] = ($d - $deviationInt * $deviations[$key]);
    echo "data.addRow([" .
        $key . ", " .
        (isset($data[$key]) ? $data[$key] : 0) . ", " .
        $d . ", " .
        ($d + $deviationInt * $deviations[$key]) . ", " .
        ($d - $deviationInt * $deviations[$key]) . ", " .
        "]);\n";
}
echo "</textarea>";

echo "<br/>Deviations<br/>";
echo "<textarea cols=95 rows=6>";
foreach ($deviations as $key => $d) {
    $dev_x[] = 1; // $key;
    $dev_y[] = $d;
    $dev_y2[] = ($d + $deviationInt * $deviations[$key]);
    $dev_y3[] = ($d - $deviationInt * $deviations[$key]);

    echo "data.addRow([" .
        $key . ", " .
        (isset($data[$key]) ? $data[$key] : 0) . ", " .
        $d . ", " .
        ($d + $deviationInt * $deviations[$key]) . ", " .
        ($d - $deviationInt * $deviations[$key]) . ", " .
        "]);\n";
}
echo "</textarea>";

echo "<br>";


$plt = new php_plotlib();
$plt->width($width = 6.4);
$plt->height($height = 1.8);
//$plt->plot( [1, 1.5, 2, 1.8, 3] );
//$plt->plot( [2, 2.8, 1.7, 2, 2.3] );
#$plt->plot($x);
$plt->plot($y);
$plt->plot($y2);
$plt->plot($y3);
$plt->title("newdata Line");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '">';


$plt = new php_plotlib();
$plt->width($width = 6.4);
$plt->height($height = 1.8);
//$plt->plot( [1, 1.5, 2, 1.8, 3] );
//$plt->plot( [2, 2.8, 1.7, 2, 2.3] );
#$plt->plot($dev_x);
$plt->plot($dev_y);
$plt->plot($dev_y2);
$plt->plot($dev_y3);
$plt->title("Deviations Line");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '">';

/*
$graph = new graph();
$graph->width( $width = 6.4 );
$graph->height( $height = 1.8 );
$graph->plot( [4, 5, 6, 7], [1, 4, 9, 16], ['marker' => 'x'] );
$graph->plot( [4, 5, 6, 7], [5, 8, 7, 10], ['marker' => 'o'] );
$graph->axes([2, 9, 0, 20]);
$graph->title( 'Lines & Legend with "x" & "o" markers' );
$graph->legend( );
echo '<img src="'.$graph->output_gd_png_base64( ).'" >';
*/