# POLARIS FIRMWARE

## 1. Récupération des sources :

Pour récupérer les sources le script s'appuie sur Git et Subversion. Il est donc nécessaire que ces deux outils soient présents sur votre système.

Sous debian: 
  * apt-get install git-core subversion

vous pouvez ensuite lancer la commande ci-dessous
  * ./scripts/build.sh

## 2. Compiler polaris :

Pour compiler votre système doit possèder certains paquetS. voici une liste exaustive en fonction de votre os http://wiki.openwrt.org/doc/howto/buildroot.exigence#table_of_known_prerequisites_and_their_corresponding_packages

Sous debian:
  * apt-get install build-essential libssl-dev

Pour compiler Polaris executer les commandes suivantes:
  * cd polaris
  * make menuconfig # cette commande permet de changer la plateforme par défaut (Atheros AR7xxx/AR9xxx) mais également d'ajouter ou modifier les paquets a installer sur polaris.
  * make V=99

Les fichiers sont dans polaris/bin/ après la compilation.

ATTENTION: recommandations a lire 
 * Ce FIRMWARE peut rendre votre routeur hors service (débutant s'abstenir).
 * Il n'est pas recommandé d'installer ce firmware sur des routeurs ayant moins de 16 MiB de ram.
