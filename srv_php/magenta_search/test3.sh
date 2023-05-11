mkdir -p colors
mkdir -p colorspdf
mkdir -p colorspdfcmyk
mkdir -p svgfilesphp
mkdir -p tiffs

wc -l < hexcolor.txt
sleep 1
#exit

rm colorspdf/*
echo "------bash read csv------------------"
while IFS=, read -r field1
do
    echo "$field1"
     php generator.php whatever_$field1.png
     sleep 0.1
done < hexcolor.txt
echo "------bash read csv------------------"


# generate cmyk pdfs
rm colorspdfcmyk/*
for i in colorspdf/*.*; do  gs -o colorspdfcmyk/$(basename $i) \
   -dCompatibilityLevel=1.4 -r50 -dPDFSETTINGS=/screen  \
    -dSubSetfonts=false -dCompressFonts=false  \
   -dNOPAUSE -dBATCH -dSAFER  -dFirstPage=1 -dLastPage=1 \
  -sDEVICE=pdfwrite -dProcessColorModel=/DeviceCMYK -dColorConversionStrategy=/CMYK -f $i  && sleep 0.1; done


rm tiffs/*
for i in colorspdfcmyk/*.*; \
  do gs -q -dNOPAUSE -r50 -dPDFSETTINGS=/screen -dCompatibilityLevel=1.4 \
   -sOutputFile=tiffs/$(basename $i).tiff -sDEVICE=tiff32nc $i -c quit && sleep 0.1; done

# sDEVICE=tiff24nc RBG
# sDEVICE=tiff32nc CMYK

echo "done!-----------------"
