#!/usr/bin/env make

export IMAGE_NAME=jdlubrano/terraform-aws-ci

.DEFAULT_GOAL := build

.PHONY: build shell

build:
	@docker build -t ${IMAGE_NAME}:latest .

shell:
	@docker run --rm -it ${IMAGE_NAME}:latest
