#!/bin/bash

MKDOCS_UID=1000
MKDOCS_GID=1000

MKDOCS_USER=mkdocs
MKDOCS_HOME=/mkdocs

if [[ ! -e $MKDOCS_HOME ]]; then
    echo "No $MKDOCS_HOME bind mount detected.  Please use -v to bind mount $MKDOCS_HOME."
    exit
else
    echo "Bind mount $MKDOCS_HOME found."
    MKDOCS_UID=$(ls -nd $MKDOCS_HOME | awk '{ print $3 }')
    MKDOCS_GID=$(ls -nd $MKDOCS_HOME | awk '{ print $4 }')
fi

# set up mkdocs user to have same user as owner of the bind mount
addgroup --gid $MKDOCS_GID $MKDOCS_USER &> /dev/null
adduser --uid $MKDOCS_UID --gid $MKDOCS_GID $MKDOCS_USER --home $MKDOCS_HOME --no-create-home --disabled-password --gecos '' &> /dev/null

cd $MKDOCS_HOME

mkdocs build
