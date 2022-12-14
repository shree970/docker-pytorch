#!/bin/bash

source ./tests/utils.sh

echo "๐งช Start tests"

CONTAINER_NAME=emlov2:session-01

## Test build container

RUN_OUT=$(docker build -t $CONTAINER_NAME .)

if [ $? -eq 0 ]; then
	echo "โ Build container success"
else
	echo "โ Docker build failed !"
	exit 1
fi

## Test run container

for MODEL in resnet18 vit_base_patch16_224 coat_tiny
do
	RUN_OUT=$(docker run $CONTAINER_NAME --model $MODEL --image https://github.com/pytorch/hub/raw/master/images/dog.jpg)

	if [ $? -eq 0 ]; then
		echo "โ Run $MODEL success"
	else
		echo "โ Run failed for $MODEL !, got: $RUN_OUT"
		exit 1
	fi

	## Test if output is valid json

	python3 -c "import json; json.loads('$RUN_OUT')"

	if [ $? -eq 0 ]; then
		echo "โ Output is valid json"
	else
		echo "โ Output is not valid json ! got: $RUN_OUT"
		exit 1
	fi
done

## Test to check pytorch version in image

PYTORCH_VERSION=$(docker run --entrypoint "" $CONTAINER_NAME python3 -c "import torch; print(torch.__version__.split('+')[0])")

if V $PYTORCH_VERSION '>=' 1.10; then
	echo "โ Pytorch version is $PYTORCH_VERSION > 1.10"
else
	echo "โ Pytorch version is $PYTORCH_VERSION < 1.10"
	exit 1
fi

echo "โ All tests passed"

exit 0
