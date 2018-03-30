# [HackSécuReims] Write-Up - Trash (Forensic, 100)

## Description :
Jean te demande de l'aider, il a voulu tester un ancien OS et est encore allé trop vite et à supprimer par mégarde des documents importants. Aidez-le à les retrouver !


## Trash :

Cela change très facile fait appel à la corbeille sous Windows XP, où sans pouvoir récupérer les fichiers nous pouvons voir les noms des fichiers

Du coup en bash, cat ou strings sont nos amis :

```BASH
strings trash | grep 'URCACTF'
C:\Documents and Settings\forensic\Bureau\test\URCACTF{W1nd0ws
```

Bon nous avons la première partie du flag, du coup il faut trouver la seconde partie manquante.

En connaissant la pattern des flags pour le CTF à savoir URCACTF{....} nous savons donc qu'il faut trouver la fin


```BASH
strings trash | grep '}'
C:\Documents and Settings\forensic\Bureau\test\_XP_sUcks!!!}
```

Nous trouvons immédiatement le flag :

Le flag est : URCACTF{W1nd0ws_XP_sUcks!!!}
