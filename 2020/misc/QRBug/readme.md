# [HackSécuReims] Write-Up - QRBug (Misc, 200)

## Description :
Jean devait automatiser la génération de QRCode, mais il semblerait qu'un bug de l33t dans son code à mélanger son flag ...


## QRBug :

Nous avons un fichier [hsr_qrbug.png](files/hsr_qrbug.png) qui semble correspondre à une mosaïque de QRCode.

Nous allons dans un premier temps essayer de découper l'ensemble des QRCodes avant de les lire ensuite. Dans un premier temps, on constate que l'image fait en dimension 8700x8700 et très vite on constate qu'un QRCode a une dimension de 87x87.
```Bash
#!/bin/bash
IMAGE="hsr_qrbug.png"
OUTPUT="result.txt"

convert $IMAGE -crop 87x87 output/qrcode%03d.png
for a in $(ls output/*); do zbarimg $a >> $OUTPUT 2>&1; done 
```

Le fichier en sortie [output.txt](files/output.txt) nous montre que tous les QRCodes commencent par la pattern HSR{...}

Donc on ne peut pas faire de grep simplement dessus sauf à se rappeler que dans la description du challenge il est fait rappel à la notion de **l33t**

En partant sur l'hypothèse que dans le flag apparaisse le mot "qrcode" ou "qrbug" écrit en langage l33t :

```Bash
cat result.txt |grep "[Q|q][R|r][C|c][O|o|0][D|d][E|e|3]"
QR-Code:HSR{Ch@lls_w1th_Qrc0d3_1s_4lw4yS_FUnny?}
```

Le flag est : **HSR{Ch@lls_w1th_Qrc0d3_1s_4lw4yS_FUnny?}**
