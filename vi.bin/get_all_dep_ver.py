#!/usr/bin/env python

import sys
from xml.etree import ElementTree

POM_FILE = (len(sys.argv) > 1 and sys.argv[1]) or 'pom.xml'

namespaces = {'xmlns' : 'http://maven.apache.org/POM/4.0.0'}

tree = ElementTree.parse(POM_FILE)
root = tree.getroot()

deps = root.findall(".//xmlns:dependency", namespaces=namespaces)
for d in deps:
    artifactId = d.find("xmlns:artifactId", namespaces=namespaces)
    version    = d.find("xmlns:version", namespaces=namespaces)
    if hasattr(version, 'text'):
        print artifactId.text + '\t' + version.text

deps = root.findall(".//xmlns:plugin", namespaces=namespaces)
for d in deps:
    artifactId = d.find("xmlns:artifactId", namespaces=namespaces)
    version    = d.find("xmlns:version", namespaces=namespaces)
    if hasattr(version, 'text'):
        print artifactId.text + '\t' + version.text
