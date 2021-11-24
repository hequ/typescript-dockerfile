# Typescript-dockerfile

Dockerfile + makefile for making a typescript project easier.

# Motivation

Building a Dockerfile is not rocket science, but doing it from the scratch (and getting it right) for every project is a tedious task. Motivation of this project is to produce a Dockerfile + makefile which you can use to get things right right from the beginning. Docker is a great tool, but too many times projects end up into a state, where the local development environment is set up differently compared to the one running in production. This usually doesn't happen on purpose, but because you need to do one or more tweaks to your production here and there. And then those tweaks are not made into your local setup. One of the motivations to build this project is to make so good initial setup that you want to use it also while developing your app. This way your development environment will run the same way than your production does, and it means that you will encounter less "happens only in production" type of bugs.

# What does it do?

There is a Dockerfile and a Makefile.

The Dockerfile is written so, that it builds fast and produces a smallest possible image. It leverages docker caching to minimize the time building so you want to use it also in your local development environment.

The Makefile is designed to make building your app really easy! Here are some examples:

- `make` to build your app and produce a working docker container.
- `make test` to run the tests the same way your CI would run them.
- `make run` to run your app locally.
- `make scan` to scan your produced container for vulnerabilities.

# How do I use this?

The core of this project is the makefile and the Dockerfile. For illustration purposes there is a small sample application included, which can be used to verify that this works.

You need (obviously) [docker](https://docs.docker.com/get-docker/) to run this, and your system should support make (which most systems do by default).

After installing docker, you must:

1. copy your application source files into src/ and test files to test/
2. make sure you have listed all the required dependencies in the package.json
3. make index.ts your application entrypoint

Running `make` will produce a working container, and you can run it locally by running `make run`.
