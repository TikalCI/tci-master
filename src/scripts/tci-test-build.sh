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

cp -R ./../src/config-handlers . | true

exit 0

cp plugins.txt ../origin-plguins.txt

cp ../origin-plguins.txt ../plugins.txt
cat ../../src/resources/tci/tci-extra-plugins.txt >> ../plugins.txt
cat ../plugins.txt | sort > plugins.txt

docker build -t tikalci/tci-test-minimal:latest .
docker tag tikalci/tci-test-minimal:latest tikalci/tci-test-minimal:$version

cp ../origin-plguins.txt ../plugins.txt
cat ../../src/resources/tci/tci-full-extra-plugins.txt >> ../plugins.txt
cat ../plugins.txt | sort > plugins.txt

docker build -t tikalci/tci-test-full:latest .
docker tag tikalci/tci-test-full:latest tikalci/tci-test-full:$version

cd ../..
rm -rf temp/tci-bloody-jenkins

