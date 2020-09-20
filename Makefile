build: version = $(shell ./get_version)
build:
	docker build \
	    --build-arg PROJECT_VERISION="$(version)" 
		-t q3a-server:latest
		-t "q3a-server:$(version)" .
