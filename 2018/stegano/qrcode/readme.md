# [HackSécuReims] Write-Up - QRCode (Stega, 150)

## Description :
Check the color information.


## QRCode :

Nous avons QRCode en GIF ... il faut donc déjà récupérer l'ensemble des frames qui composent ce GIF

Pour celà, nous utiliserons l'outil convert de la suite [Imagick](https://www.imagemagick.org/script/convert.php)

```BASH
convert secret_1ff152660f5898d8a13ce1f1b1119a30.gif images/out_%03d.png
```

Nous avons maintenant 49 images de QRCodes qui sont tous différents.
Avec un petit script bash nous déchiffrons tous les QRCodes.


```BASH
#!/bin/bash
i=1
output="output.log"
dir="images"
declare -a list

for f in ${dir}/*.png; do
	parse=$(zbarimg -q $f | grep -e QR | sed -e 's/QR-Code://g')
	list[i]=$(echo ${parse::1}) 
	(( i = i+1 ))
done

pass=$(echo ${list[@]} | tr -d ' ' )
echo $pass
```

Nous trouvons immédiatement le flag :

```BASH
./qrcode_soluce.sh 
The_flag_is:URCACTF{Y0u_Lik3_5t3G4n0_oR_n0T?;-)}
```
