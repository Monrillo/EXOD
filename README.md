# EXOD
## EPIC-pn XMM-Newton Outburst Detector

The aim of this project is to provide a tool to spot variable sources in EPIC-pn XMM-Newton observations.
This is done by computing the variability of each pixel of the detector instead of generating lightcurves of individual sources. It allows to find faint transients for which the lightcurves are not generated by XMM-Newton's pipeline since they are too faint.

We encourage the potential users to read the users guide (EXOD_users_guide.pdf), and especially follow the tutorial presented in section 6.

If you use EXOD for your research, please acknowledge it by citing Pastor-Marazuela, Webb and Wojtowicz (in prep).

Original project "Variabilitectron" created by Damien Wojtowicz. See previous versions:
https://framagit.org/DWojtowicz/Variabilitectron
https://framagit.org/InesPM/Variabilitectron

## Tutorial

Let's set the path to where the scripts are located and where we want to store our data, for instance

```
SCRIPTS=/path/EXOD
FOLDER=/path/data
```

One can use the `exod_analysis.sh` script to download, filter and compute the variability with four sets of parameters. Let's try, for instance, with observation 0652250701:

```
obs=0124710801
bash $SCRIPTS/exod_analysis.sh -o $obs -f $FOLDER -s $SCRIPTS
```
The whole process should ta

The output of `ls $FOLDER/$obs` should be then the following:

```
0184_0124710801_SCX00000SUM.ASC  P0124710801PNS001PIEVLI.FTZ
5_3_3_1.0                        PN_clean.fits
6_10_3_1.0                       PN_gti.fits
7_30_3_1.0                       PN_image.fits
8_100_3_1.0                      PN_processing.log
ccf.cif                          PN_rate.fits
P0124710801PNS001FBKTSR0000.FTZ  variability_whole.pdf
```
The folders 5_3_3_1.0, 6_10_3_1.0, 7_30_3_1.0, 8_100_3_1.0 contain the variability files computed with parameters goven in the name of the directory (detection-level_time-window_box-size_good-time-ratio).
variability_whole.pdf shows the variability computed with the four sets of parameters.
