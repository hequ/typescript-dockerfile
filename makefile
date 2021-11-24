all: build
test: unit-test
test-ci: unit-test-ci
scan: scan-container
run: run-local
build-github: github

.PHONY: build
build: 
	DOCKER_BUILDKIT=1 docker build . --tag fastbuild:latest

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
	DOCKER_BUILDKIT=1 docker build . --tag fastbuild:latest
	@docker scan fastbuild:latest

.PHONY: run-local
run-local: 
	DOCKER_BUILDKIT=1 docker build . --tag fastbuild:latest
	@docker run -p 3000:3000 -it fastbuild:latest

.PHONY: github
github:
	DOCKER_BUILDKIT=1 docker build . --tag fastbuild:$(shell date +%Y%m%d).$(GITHUB_RUN_NUMBER)