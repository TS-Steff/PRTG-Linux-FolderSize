# PRTG-Duplicati
Script to push folder sizes from a Linux system to a PRTG HTTP Push Data Advanced Sensor.

## Situation
If you use Windows to get the folder size of a Linux based system, it calculates hardlinks as full file. There for it does not get the real folder size.

*Example*
Folder AA does contain two files. Each has a size of 100MB
Folder BB does contain one file with 100MB and two hard links to the files in folder AA.
- If you use Windows to get the size of folder BB the result will be 300MB.
- If you check the same folder on Linux it will tell you 100MB.

If you monitor the folder size with the PRTG Folder sensor, it will get 300MB. To solve this problem, we decided to create this bash script.


## Description
This script gets the folder sizes from an array and pushes the result to a PRTG HTTP Push Data Advanced Sensor.

![PRTG Screenshot](/Screenshots/prtg.PNG?raw=true "PRTG Screenshot")


## Config
You have to edit five variables
| Variable     | Value                                        | Comment                                               |
| ------------ | -------------------------------------------- | ----------------------------------------------------- |
| prtghost     | http://IPorHOSTNAME:5050                     | currently only http                                   |
| identtoken   | Sensor Identification Token                  | You'll find this in the sensors settings page         |
| basePath     | /share                                       | the base path where the folders are *no ending slash* |
| fldToCheck   | "TestA" "TestB"                              | folders to get size of, separated by SPACE            |
| dispSize     | Byte, KiloByte, MegaByte, GigaByte, TeraByte | How the result will be displayed                      |