#!/bin/bash

MKDOCS_HOME=/mkdocs

if [[ -n $STREAM ]]; then
    mkdir -p $MKDOCS_HOME
    tar -xzf - -C $MKDOCS_HOME

    cd $MKDOCS_HOME
    mkdocs build 1>&2

    tar -czf - site | cat
elif [[ -d $MKDOCS_HOME ]]; then
    MKDOCS_UID=1000
    MKDOCS_GID=1000
    MKDOCS_USER=mkdocs

    echo "Bind mount $MKDOCS_HOME found."
    MKDOCS_UID=$(ls -nd $MKDOCS_HOME | awk '{ print $3 }')
    MKDOCS_GID=$(ls -nd $MKDOCS_HOME | awk '{ print $4 }')

    # set up mkdocs user to have same user as owner of the bind mount
    addgroup --gid $MKDOCS_GID $MKDOCS_USER &> /dev/null
    adduser --uid $MKDOCS_UID --gid $MKDOCS_GID $MKDOCS_USER --home $MKDOCS_HOME --no-create-home --disabled-password --gecos '' &> /dev/null

    su - $MKDOCS_USER -c "cd $MKDOCS_HOME; mkdocs build"
else
    cat <<USAGE
Docker mkdocs container.  This container has two modes of operation:

1. Generate the site in a mounted volume.  To trigger this behavior, just mount
a 'mkdocs' compatible site source to /mkdocs (i.e. '-v \`pwd\`:/mkdocs').

2. Generate the site from a streamed tgz.  To trigger this behavior, set the
environment variable 'STREAM' to 1 (i.e. '-e STREAM=1') and stream a tgz of the
site source.  The output will be a tgz of the built 'site' directory.

USAGE
    exit
fi
