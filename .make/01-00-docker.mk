# FYI:
# Naming convention for images is $(DOCKER_REGISTRY)/$(DOCKER_NAMESPACE)/$(DOCKER_IMAGE_NAME)-$(DOCKER_IMAGE_ENV):$(DOCKER_IMAGE_TAG)
# e.g.                docker.io/asapdotid/php-local:latest
# $(DOCKER_REGISTRY)   ---^        ^       ^    ^        	docker.io
# $(DOCKER_NAMESPACE)  ------------^       ^    ^        	asapdotid
# $(DOCKER_IMAGE_NAME) --------------------^    ^        	php
# $(DOCKER_IMAGE_ENV)  -------------------------^        	local
# $(DOCKER_IMAGE_TAG)  --------------------------------^	latest

DOCKER_DIR:=./src
BUILD_SERVICE_NAME:=php
DOCKER_BUILD_IMAGE_FILE:=$(DOCKER_DIR)/$(BUILD_SERVICE_NAME)/$(VER)/Dockerfile

TAGGING?=

ifeq ($(TAG),)
	TAGGING:=$(DOCKER_REGISTRY)/$(DOCKER_NAMESPACE)/$(DOCKER_IMAGE_NAME):$(VER)
else
	TAGGING:=$(DOCKER_REGISTRY)/$(DOCKER_NAMESPACE)/$(DOCKER_IMAGE_NAME):$(TAG)
endif

# Run Build Docker Image
DOCKER_BUILD_COMMAND:= \
    docker buildx build \
	--platform ${DOCKER_IMAGE_PLATFORM} \
    -f $(DOCKER_BUILD_IMAGE_FILE) \
	-t $(TAGGING) \
	--push .

# Run Push Docker Image
DOCKER_PUSH_COMMAND:= \
	docker push $(DOCKER_REGISTRY)/$(DOCKER_NAMESPACE)/$(DOCKER_IMAGE_NAME):$(TAG)

# Run inspect Docker Image
DOCKER_INSPECT_COMMAND:= \
	docker buildx imagetools inspect $(DOCKER_REGISTRY)/$(DOCKER_NAMESPACE)/$(DOCKER_IMAGE_NAME):$(TAG)

##@ [Docker]

.PHONY: prepare
prepare: ## Docker setup prepare buildx multiplatform
	@$(DOCKER_INSTALL_BIN_FMT)
	@$(DOCKER_BUILDX_MULTIPLATFORM_CLEAN)
	@$(DOCKER_BUILDX_MULTIPLATFORM_SETUP)

.PHONY: build
build: ## Docker build the image with arguments VER="8.1" or with TAG=latest
	@$(DOCKER_BUILD_COMMAND)

.PHONY: push
push: ## Docker push the image with arguments VER="8.1" or with TAG=latest
	@$(DOCKER_PUSH_COMMAND)

.PHONY: inspect
inspect: ## Docker inspect the image with arguments VER="8.1" or with TAG=latest
	@$(DOCKER_INSPECT_COMMAND)
