#!/bin/bash
# this must be inline because of the bamboo variables


BUILD_NUMBER="${bamboo.buildNumber}"

version=${BUILD_NUMBER}


sed -i "s/versionhere/$version/g" ./helm/Chart.yaml
