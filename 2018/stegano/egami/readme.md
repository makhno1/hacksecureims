# [HackSécuReims] Write-Up - Egami (Stega, 200)

## Description :
L’image que nous avons récupérée sur le serveur a été altérée lors du transfert, aidez-nous à la réparer.


## Egami :

Nous avons un fichier dont le nom [galf](files/galf_16d07db8acd272959b0f15f759e22a19) nous fait premièrement penser à flag à l'envers. Par ailleurs, le titre du chall Egami toujours à l'envers nous fait penser à Image.

```BASH
cat galf_16d07db8acd272959b0f15f759e22a19 | hd | tail
000877e0  b6 22 0b 01 13 ce 51 01  11 80 9a 44 40 90 08 42  |."....Q....D@..B|
000877f0  42 40 85 21 d2 1e f4 d9  b3 77 db 3f ff 1e 65 14  |B@.!.....w.?..e.|
00087800  7c 77 9d ec da 78 54 41  44 49 00 20 00 00 b6 9d  ||w...xTADI. ....|
00087810  70 be 01 04 0b 16 0c e1  07 45 4d 49 74 07 00 00  |p........EMIt...|
00087820  00 1b 0e 2b 95 01 c4 0e  00 00 c4 0e 00 00 73 59  |...+..........sY|
00087830  48 70 09 00 00 00 93 a7  bd a0 ff 00 ff 00 ff 00  |Hp..............|
00087840  44 47 4b 62 06 00 00 00  37 df 53 de 00 00 00 06  |DGKb....7.S.....|
00087850  08 e7 03 00 00 b4 02 00  00 52 44 48 49 0d 00 00  |.........RDHI...|
00087860  00 0a 1a 0a 0d 47 4e 50  89                       |.....GNP.|
00087869
```

Nous nous apercevons qu'en lisant à partir de la fin nous voyons des headers de connus : PNG / IHDR / bKGD / tIME / IDAT ....

Donc nous avons affaire à une image PNG dont le code hexadécimal a été retourné :

1. 47 4e 50 89 => GNP.
2. 89 50 4e 47 => .PNG

Il suffit de lire les octets à partir de la fin tout simplement.

Nous trouvons immédiatement le flag :

```Python
import binascii

bytes = open('galf_16d07db8acd272959b0f15f759e22a19', 'r').read()
output = open("flag.png", 'a')
for i in reversed(bytes):
	output.write(i)
```

L'image [flag.png](files/flag.png) en sortie nous donne le flag.

Le flag est : **URCACTF{r3v3r5ed_4ensics}}**
