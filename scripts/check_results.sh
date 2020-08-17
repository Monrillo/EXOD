#!/bin/bash

################################################################################
#                                                                              #
# EXOD-v2 - EPIC XMM-Newton Outburst Detector                                  #
#                                                                              #
# Check if a variability source has been found                                 #
#                                                                              #
# Florent Castellani  (2020) -  castellani.flo@gmail.com                       #
#                                                                              #
################################################################################

DATA=/mnt/data/Florent/data
FOLDER=/mnt/data/Florent/results
output_log=/home/florent/results.log
output_file=/home/florent/triple_lightcurves.pdf

cd $FOLDER
observations=(0*)
nb_img=${#observations[@]}
echo $nb_img
files=()

for obs in ${observations[@]}; do

# Initialise
inst=''
testPN=''
testM1=''
testM2=''
triple=''
submode=''
numtrip=0

# Testing submode
if [ -f $DATA/$obs/PN_clean.fits ] ; then
  modePN=$(hexdump -e '80/1 "%_p" "\n"' $DATA/$obs/PN_clean.fits | grep -m 1 SUBMODE | awk '{print $3}' | tr -d '[a-z]')
else
  modePN='NoPNdata'
fi
if [ -f $DATA/$obs/M1_clean.fits ] ; then
  modeM1=$(hexdump -e '80/1 "%_p" "\n"' $DATA/$obs/M1_clean.fits | grep -m 1 SUBMODE | awk '{print $3}' | tr -d '[a-z]')
else
  modeM1='NoM1data'
fi
if [ -f $DATA/$obs/M2_clean.fits ] ; then
  modeM2=$(hexdump -e '80/1 "%_p" "\n"' $DATA/$obs/M2_clean.fits | grep -m 1 SUBMODE | awk '{print $3}' | tr -d '[a-z]')
else
  modeM2='NoM2data'
fi

submode="$submode\t$modePN\t$modeM1\t$modeM2"

# Testing if the variability has been done for each EPIC instrument
if [ -f $FOLDER/$obs/8_100_5_1.0_PN/ds9_variable_sources.reg ] ; then
    testPN=$(cat $FOLDER/$obs/8_100_5_1.0_PN/ds9_variable_sources.reg | grep 'text="'1'"' | awk '{print $1}')
else
    inst="$inst\tPN(Pb!)"
fi

if [ -f $FOLDER/$obs/8_100_5_1.0_M1/ds9_variable_sources.reg ] ; then
    testM1=$(cat $FOLDER/$obs/8_100_5_1.0_M1/ds9_variable_sources.reg | grep 'text="'1'"' | awk '{print $1}')
else
    inst="$inst\tM1(Pb!)"
fi

if [ -f $FOLDER/$obs/8_100_5_1.0_M2/ds9_variable_sources.reg ] ; then
    testM2=$(cat $FOLDER/$obs/8_100_5_1.0_M2/ds9_variable_sources.reg | grep 'text="'1'"' | awk '{print $1}')
else
    inst="$inst\tM2(Pb!)"
fi

# Testing if at least one variable source has been found for each EPIC instrument
if [[ "$testPN" == 'circle' ]]; then
numPN=$(cat $FOLDER/$obs/8_100_5_1.0_PN/ds9_variable_sources.reg | grep 'text=' | awk '{print $1}' | wc -l)
inst="$inst\tPN=${numPN}"
fi
if [[ "$testM1" == 'circle' ]]; then
numM1=$(cat $FOLDER/$obs/8_100_5_1.0_M1/ds9_variable_sources.reg | grep 'text=' | awk '{print $1}' | wc -l)
inst="$inst\tM1=${numM1}"
fi
if [[ "$testM2" == 'circle' ]]; then
numM2=$(cat $FOLDER/$obs/8_100_5_1.0_M2/ds9_variable_sources.reg | grep 'text=' | awk '{print $1}' | wc -l)
inst="$inst\tM2=${numM2}"
fi

# Testing if triple correlation variability files and lightcurves
if [ -f $FOLDER/$obs/variability_8_100_5_1.0_all_inst.pdf ] ; then
triple="$triple\tvar_all_inst"
fi

if [ -f $FOLDER/$obs/triple_correlation.txt ] ; then
triple="$triple\ttriple_lc"

# Adding files to big PDF only if lightcurves have been extracted
numtrip=$(ls -l $FOLDER/$obs/triple*.pdf | wc -l)
if [ $numtrip -gt 0 ] ; then
files+=($FOLDER/$obs/triple*.pdf)
fi
fi

# Printing results
echo -e "$obs $submode $inst $triple"

# Results are written in a log file
echo -e >> $output_log "$obs $submode $inst $triple"

done

# Creation of big PDF with all triple correlation lightcurves

#echo ${files[@]}

gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=$output_file ${files[@]}

echo -e "Triple correlation file : $output_file"







