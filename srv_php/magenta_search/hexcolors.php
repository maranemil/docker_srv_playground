<?php

exec('rm hexcolor.txt');
#exit();

$rangelimitdwR = 10; # 0
$rangelimitupR = 18; # 255
$rangelimitdwG = 60; # 0
$rangelimitupG = 66; # 255 60
$rangelimitdwB = 100; # 0
$rangelimitupB = 155; # 255 120
$modulo = 2;

$f = fopen("hexcolor.txt", "wb+");
foreach (range($rangelimitdwR, $rangelimitupR) as $i) {
    foreach (range($rangelimitdwG, $rangelimitupG) as $j) {
        foreach (range($rangelimitdwB, $rangelimitupB) as $k) {
            if ($i % $modulo === 0 && $j % $modulo === 0 && $k % $modulo === 0) {
                $hexcolor = sprintf("#%02x%02x%02x", $i, $j, $k);
                if (!empty($hexcolor)) {
                    print($hexcolor);
                }
                $hexcolor = str_replace("#",'',$hexcolor);
                fwrite($f, $hexcolor."\n" );
            }
        }
    }
}
fclose($f);

