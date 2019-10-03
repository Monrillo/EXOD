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
The whole process should take a few minutes, and it depends on the duration of the observation.
An example of the output of these commands can be found in the folder `examples`.

![variability](../master/example/variability_whole.png)
