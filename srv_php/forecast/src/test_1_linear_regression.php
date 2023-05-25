<?php

declare(strict_types=1);
#exit("-----");
error_reporting(E_ERROR);
ini_set('display_errors', 'On');
require_once('php-libplot.class.php');

/*
 * Simple linear regression  x,y
 *
 *
 * https://stackoverflow.com/questions/4563539/how-do-i-improve-this-linear-regression-function
https://halfelf.org/2017/linear-regressions-php/
https://en.wikipedia.org/wiki/Simple_linear_regression
https://richardathome.wordpress.com/2006/01/25/a-php-linear-regression-function/
https://accidentalfactors.com/linear-regression-in-php/
https://mnshankar.wordpress.com/2011/05/01/regression-analysis-using-php/
https://dev.to/thormeier/algorithm-explained-linear-regression-using-gradient-descent-with-php-1ic0
*/

/**
 * linear regression function
 * @param $x array x-coords
 * @param $y array y-coords
 * @returns array() m=>slope, b=>intercept
 */
function linear_regression($x, $y)
{
    // calculate number points
    $n = count($x);
    // ensure both arrays of points are the same size
    if ($n !== count($y)) {
        trigger_error("linear_regression(): Number of elements in coordinate arrays do not match.", E_USER_ERROR);
    }
    // calculate sums
    $x_sum = array_sum($x);
    $y_sum = array_sum($y);
    $xx_sum = 0;
    $xy_sum = 0;
    for ($i = 0; $i < $n; $i++) {
        $xy_sum += ($x[$i] * $y[$i]);
        $xx_sum += ($x[$i] * $x[$i]);
    }
    // calculate slope
    $m = (($n * $xy_sum) - ($x_sum * $y_sum)) / (($n * $xx_sum) - ($x_sum * $x_sum));
    // calculate intercept
    $b = ($y_sum - ($m * $x_sum)) / $n;
    // return result
    return array("slope" => $m, "intercept" => $b);
}

foreach (range(0, 56) as $number) {
    try {
        $datax[] = random_int(10, 29);
        $datay[] = random_int(10, 29);
    } catch (Exception $e) {
    }
}

$data = [17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16, 17, 19, 26, 12, 18, 20, 15, 22, 17, 21, 16];
$datax = array_keys($data);
$datay = array_values($data);

$arLn2 = linear_regression($datax, $datay);
var_dump($arLn2);
# Array ( [slope] => 0.04373298327499 [intercept] => 18.245283936212 )

$plt = new php_plotlib();
$plt->width($width = 7.4);
$plt->height($height = 1.8);
$plt->plot($datax); # orange
$plt->plot($datay); # orange
$plt->title("  ");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';
echo "<hr/>";