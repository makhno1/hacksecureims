# [HackSécuReims] Write-Up - Einstein (Stega, 250)

## Description :
Jean souhaitait associer les maths et la stéga, quelle drôle d'idée ?


## Einstein :

Nous avons deux fichier dont les noms sont respectivement :
1. c.png
2. m.png

Le titre du challenge et les deux images nous font de suite penser à la célèbre formule d'Einstein sur la relativité : E=MC<sup>2</sup>

Les deux possibilités sont de passer via Python avec la librairie PIL ou celle d'OpenCV.

### PIL :
```Python
# E = m * c^2
from PIL import Image

m = Image.open('m.png')
c = Image.open('c.png')
w, h = m.size
r = Image.new("L", (w, h), 0)

pm = m.load()
pc = c.load()
pr = r.load()

for i in range(0, w):
	for j in range(0, h):
		pr[i, j] = (pm[i, j] * pc[i, j] * pc[i, j]) % 256

r.save('flag.png')
```

### OpenCV :
```Python
import cv2
m = cv2.imread("m.png")
c = cv2.imread("c.png")
e = m*c*c
cv2.imwrite("e.png", e)
```

L'image [e.png](files/e.png) en sortie nous donne le flag.

Le flag est : **HSR{3inst3in_1s_v3ry_1nt3rs3t1ng_1n_st3g@}**
