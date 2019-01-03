#!/bin/bash

set -e

git remote add upstream git@github.com:odavid/my-bloody-jenkins.git
git fetch upstream
git checkout master
git merge upstream/master
git push origin HEAD
git remote remove upstream