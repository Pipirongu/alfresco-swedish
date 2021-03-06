#!/bin/bash

if [ ! -f "work/alfresco-sv-SE.jar" ]
  then
    echo "Error: Source file does not exist: work/alfresco-sv-SE.jar"
    exit 0
fi

if [ ! -f "work/repo-rm-sv-SE.jar" ]
  then
    echo "Error: Source file does not exist: work/repo-rm-sv-SE.jar"
    exit 0
fi

if [ ! -f "work/share-rm-sv-SE.jar" ]
  then
    echo "Error: Source file does not exist: work/share-rm-sv-SE.jar"
    exit 0
fi

if [ ! -f "work/share-sv-SE.jar" ]
  then
    echo "Error: Source file does not exist: work/share-sv-SE.jar"
    exit 0
fi

echo "Extracting language packs"

rm -rf ./work/alfresco-sv-SE
unzip ./work/alfresco-sv-SE.jar -d ./work/alfresco-sv-SE
rm -rf ./work/repo-rm-sv-SE
unzip ./work/repo-rm-sv-SE.jar -d ./work/repo-rm-sv-SE
rm -rf ./work/share-rm-sv-SE
unzip ./work/share-rm-sv-SE.jar -d ./work/share-rm-sv-SE
rm -rf ./work/share-sv-SE
unzip ./work/share-sv-SE.jar -d ./work/share-sv-SE

echo "Clearing out old checked in language packs"

rm -rf ./repo/src/main/resources/*
rm -rf ./repo-rm/src/main/resources/*
rm -rf ./share/src/main/resources/*
rm -rf ./share-rm/src/main/resources/*

echo "Updating all source files"

cp -rf ./work/alfresco-sv-SE/* ./repo/src/main/resources/
cp -rf ./work/repo-rm-sv-SE/* ./repo-rm/src/main/resources/
cp -rf ./work/share-sv-SE/* ./share/src/main/resources/
cp -rf ./work/share-rm-sv-SE/* ./share-rm/src/main/resources/

echo "Fixing missing aikau versions"
#Keep until 1.0.102 is in the official build
cp -rf ./share/src/main/resources/META-INF/js/aikau/1.0.101.3 ./share/src/main/resources/META-INF/js/aikau/1.0.102
# community 6.0.2b
cp -rf ./share/src/main/resources/META-INF/js/aikau/1.0.101.3 ./share/src/main/resources/META-INF/js/aikau/1.0.101.12
#1.0.101.13 for ACS6.0
cp -rf ./share/src/main/resources/META-INF/js/aikau/1.0.101.3 ./share/src/main/resources/META-INF/js/aikau/1.0.101.13
#1.0.101.19 for ACS6.0.1.2
cp -rf ./share/src/main/resources/META-INF/js/aikau/1.0.101.3 ./share/src/main/resources/META-INF/js/aikau/1.0.101.19
#1.0.101.16 for GS 3.1
cp -rf ./share/src/main/resources/META-INF/js/aikau/1.0.101.3 ./share/src/main/resources/META-INF/js/aikau/1.0.101.16
#1.0.104 for ACS 6.1.0.5
cp -rf ./share/src/main/resources/META-INF/js/aikau/1.0.101.3 ./share/src/main/resources/META-INF/js/aikau/1.0.104


echo "Making manual injections"
#Missing translations for workflow tasks: https://issues.alfresco.com/jira/browse/ALF-21841
#begin
cat ./repo-manual-additions/src/main/resources/alfresco/workflow/workflow-messages_sv.properties >> ./repo/src/main/resources/alfresco/workflow/workflow-messages_sv.properties
#end
