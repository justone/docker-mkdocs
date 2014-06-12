# MkDocs in Docker

This repo contains instructions on how to build a docker image that will run
[MkDocs](http://www.mkdocs.org/).

## Docker registry

This image is available on the [Docker registry](https://index.docker.io/) as
[nate/mkdocs](https://index.docker.io/u/nate/mkdocs/).

```
$ docker pull nate/mkdocs
```

## Building

```
$ git clone https://github.com/justone/docker-mkdocs
$ docker build --rm -t mkdocs .
```

## Running

This docker container can be run in one of two ways.

### Using volumes:

The image will build whatever site is mounted in `/mkdocs`.

```
$ docker run --rm -i -t -v /host/path:/mkdocs mkdocs
```

### Without volumes:

When the `STREAM` environment variable is set, this image expects a tgz on stdin with the root of the mkdocs compatible source. The built site is output as a tarball to stdout:

```
$ tar -czf - . | docker run -i -e STREAM=1 --rm mkdocs > output.tgz
```

To replicate the 'with volumes' version without volumes, pipe to a tar command:

```
$ tar -czf - . | docker run -i -e STREAM=1 --rm mkdocs | tar -xzf -
```

# License

Copyright © 2014 Nate Jones

Distributed under the MIT license.
