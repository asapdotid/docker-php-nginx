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
DOCKER_BUILD_IMAGE_FILE:=$(DOCKER_DIR)/$(BUILD_SERVICE_NAME)/$(TAG)/Dockerfile

# Run Build Docker Image
DOCKER_BUILD_COMMAND:= \
    docker buildx build \
    -f $(DOCKER_BUILD_IMAGE_FILE) \
	-t $(DOCKER_REGISTRY)/$(DOCKER_NAMESPACE)/$(DOCKER_IMAGE_NAME):$(TAG) .

# Run Push Docker Image
DOCKER_PUSH_COMMAND:= \
	docker push $(DOCKER_REGISTRY)/$(DOCKER_NAMESPACE)/$(DOCKER_IMAGE_NAME):$(TAG)
##@ [Docker]

.PHONY: build
build: ## Docker build image with arguments TAG="8.1"
	@$(DOCKER_BUILD_COMMAND)

.PHONY: push
push: ## Docker push image with arguments TAG="8.1"
	@$(DOCKER_PUSH_COMMAND)
