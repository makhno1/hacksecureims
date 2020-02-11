# [HackSécuReims] Write-Up - SimplePDF (Misc, 250)

## Description :
Jean vous demande encore une fois de l'aider car il a recu par email ce document PDF n'ayant pas grand intérêt.
Cependant la taille du document vous laisse perplexe ...


## XYZ :

Nous avons un fichier [PDF](files/final_7dce33b7bdd8c984926332bd5e903880.pdf) avec seulement une page avec écrit **[This page unintentionally left blank]**

Nous testons des choses assez simple tel que strings / binwalk / foremost sur le fichier sans rien trouver de particulier.

Du coup, je me dis qu'il faut analyser le PDF avec un outil tel que [pdf-parser](https://blog.didierstevens.com/programs/pdf-tools/)

```BASH
pdf-parser final_7dce33b7bdd8c984926332bd5e903880.pdf 
PDF Comment '%PDF-1.1\n'

PDF Comment '%\xd0\xd0\xd0\xd0\n\n'
...
 /Names
      <<
        /EmbeddedFiles
          <<
            /Names [(pdf5000.pdf) 7 0 R]
          >>
      >>
...
``` 

Nous voyons que le PDF embarque un autre PDF appelé pdf5000.pdf. En BASH, il éxiste un outil très pratique pdf-detach pour récupérer un fichier embarqué directement dans un PDF.

```BASH
pdfdetach final_7dce33b7bdd8c984926332bd5e903880.pdf -saveall
```

Nous vérifions le PDF extrait avec pdf-parser 


```BASH
...
  /Names [(pdf4999.pdf) 7 0 R]
...
```
Notre intuition est juste, il faut retrouver les 5000 PDF embarqués les uns dans les autres comme les poupées russes :-)

Rapidement en BASH, nous faisons un [script](files/soluce.sh)


```BASH
#!/bin/bash

file="pdf"
end=5001

for ((i=5000; i>=0; i--)); do
	echo $i
	pdfdetach $file$i.pdf -saveall
done

for i in $(seq 1 $end); do
	rm $file$i.pdf
done
```

Nous avons alors le fichier flag.txt qui reste avec le flag à l'intérieur.

Le flag est : **URCACTF{PDF_P4ck1ng_1s_FuN_N0???}**
