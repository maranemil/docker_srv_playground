# gs -o svgtet/test.pdf -sDEVICE=pdfwrite -dProcessColorModel=/DeviceCMYK -dColorConversionStrategy=/CMYK -f svgtet/test.svg
# gs -o svgtet/test.pdf -sDEVICE=pdfwrite -dProcessColorModel=/DeviceCMYK -dColorConversionStrategy=/CMYK -f svgtet/circle.png

# for i in colorspdfcmyk/*.*; do identify  $i | grep -in --color 'rgb\|cmyk'; done
# convert -size 100x100 xc:#990000 whatever.png

# https://ghostscript.com/docs/9.54.0/VectorDevices.htm
# https://gist.github.com/guifromrio/6390547
# https://gist.github.com/rbnvrw/a047887fbc0a9da808826ac74fb749bc
# -dPDFSETTINGS /screen /ebook /printer /prepress

wc -l < hexcolor.txt
sleep 5 
#exit

# generate tcpdfs
rm colorspdf/*
echo "------bash read csv------------------"
while IFS=, read -r field1 
do
    echo "$field1"
     php generator.php whatever_$field1.png
     sleep 0.1
done < hexcolor.txt
echo "------bash read csv------------------"
#for i in colors/*.*; do php generator.php $(basename $i); done

#for i in colors/*.*; do convert $i colorspdf/$(basename $i).pdf && sleep 1; done
# ls colors | head



# generate cmyk pdfs
rm colorspdfcmyk/*

#for i in colorspdf/*.*; do convert $i -density 72 \
#    -profile /usr/share/color/icc/ghostscript/default_cmyk.icc -colorspace cmyk colorspdfcmyk/$(basename $i); done

for i in colorspdf/*.*; do  gs -o colorspdfcmyk/$(basename $i) \
   -dCompatibilityLevel=1.4 -r50 -dPDFSETTINGS=/screen  \
    -dSubSetfonts=false -dCompressFonts=false  \
   -dNOPAUSE -dBATCH -dSAFER  -dFirstPage=1 -dLastPage=1 \
  -sDEVICE=pdfwrite -dProcessColorModel=/DeviceCMYK -dColorConversionStrategy=/CMYK -f $i  && sleep 0.1; done

# -dQUIET -dDetectDuplicateImages -dPDFSTOPONERROR -dEmbedAllFonts=false
# identify -verbose colorspdfcmyk/whatever_000000-0.png.pdf | grep -in --color 'cmyk(0,0,0,38)'
# identify -verbose colorspdfcmyk/whatever_000000-0.png.pdf | grep -in --color 'cmyk(100,76,0,38)'

#for i in colorspdfcmyk/*.*; do identify -verbose $i | grep -in --color 'cmyk(100,76,0,38)'; done
#for i in colorspdfcmyk/*.*; do identify -verbose $i | grep -in --color 'cmyk(100,76\|Filename:' >> logcmyk.log; done
#for i in colorspdfcmyk/*.*; do identify -verbose $i | grep -in --color 'cmyk(100|Filename:' >> logcmyk.log; done


rm tiffs/*
for i in colorspdfcmyk/*.*; \
  do gs -q -dNOPAUSE -r50 -dPDFSETTINGS=/screen -dCompatibilityLevel=1.4 \
   -sOutputFile=tiffs/$(basename $i).tiff -sDEVICE=tiff32nc $i -c quit && sleep 0.1; done 


# sDEVICE=tiff24nc RBG
# sDEVICE=tiff32nc CMYK

echo "done!-----------------"

#for i in colorspdfcmyk/*.*; do identify -verbose $i | grep -in --color 'cmyk(\|filename' >> logcmyk.log; done

#echo "----------------------search string--------------------------"
#grep -w "cmyk(100,76" logcmyk.log 
#grep -w "cmyk(100" logcmyk.log 
#echo "----------------------   end search--------------------------"
