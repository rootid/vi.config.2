#!/bin/sh

#To list the node versions
#curl -s http://nodejs.org/dist/index.tab | awk '/^v[0-9]/{ print $1 }' | less
version=v5.0.0
NODE_VERSIONS=5.0.0
mkdir -p $NODE_VERSIONS/node-${version}
curl -sSL# http://nodejs.org/dist/${version}/node-${version}-darwin-x64.tar.gz | tar xvz --strip 1 -C $NODE_VERSIONS/node-${version}
