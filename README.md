# Docker Ghost

[![Travis (.org)](https://img.shields.io/travis/blockloop/docker-ghost.svg)](https://travis-ci.org/blockloop/docker-ghost)
[![Docker Pulls](https://img.shields.io/docker/pulls/blockloop/ghost.svg?style=flat-square)](https://hub.docker.com/r/blockloop/ghost/)

Latest version of [Ghost](https://ghost.org) as a docker container, deployed to
Docker Hub. The Makefile pulls the latest deployed version of Ghost from Github
upon build *which happens daily via [Travis](https://travis-ci.org/blockloop/docker-ghost).*

If you want to build a custom version then you can clone this repo and run
`VERSION=2.2.4 make -e`. This will build a local copy of `blockloop/ghost:<your
version>`. If you want to build your own version you can specify the REPO flag.
For example, `VERSION=2.2.4 REPO=beetlejuice/ghost make -e`. This creates one
tag for latest, major, and minor. For example, `VERSION=2.2.4` will create the
tag `2.2.4` with alias tags `latest`, `2`, and `2.2`. If you want to push all
of the tagged version you can use `VERSION=2.2.4 REPO=beetlejuice/ghost make
push -e`.
