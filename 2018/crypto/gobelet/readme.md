# [HackSécuReims] Write-Up - Gobelet (Crypto, 100)

## Description :
Il semblerait que les gobelets recèlent un code magique ...


## QRCode :

Il faut lire les QRCodes avec un téléphone et nous trouvons alors :

```BASH
zbarimg qrcode_gobelet.png 
QR-Code:http://10.22.6.182/files/2018/flag.png
scanned 1 barcode symbols from 1 images in 0.01 seconds
```

Pour le chall, il faut ensuite récupérer l'image [flag.png](files/flag.png) qui se trouvait sur un serveur en interne au CTF.

C'est encore un QRCode mais avec une taille beaucoup plus grande qui ne pouvait pas être sur le gobelet.

```BASH
zbarimg flag.png 
QR-Code:UEsDBAoACQAAANBxJkzqwGVtNgAAACoAAAAIABwAZmxhZy50eHRVVAkAA7fLUFq3y1BadXgLAAEE6AMAAAToAwAAmSPOnN3y8LGxqyH3Ma6+AhCzAWgJwRKjYXieBjyJsSvEDy/pgcRXG9U2kabR4t5KaGqZQqs/UEsHCOrAZW02AAAAKgAAAFBLAQIeAwoACQAAANBxJkzqwGVtNgAAACoAAAAIABgAAAAAAAEAAACkgQAAAABmbGFnLnR4dFVUBQADt8tQWnV4CwABBOgDAAAE6AMAAFBLBQYAAAAAAQABAE4AAACIAAAAAAA=
scanned 1 barcode symbols from 1 images in 0.12 seconds
```

Nous voyons immédiatement que nous avons affaire à un Base64

Il suffit de le décoder simplement.

```BASH
zbarimg -q flag.png | cut -f2 -d':'|tr -d '\n' | base64 -d > data.raw
```

Nous vérifions le format de sortie

```BASH
file data.raw 
data.raw: Zip archive data, at least v1.0 to extract
```

Nous avons donc un fichier zip qu'il nous suffit d'extraire
```BASH
7za x data.raw 
...
Enter password (will not be echoed):
```

Zut il nous demande un password :-)

Du coup, nous avons deux possibilités :

1. le bruteforce mais pour 100pts ...ce n'est pas la piste
2. trouver le password sur le gobelet ;-)


## Password sur le gobelet

Le gobelet est disponible ici [gobelet](files/DVXF8jwWkAAv4b7.jpg)

En lisant sur le gobelet la chaîne héxadécimale

```BASH
echo -n "524F543133202D2D4A67735F434066666A3065715F345F477531665F4D31632D2D" | xxd -r -p
ROT13 --Jgs_C@ffj0eq_4_Gu1f_M1c--
```

Le résultat nous donne : ROT13 --Jgs_C@ffj0eq_4_Gu1f_M1c--

Nous avons affaire à un simple rot13

```BASH
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"
echo "--Jgs_C@ffj0eq_4_Gu1f_M1c--" | rot13
--Wtf_P@ssw0rd_4_Th1s_Z1p--
```

Nous venons de trouver le password du zip : --Wtf_P@ssw0rd_4_Th1s_Z1p--

il nous reste plus qu'à dézipper pour avoir notre flag :
```BASH
7za x data.raw
on met le password
```

Il suffit juste pour finir de lire le fichier texte :
```BASH
cat flag.txt
URCACTF{Amazing_Crypto_With_a_Simple_Cup}
```
