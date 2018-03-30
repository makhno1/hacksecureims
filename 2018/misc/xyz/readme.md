# [HackSécuReims] Write-Up - XYZ (Misc, 200)

## Description :
Jean a trouvé ce fichier texte à partir d'un ancien serveur et nous voulons savoir de quoi il s'agit.


## XYZ :

Nous avons un fichier [xyz](files/xyz_527e65087cd1f5612ea781849860a90e.zip) qui contient à chaque fois 3 valeurs d'où le titre du challenge XYZ

```BASH
....(255, 255, 255), (255, 255, 255), (255, 255, 255),...
``` 

Nous en déduisons rapidement qu'il s'agit en fait des valeurs R,G,B de chacun des pixels composant l'image à retrouver.

Nous partons sur un script en python avec la librairie PIL pour refaire l'image : [script](files/soluce.py)


Pour déterminer les dimensions de l'image, il faut déterminer la taille du tableau : len(pixels) qui nous donne alors 528601

Ensuite, ça reste le même principe qu'en crypto pour du RSA à savoir retrouver width * length, via [FactorDB](http://factordb.com/index.php?query=528601)

528601 => 929 * 569

```Python
from PIL import Image

with open('xyz.txt','r') as f:
    pixels = eval(f.read())
    #print len(pixels) 
'''
coloredPixels = []
for px in pixels:
    if px != (255,255,255):
        print(px)
        coloredPixels.append(px)
'''

im = Image.new("RGB", (929, 569))
im.putdata(pixels)
im.show()
```

Nous avons alors l'image [flag.png](files/flag.png) qui s'affiche avec le flag à retrouver.

Le flag est : URCACTF{Pil_PIL_P1L}
