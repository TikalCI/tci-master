#!/bin/bash

set -e

docker tag tikalci/tci-master-minimal:latest tikalci/tci-master-minimal:lts
docker tag tikalci/tci-master-full:latest tikalci/tci-master-full:lts

