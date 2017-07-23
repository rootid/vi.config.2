#!/bin/sh

#mvn jacoco:prepare-agent test jacoco:report
#mvn org.jacoco:jacoco-maven-plugin:prepare-agent test org.jacoco:jacoco-maven-plugin:report

group_id=org.jacoco
artifact_id=jacoco-maven-plugin
mvn $group_id:$artifact_id:prepare-agent test $group_id:$artifact_id:report
