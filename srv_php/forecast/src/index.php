<?php

$files = scandir('.');
foreach ($files as $file){
    if(preg_match('~test~',$file)){
        $menu[] = $file;
    }
}
//print_r($menu );

foreach ($menu as $menuitem){
    echo "<a href='".$menuitem."'>".$menuitem." </a><br>";
}
