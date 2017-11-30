#! /bin/bash

tag=$1
[ -z "$tag" ] && tag="latest"

./gradlew clean build
./gradlew shadowJar
docker build . -t arunvelsriram/hazelcast-kubernetes-example:$tag