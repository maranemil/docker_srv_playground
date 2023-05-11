import random
import os 
import time

cmd = 'date'
print(os.system(cmd))
 
# Generating a random number in between 0 and 2^24
#color = random.randrange(0, 2**24)
#print(color)
 
# Converting that number from base-10
# (decimal) to base-16 (hexadecimal)
#hex_color = hex(color)[2:]
#print(hex_color)

def rgb_to_hex(rgb):
    return '%02x%02x%02x' % rgb
    
#hexcolor = rgb_to_hex((255, 255, 195))
#print(hexcolor)

#os.system('convert  -size 1240x1753  xc:#'+hexcolor+' colors/whatever_'+hexcolor+'.png') # -size 100x100
#os.system('convert  -size 100x100  xc:#'+hexcolor+' colors/whatever_'+hexcolor+'.png') # -size 100x100
 
os.system('rm colors/*')
os.system('rm colorspdf/*')
os.system('rm colorspdfcmyk/*')
os.system('rm svgfilesphp/*')
os.system('rm tiffs/*')
os.system('rm filecolor.log logcmyk.log')
os.system('rm hexcolor.txt')

# FF00FF - magenta RGB = (255, 0, 255)
# #6400c8 - 100,76,0,0
# 8min ~ 30 -50

rangelimitdwR = 200 # 0
rangelimitupR = 255 # 255
rangelimitdwG = 0 # 0
rangelimitupG = 1 # 255 60
rangelimitdwB = 200 # 0
rangelimitupB = 255 # 255 120
modulo = 10


for i in range(rangelimitdwR, rangelimitupR):
    for j in range(rangelimitdwG,rangelimitupG):
        for k in range(rangelimitdwB,rangelimitupB):
            if i % modulo == 0 and j % modulo == 0 and k % modulo == 0:
            #if i%100 == 0 and j%100 == 0 and k%100 == 0:
            #if i%150 == 0 and j%160 == 0 and k%190 == 0:
                hexcolor = rgb_to_hex((i, j, k))
                if hexcolor != 0:                    
                    print(hexcolor)
                    #os.system('convert -size 800x800  xc:#'+hexcolor+' -gravity center -fill #'+hexcolor+' -gravity center -draw "text 0,300 \'TEXT TO BE DISPLAYED\'" colors/whatever_'+hexcolor+'.png') # -size 100x100
                    #os.system('convert -size 100x100  xc:#'+hexcolor+' colors/whatever_'+hexcolor+'_box.jpg')

                    # genrate png file with hex color codes
                    #os.system('convert  -size 10x90  xc:#ffffff -alpha on \
                    #        -stroke "#'+hexcolor+'" -fill "#'+hexcolor+'" -draw "rectangle 20,10 10,50"   \
                    #    -stroke  \'#'+hexcolor+'\'   -fill white  -annotate 0,9 \'Faerie Dragon\' \
                    #    -stroke \'#'+hexcolor+'\'  -pointsize 60  -annotate 0,5 \'Faerie Dragon\' \
                    #    colors/whatever_'+hexcolor+'.png') 
                    
                    # -size 100x100 -strokewidth 2 -size x40            
                    # -gravity center colors/whatever_'+hexcolor+'_box.jpg \
                    #
                    # 
                    #   

                    # genrate txt file with hex color codes
                    f = open("hexcolor.txt", "a")
                    f.write(hexcolor + '\n')
                    f.close()

                    #time.sleep(0.1)
                    #os.system('rm colors/whatever_'+hexcolor+'_box.jpg')
                    #os.system('rm colors/whatever_'+hexcolor+'-1.png')
                    #os.system( 'inkscape --pipe  --export-type="svg" --batch-process --actions="" --export-overwrite colors/whatever_'+hexcolor+'-0.png') # --without-gui 
        #break
    #break


os.system('time bash test.sh')

# %150 - 12s - 8 files
# %100 - 41s - 27 files ghostscrpt
# %100 - 14s - 27 files imagick

# %50  - 5m - 216 files ghostscrpt
# %50  - 1m50s - 216 files imagick

# %30  - 18m - 729 files ghostscrpt
# %30  - 6m - 729 files imagick

# %20  - 19m - 2197 files imagick

# ls colors |  wc -l
# rm colors/*
# ls colors
# convert -list configure

# time python3 colors.py 
# php generator.php
# time bash test.sh
# bash test.sh
