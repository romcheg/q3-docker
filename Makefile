build: version = $(shell ./get_version.sh)
build:
	docker build \
	    --build-arg PACKAGE_VERSION="$(version)" \
		-t q3a-server:latest \
		-t "q3a-server:$(version)" .
