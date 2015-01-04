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

copy_file_and_script() {
	cp -fpR ./scripts/feeds.conf.default $CHECKOUT_DIR/
	cp -fpR ./file/banner $CHECKOUT_DIR/package/base-files/files/etc/
}

polaris_adaptation() {
	fileTarget=$CHECKOUT_DIR/'include/target.mk'

	if ! grep -q Polaris-Firmware $fileTarget
	then
		line=`expr $(sed -n /DEFAULT_PACKAGES:=/= $fileTarget) + 1`
		# liste des packages necessaire pour polaris
		package_polaris="wifidog-ffw tinyproxy luci luci-i18n-french luci-app-tinyproxy"

		sed -i `expr $line`i"DEFAULT_PACKAGES:=`echo $package_polaris`" $fileTarget
		sed -i `expr $line`i'# Polaris-Firmware - default packages' $fileTarget
	fi
 }

checkout_feeds() {
	./$CHECKOUT_DIR/scripts/feeds update packages luci routing oldpackages polaris
	./$CHECKOUT_DIR/scripts/feeds install -a -p packages
	./$CHECKOUT_DIR/scripts/feeds install -a -p luci
	./$CHECKOUT_DIR/scripts/feeds install -a -p routing
	./$CHECKOUT_DIR/scripts/feeds install -a -p oldpackages
	./$CHECKOUT_DIR/scripts/feeds install -a -p polaris
}
	
echo "============================================================================"    
echo "Récupération de la branche Barrier Breaker"
echo "============================================================================"
checkout ""
echo "============================================================================"
echo "Copie des flux de packages et des fichiers de personnalisation du firmware"
echo "============================================================================"
copy_file_and_script ""
polaris_adaptation ""
echo "============================================================================"
echo "Récupération des paquetages des feeds"
echo "============================================================================"
checkout_feeds ""
 
echo "============================================================================"
echo " Polaris-Firmware est prêt. Pour construire le firmware, tapez:"
echo " cd polaris"
echo " make menuconfig # Si vous souhaitez ajouter ou modifier des paquets."
echo " make V=99"
echo "============================================================================"
