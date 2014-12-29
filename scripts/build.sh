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
	./$CHECKOUT_DIR/scripts/feeds update packages luci ffw-project
	./$CHECKOUT_DIR/scripts/feeds install -a -p packages
	./$CHECKOUT_DIR/scripts/feeds install -a -p luci
	./$CHECKOUT_DIR/scripts/feeds install -a -p ffw-project
}
	
echo "Récupération de la branche attitude_adjustment"
checkout ""
echo "Copie du script de feeds OpenWrt"
copy_feeds_script ""
echo "Récupération des paquetages des feeds"
checkout_feeds ""
