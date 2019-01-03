#!/bin/bash

set -e

mkdir -p temp
cd temp
git clone git@github.com:TikalCI/tci-bloody-jenkins.git
cd tci-bloody-jenkins
git checkout master
git remote add upstream git@github.com:odavid/my-bloody-jenkins.git
git fetch upstream
git merge upstream/master
git push origin HEAD
git remote remove upstream
cd ../..
rm -rf temp/tci-bloody-jenkins
