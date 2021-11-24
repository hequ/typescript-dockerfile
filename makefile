all: build
test: unit-test
test-ci: unit-test-ci
scan: scan-container
run: run-local

.PHONY: build
build: 
	DOCKER_BUILDKIT=1 docker build . --tag fastbuild:latest --target final

.PHONY: unit-test
unit-test: 
	DOCKER_BUILDKIT=1 docker build . --tag fastbuild:test-latest --target test
	@docker run -it fastbuild:test-latest

.PHONY: unit-test-ci
unit-test-ci: 
	DOCKER_BUILDKIT=1 docker build . --tag fastbuild:test-latest --target test
	@docker run fastbuild:test-latest
	
.PHONY: scan-container
scan-container:
	DOCKER_BUILDKIT=1 docker build . --tag fastbuild:latest --target final
	@docker scan fastbuild:latest

.PHONY: run-local
run-local: 
	DOCKER_BUILDKIT=1 docker build . --tag fastbuild:latest --target final
	@docker run -p 3000:3000 -it fastbuild:latest