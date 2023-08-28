#!/bin/sh

helm package ./nodejs-template/ -d ./build
helm repo index ./build

# aws s3 mb s3://devnotnull-helm

aws s3 cp ./build s3://devnotnull-helm --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers --recursive

