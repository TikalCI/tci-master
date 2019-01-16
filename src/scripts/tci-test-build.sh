#!/bin/bash

set -e

if [[ $# > 0 ]]; then
    version=$1
else
    echo "you must provide a version as parameter"
    exit 1
fi

rm -rf temp
mkdir -p temp
cd temp
git clone git@github.com:TikalCI/tci-bloody-jenkins.git
cd tci-bloody-jenkins
git checkout master

if [[ -d ../../src/config-handlers ]]; then
    cp -R ../../src/config-handlers . | true
fi

cp plugins.txt ../origin-plguins.txt

cp ../origin-plguins.txt ../plugins.txt
cat ../../src/resources/tci/tci-extra-plugins.txt >> ../plugins.txt
cat ../plugins.txt | sort > plugins.txt

docker build -t tikalci/tci-test-minimal:latest .
docker tag tikalci/tci-test-minimal:latest tikalci/tci-test-minimal:$version

cd ../..
rm -rf temp/tci-bloody-jenkins

