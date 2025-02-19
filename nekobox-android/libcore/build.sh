#!/bin/bash

source ../buildScript/init/env_ndk.sh

[ $rel ] || sed -i "s/buildDate .*/buildDate := `date +'%Y%m%d'`/g" date.go

BUILD=".build"

rm -rf $BUILD/android \
  $BUILD/java \
  $BUILD/javac-output \
  $BUILD/src

gomobile bind -v -androidapi 21 -trimpath -ldflags='-s -w' -tags='with_conntrack,with_gvisor,with_quic,with_wireguard,with_utls,with_clash_api,with_ech' . || exit 1
rm -r libcore-sources.jar

proj=../app/libs
mkdir -p $proj
cp -f libcore.aar $proj
echo ">> install $(realpath $proj)/libcore.aar"
