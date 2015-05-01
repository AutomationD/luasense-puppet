#!/bin/bash
version='0.1.0'
pkg_dir='/Users/dmitry/dev/luasense-puppet/pkg/'
BINTRAY_API_KEY=$1
cd $pkg_dir
rm -rf *.tar.gz
file_name="kireevco-luasense-${version}.tar.gz"
puppet module build
curl -X PUT -T "${file_name}" -ukireevco:${BINTRAY_API_KEY} "https://api.bintray.com/content/kireevco/generic/luasense-puppet/${version}/${file_name}"
# curl -X DELETE -ukireevco:${BINTRAY_API_KEY} "https://api.bintray.com/content/kireevco/generic/luasense-puppet/${version}/${file_name}"
# /packages/:subject/:repo/:package/versions/:version