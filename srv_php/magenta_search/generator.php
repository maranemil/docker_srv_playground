<?php

// Include the main TCPDF library (search for installation path).
#require_once('tcpdf_include.php');
require_once("vendor/autoload.php");

#print_r($argv);
$infile = $argv[1];
$hex = '#'.str_replace(array('whatever_','.png'),'',$infile);
echo $hex. PHP_EOL;

list($r, $g, $b) = sscanf($hex, "#%02x%02x%02x");
echo  $codecolor = "$hex -> $r $g $b". PHP_EOL;

#$filecolor = "filecolor.log";
#file_put_contents($filecolor, $codecolor, FILE_APPEND | LOCK_EX);

// create new PDF document
$pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);

// set document information
$pdf->SetCreator(PDF_CREATOR);
$pdf->SetAuthor('Nicola Asuni');
$pdf->SetTitle('TCPDF Example 058');
$pdf->SetSubject('TCPDF Tutorial');
$pdf->SetKeywords('TCPDF, PDF, example, test, guide');
$pdf->SetFont('helvetica', '', 10);

// set default header data
#$pdf->SetHeaderData(PDF_HEADER_LOGO, PDF_HEADER_LOGO_WIDTH, PDF_HEADER_TITLE.' 058', PDF_HEADER_STRING);

// set header and footer fonts
#$pdf->setHeaderFont(Array(PDF_FONT_NAME_MAIN, '', PDF_FONT_SIZE_MAIN));
#$pdf->setFooterFont(Array(PDF_FONT_NAME_DATA, '', PDF_FONT_SIZE_DATA));

// set default monospaced font
$pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
$pdf->SetMargins(0, PDF_MARGIN_TOP, 0);

// set margins
$pdf->SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_TOP, PDF_MARGIN_RIGHT);
$pdf->SetHeaderMargin(PDF_MARGIN_HEADER);
$pdf->SetFooterMargin(PDF_MARGIN_FOOTER);
$pdf->setPrintHeader(false);
$pdf->setPrintFooter(false);

// set auto page breaks
#$pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);
$pdf->SetAutoPageBreak(false);
$pdf->SetDisplayMode(
    'default' // options: fullwidth fullpage real real default
    //'SinglePage', // options:  SinglePage OneColumn
    //'UseNone' // options:  UseThumbs UseNone
);

// set image scale factor
#$pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);
$pdf->setImageScale(1);
// ---------------------------------------------------------
// add a page
# https://tcpdf.org/examples/example_028/
$pdf->AddPage('P', 'A5');
#$pdf->AddPage('P');
// set default font subsetting mode
$pdf->setFontSubsetting(false);
// set font

#$pdf->ImageSVG($file='colors/whatever_f0dc00-0.svg', $x=30, $y=100, $w='', $h=100, $link='', $align='', $palign='', $border=0, $fitonpage=false);
/*$pdf->Image(__DIR__."/colors/{$infile}", 115, 110, 75, 113, 'PNG',
 'http://www.tcpdf.org', '', true, 150, '', false, false, 0, true, false, false);*/


 // define style for border
$border_style = array('all' => array('width' => 0, 'cap' => 'square',
 'join' => 'miter', 'dash' => 0, 'phase' => 0));
 // --- CMYK ------------------------------------------------
/*$pdf->SetDrawColor(50, 0, 0, 0);
$pdf->SetFillColor(100, 0, 0, 0);
$pdf->SetTextColor(100, 0, 0, 0);
$pdf->Rect(30, 60, 30, 30, 'DF', $border_style);
$pdf->Text(30, 92, 'Cyan');*/

$border_style = array('all' => array('width' => 0, 'cap' => 'square', 'join' => 'miter', 'dash' => 0, 'phase' => 0));
$pdf->SetDrawColor(0, 255, 0, 0);
$pdf->SetFillColor(0, 255, 0, 0);
$pdf->SetTextColor(0, 255, 0, 0);
$pdf->Rect(0, 0,$pdf->getPageWidth() + 42.5, $pdf->getPageHeight() + 46.1, 'DF', $border_style);
$pdf->Text(70, 92, 'Magenta');


 // --- RGB -------------------------------------------------
#$pdf->SetDrawColor(255, 127, 127);
#$pdf->SetFont('times', 'BI', 12);
#$pdf->SetFont('times', 'BI', 20);
$pdf->SetDrawColor($r, $g, $b);
$pdf->SetFillColor($r, $g, $b);
$pdf->SetTextColor($r, $g, $b);
$pdf->Rect(30, 110, 30, 30, 'DF', $border_style);
$pdf->Text(12, 142, $hex . ' hex / rgb ' . $r.'.'.$g.'.'.$b);



$svg_string = '<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   height="465.25296pt"
   viewBox="0 0 348.093 465.25297"
   version="1.1"
   width="348.09299pt"
   id="svg41"
   sodipodi:docname="page001.svg"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:svg="http://www.w3.org/2000/svg">
  <sodipodi:namedview
     id="namedview43"
     pagecolor="#ffffff"
     bordercolor="#000000"
     borderopacity="1.0"
     inkscape:showpageshadow="2"
     inkscape:pageopacity="0.0"
     inkscape:pagecheckerboard="0"
     inkscape:deskcolor="#d1d1d1"
     inkscape:document-units="pt"
     showgrid="false" />
  <defs id="defs2" />
  <g
     inkscape:label="Background"
     id="Background"
     inkscape:groupmode="layer"
     transform="translate(-0.20000001,-0.197)">
    <path
         transform="translate(60.8613,60.858)"
         style="fill:rgb('.$r.','.$g.','.$b.');fill-rule:nonzero;stroke:none"
         d="m 0,0 v 46.724 h 131.242 l 95.451,-0.22 0.097,-29.852 V 0 Z"
        id="path4" />
  </g>
</svg>';

$svg_file ='svgfilesphp/'. $r.$g.$b.'.svg';
file_put_contents($svg_file,$svg_string);
#exit;


$pdf->ImageSvg(
    $file = $svg_file,
    $x=30, 
    $y=100,
     $w='',
     $h=100,
    $link = '',
    $align = 'TL',
    $palign = 'TL',
    $border = 0,
    $fitonpage = false
);


//Close and output PDF document
$pdf->Output(__DIR__."/colorspdf/{$infile}.pdf", 'F');