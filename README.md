# Typescript-dockerfile

Dockerfile + makefile for making a typescript project easier.

# What does it do?

This project includes a Dockerfile and a Makefile.

Dockerfile:

- builds a working production image
- includes only production node_modules
- uses multi-stage build to produce a lean image
- adds a test target so you can run tests with docker
- is fast to rebuild after sourcefile changes because it is structured so that only necessary files need to be processed again

Makefile:

- `make` to build your app and produce a working production ready docker container.
- `make test` to run your tests with docker.
- `make run` to run your app locally. The default sample website will run on http://localhost:3000.
- `make scan` to scan the container for vulnerabilites with [snyk](https://snyk.io/). You might need to login with `docker scan --login` first.

# Motivation

Building a Dockerfile is not rocket science, but getting it right requires you to know a thing or two about docker. Motivation of this project is to produce a Dockerfile + makefile which you can use to get things right from the beginning. Docker is a great tool, but too many times projects end up into a state, where the local development environment is set up differently compared to the one running in production. This usually doesn't happen on purpose, but because it's just easier to modify the production enviroment only, than it is to create a setup where development and production environments are as similar as possible. One of the motivations to build this project is to make so good initial setup (docker environment) that you want to use it also while developing your app. This way your development environment will run the same way as your production does, and it means that you will encounter less "happens only in production" type of bugs.

# How do I use this?

The core of this project is the makefile and the Dockerfile. For illustration purposes there is a small sample application included, which can be used to verify that this works.

You need (obviously) [docker](https://docs.docker.com/get-docker/) to run this, and your system should support make (which most systems do by default).

After installing docker, you must:

1. copy your application source files into src/ and test files to test/
2. make sure you have listed all the required dependencies in the package.json
3. make src/index.ts your application entrypoint

Running `make` will produce a working container, and you can run it locally by running `make run`.
