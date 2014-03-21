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

To build a site, run the image like this.  The image will build whatever site
is in `/mkdocs`.

```
$ docker run --rm -i -t -v /host/path:/mkdocs mkdocs
```

# License

Copyright © 2014 Nate Jones

Distributed under the MIT license.
