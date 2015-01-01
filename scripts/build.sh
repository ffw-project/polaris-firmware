#!/bin/sh
TAG_URL="svn://svn.openwrt.org/openwrt/branches/barrier_breaker"
ERASE_FILES_CONF=erase.conf
CHECKOUT_DIR=polaris

erase_files() {
	for file in $(cat $ERASE_FILES_CONF)
	do
		rm -rf $file
	done
}

checkout() {
	svn co $TAG_URL	$CHECKOUT_DIR
}

copy_feeds_script() {
	cp -fpR ./scripts/feeds.conf.default $CHECKOUT_DIR/
}

checkout_feeds() {
	./$CHECKOUT_DIR/scripts/feeds update packages luci polaris
	./$CHECKOUT_DIR/scripts/feeds install -a -p packages
	./$CHECKOUT_DIR/scripts/feeds install -a -p luci
	./$CHECKOUT_DIR/scripts/feeds install -a -p polaris
}
	
echo "====================================================================="    
echo "Récupération de la branche Barrier Breaker"
echo "====================================================================="
checkout ""
echo "====================================================================="
echo "Copie du script de feeds OpenWrt"
echo "====================================================================="
copy_feeds_script ""
echo "====================================================================="
echo "Récupération des paquetages des feeds"
echo "====================================================================="
checkout_feeds ""
 
echo "====================================================================="
echo " Polaris-Firmware est prêt. Pour construire le firmware, tapez:"
echo " cd polaris"
echo " make menuconfig #Si vous souhaitez ajouter ou modifier des paquets."
echo " make V=99"
echo "====================================================================="
