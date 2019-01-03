#!/bin/bash

set -e

mkdir -p temp
cd temp
git clone git@github.com:TikalCI/tci-bloody-jenkins.git
cd tci-bloody-jenkins
git checkout master

cp plugins.txt ..
cat ../../src/resources/tci/tci-extra-plugins.txt >> ../plugins.txt
cat ../plugins.txt | sort > plugins.txt
docker build -t tci-master .

cd ../..
rm -rf temp/tci-bloody-jenkins
