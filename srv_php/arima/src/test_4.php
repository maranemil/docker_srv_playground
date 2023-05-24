<style>
    body {
        background-color: #ffeeff;
    }
</style>
<?php

// https://www.listendata.com/2015/08/time-series-forecasting-arima-part-1.html

error_reporting(E_ERROR);
ini_set('display_errors', 'On');

require_once('php-libplot.class.php');

function show_array_as_table(
    $array,
    $key_color = 'black',
    $value_color = "black",
    $fontfamily = "arial",
    $fontsize = "9pt"
) {
    foreach ($array as $key => $value) {
        if (is_array($value)) {
            echo "<tr>";
            echo "<td title=\"{$key}\" style='width:100pt; border-bottom: 1px solid ;height:15pt; text-align:left; vertical-align:top; background-color:#cccccc; color:{$key_color}'><b>{$key}</b></td>";
            show_array_as_table($value, $key_color, $value_color, $fontfamily, $fontsize);
            echo "</tr>";
        } else {
            echo "<td style='width:50pt; border-bottom: 1px solid ; height:15pt; text-align:justify; vertical-align:top; color:{$value_color}'>";
            echo "<i>{$value}</i>";
            echo "</td>";
        }
    }
}

function generateARIMAData()
{
    $years = range(2022, 2022);
    $months = range(1, 1);
    $days = range(1, 15);

    $anData = [];
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

const RANDOM_DATA = 0;
if (RANDOM_DATA) {
    $data = generateARIMAData();
} else {
    $str = '1,100
2,103
3,98
4,116
5,120
6,100
7,130
8,133
9,104
10,137
11,143
12,105
';

//print "<pre>";

    $dataTmp = preg_split('/\r\n|[\r\n]/', $str);
    foreach ($dataTmp as $dataLine) {
        if (!empty(trim($dataLine))) {
            $arr_tmp = explode(",", $dataLine);
            [$key, $value] = $arr_tmp;
            $data[$key] = $value;
        }
    }
}


// get half
#$data = array_chunk($data, 5)[0];
echo("arr count=" . count($data));

////////////////////////////////////////////////////
// Auto-regressive Component Lag
////////////////////////////////////////////////////

$arrLag = [];
foreach ($data as $month => $value) {
    $arrLag[$month] = array("sales" => $value);
    // set LAG
    $arrLag[$month]['lag'] = $arrLag[$month - 1]["sales"] ?? '0';
    $arrLag[$month]['lag2'] = $arrLag[$month - 2]["sales"] ?? '0';
}

echo "<br/>Auto-regressive Component Lagged [y,lagger1,lagged2] <table class='table table-border'>";
show_array_as_table($arrLag);
#show_array_as_table(array_chunk($arrLag,8)[1]);
echo "</table>";

function simpleExponentialSmoothing($demands)
{
    # New forecast=(alpha)(Current demand) + (1-alpha)(Last Forecast)
    $alpha = 0.2;
    $initial_demand = array_shift($demands); // To start the reduction process off
    return array_reduce($demands, static function ($last_forecast, $current_demand) use ($alpha) {
        return $alpha * $current_demand + (1 - $alpha) * $last_forecast;
    }, $initial_demand);
}

function getFutureLag($arrLag, $data): array
{
    $arrLagTMP = array_slice($arrLag, -1);
    $monthInt = 0;
    $arrLagFT = [];
    foreach ($arrLagTMP as $month => $value) {
        $arrLagFT[$monthInt]['sales'] = round(number_format(simpleExponentialSmoothing($data), 2));
        // set LAG
        $arrLagFT[$monthInt]['lag'] = $value["sales"];
        $arrLagFT[$monthInt]['lag2'] = $value["lag"] ?? 0;
    }
    return $arrLagFT;
}

//print_r($arrLag);
$arrLagFuture = getFutureLag($arrLag, $data);
echo "<br/>LAG Prediction<table class='table table-border'>";
show_array_as_table($arrLagFuture);
echo "</table>";

$arrLag = array_merge_recursive($arrLag, $arrLagFuture);

$plt = new php_plotlib();
$plt->width($width = 6.4);
$plt->height($height = 1.3);
//$plt->plot( [1, 1.5, 2, 1.8, 3] );
$plt->plot(array_column($arrLag, "sales"));
$plt->plot(array_column($arrLag, 'lag'));
$plt->plot(array_column($arrLag, 'lag2'));
$plt->title("Lag Line");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';
echo "<hr/>";

////////////////////////////////////////////////////
// Moving average component
////////////////////////////////////////////////////

$arrMA = [];
foreach ($data as $month => $value) {
    $arrMA[$month] = array("sales" => $value);
    // set MA
    $prev_month = $arrLag[$month - 1]["sales"] ?? $arrLag[$month]["sales"];
    $prev_month2 = $arrLag[$month - 2]["sales"] ?? $arrLag[$month]["sales"];
    $avg_arr = [$arrLag[$month]["sales"], $prev_month];
    $avg_arr2 = [$arrLag[$month]["sales"], $prev_month2, $prev_month];
    $arrMA[$month]['ma'] = round(array_sum($avg_arr) / count($avg_arr), 2) ?? '0';
    $arrMA[$month]['ma2'] = round(array_sum($avg_arr2) / count($avg_arr2), 2) ?? '0';
}

echo "<br/>Auto-regressive Component Moving Average [y,ma1,ma2]<table class='table table-border'>";
show_array_as_table($arrMA);
#show_array_as_table(array_chunk($arrMA,8)[1]);
echo "</table>";

function getFutureMA($arrMA, $data): array
{
    $arrLagTMP = array_slice($arrMA, -1);
    $monthInt = 0;
    $arrLagFT = [];
    foreach ($arrLagTMP as $month => $value) {
        $arrLagFT[$monthInt]['sales'] = number_format(simpleExponentialSmoothing($data), 2);
        // set LAG
        $arrLagFT[$monthInt]['ma'] = $arrLagTMP[$month]["sales"];
        $arrLagFT[$monthInt]['ma2'] = $arrLagTMP[$month]["ma"] ?? 0;
    }
    return $arrLagFT;
}

$arrMAFuture = getFutureMA($arrMA, $data);
echo "<br/>MA Prediction<table class='table table-border'>";
show_array_as_table($arrMAFuture);
echo "</table>";

$arrMA = array_merge_recursive($arrMA, $arrMAFuture);

$plt = new php_plotlib();
$plt->width($width = 6.4);
$plt->height($height = 1.3);
$plt->plot(array_column($arrMA, "sales"));
$plt->plot(array_column($arrMA, 'ma'));
$plt->plot(array_column($arrMA, 'ma2'));
$plt->title("Moving Average Line");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';

////////////////////////////////////////////////////
// Naive Forecast component
////////////////////////////////////////////////////
echo "<hr>";
foreach ($data as $key => $value) {
    echo $key;
    if ($key > 0 && !empty($value) && !empty($data[$key - 1])) {
        $naive = $value / $data[$key - 1] - 1;
        $naive = round($naive, 2);
    } else {
        $naive = 0;
    }
    $demandsn[] = [
        'value' => $value,
        'naive' => $data[$key - 1] ?? 0,
        'diff' => $naive,
    ];
}

echo "<br/>Naive Forecast = (t2 / t1) - 1 - y,naive,diff<table class='table table-border'>";
show_array_as_table($demandsn);
echo "</table>";

function getFutureNaive($demandsn, $data): array
{
    $arrNaiveTMP = array_slice($demandsn, -1);
    $diff = round(1 / $arrNaiveTMP[0]['value'] - 1, 2);
    return array(
        '0' => [
            'value' => 0,
            'naive' => $arrNaiveTMP[0]['value'],
            'diff' => $diff,
        ]
    );
}

$arrNaiveTMP = getFutureNaive($demandsn, $data);
echo "<br/>Naive Forecast Prediction<table class='table table-border'>";
show_array_as_table($arrNaiveTMP);
echo "</table>";

$demandsn = array_merge($demandsn, $arrNaiveTMP);

$plt = new php_plotlib();
$plt->width($width = 6.4);
$plt->height($height = 1.3);
$plt->plot(array_column($demandsn, "value")); # blue
$plt->plot(array_column($demandsn, 'naive')); # orange
$plt->plot(array_column($demandsn, 'diff')); # green
$plt->title("Naive");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';

////////////////////////////////////////////////////
// Autoregressive model AR
////////////////////////////////////////////////////

// https://www.php.net/manual/en/function.range.php
echo "<hr>";
echo "<pre>";
foreach (range(0, 6) as $number) {
    try {
        $data_ma[] = random_int(2, 17);
    } catch (Exception $e) {
    }
}
$data_ma = $data;
$alpha = 0.3;
function MA($value, $alpha, $err): float
{
    return round($alpha + $value + $err, 2);
}

foreach ($data_ma as $key => $value) {
    if ($key === 0) {
        #$arrMAA[$key] = array("value" => $value, "err" => $alpha - $value);
        $arrMAA[$key] = array("value" => $value, "err" => $alpha );
        $arrMAA[$key]["AR"] = 0;
    } else {
        $arrMAA[$key] = array("value" => $value);
        $arrMAA[$key]["AR"] = MA($arrMAA[$key - 1]["value"], $alpha, $arrMAA[$key - 1]["err"]);
        $arrMAA[$key]["err"] = $arrMAA[$key]["AR"] - $value;
    }
}

echo "<br/> Autoregressive model AR - alpha 0.3 [y,AR,err]<table class='table table-border'>";
show_array_as_table($arrMAA);
echo "</table>";

$plt = new php_plotlib();
$plt->width($width = 6.4);
$plt->height($height = 1.3);
$plt->plot(array_column($arrMAA, "value")); # blue
$plt->plot(array_column($arrMAA, 'AR')); # orange
$plt->plot(array_column($arrMAA, 'err')); # green
$plt->title("Autoregressive model AR");
echo '<br/><img src="' . $plt->output_gd_png_base64() . '" alt="">';

foreach(array_column($arrMAA, 'err') as $value){
    $arrSSE[] = $value^2;
}

//print_r($arrSSE);
echo "<br>SSE sum of the squared errors: ";
print_r(abs(array_sum($arrSSE)));
echo "<br>MSE mean of the squared errors: ";
print_r(abs(array_sum($arrSSE))/count($data));
// SSE = (err * pw) sum
// MSE SSE/data-length
