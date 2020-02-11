# [HackSécuReims] Write-Up - Spaces (Stega, 250)

## Description :
...


## Space :

Nous avons un fichier vide mais qui en réalité ne contient que des espaces ...

Simplement chaque ligne ne possède pas le même nombre d'espaces, nous allons essayé de les compter sur chacune des lignes 

Encore une fois, un petit script bash fera parfaitement l'affaire 


```BASH
#!/bin/bash
INPUT="file.txt"
OUTPUT="counter"
PLAINTEXT="plaintext"

sed 's/[a]//g' "$INPUT" | awk '{ print length }' > "$OUTPUT"

while read line
do
    ascii=$(printf \\$(printf "%o" $line))
    echo -n ${ascii}
done < "$OUTPUT" > "$PLAINTEXT"
```

Nous trouvons immédiatement le flag :

```BASH
cat plaintext
Leflagest:URCACTF{Spaces_Crypto_4_URCA}

```
