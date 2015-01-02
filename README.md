# POLARIS FIRMWARE

## 1. Récupération des sources :

Pour récupérer les sources le script s'appuie sur Git et Subversion. Il est donc nécessaire que ces deux outils soient présents sur votre système.

Sous debian: apt-get install git subversion

vOus pouvez ensuite lancer la commande ci-dessous
* ./scripts/build.sh

## 2. Compiler polaris :

* cd polaris
* make menuconfig #Si vous souhaitez ajouter ou modifier des paquets.
* make V=99

Les fichiers sont dans polaris/bin/ après la compilation.
