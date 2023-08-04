DOCKER_BUILDX_NAME:=mybuilder

DOCKER_INSTALL_BIN_FMT:= \
	docker run --privileged --rm tonistiigi/binfmt --install all

TEST_DOCKER_BUILDX_NAME:='$(shell docker buildx ls | grep -q "^$(DOCKER_BUILDX_NAME)" && echo true || echo false)'
DOCKER_BUILDX_MULTIPLATFORM_CLEAN:= \
	if $(TEST_DOCKER_BUILDX_NAME); then \
		docker buildx rm $(DOCKER_BUILDX_NAME); \
	fi

DOCKER_BUILDX_MULTIPLATFORM_SETUP:= \
	docker buildx create \
	--name $(DOCKER_BUILDX_NAME) \
	--driver=docker-container \
	--bootstrap --use
