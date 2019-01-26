#!/bin/bash

set -e

TYPE=$1

docker tag tikalci/tci-master-${TYPE}:latest tikalci/tci-master-${TYPE}:lts
docker push tikalci/tci-master-${TYPE}:lts


