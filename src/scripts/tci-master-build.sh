#!/bin/bash

set -e

if [[ $# > 0 ]]; then
    version=$1
else
    echo "you must provide a version as parameter"
    exit 1
fi

git commit -am "Release $version" | head
git tag $version
git push origin HEAD --tags

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
docker build -t tikalci/tci-master-minimal:latest .
docker tag tikalci/tci-master-minimal:latest tikalci/tci-master-minimal:$version
docker push tikalci/tci-master-minimal:latest
docker push tikalci/tci-master-minimal:$version

cp ../origin-plguins.txt ../plugins.txt
cat ../../src/resources/tci/tci-full-extra-plugins.txt >> ../plugins.txt
cat ../plugins.txt | sort > plugins.txt
docker build -t tikalci/tci-master-full:latest .
docker tag tikalci/tci-master-full:latest tikalci/tci-master-full:$version
docker push tikalci/tci-master-full:latest
docker push tikalci/tci-master-full:$version

cd ../..
rm -rf temp/tci-bloody-jenkins

