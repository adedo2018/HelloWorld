#!/bin/bash

APP_NAME=HelloWorld-0.1.0
TOMCAT_DIR=/Users/axhol/Documents/apache-tomcat-9.0.11

# Deploy the .war file to tomcat and restart the server
cp /Users/axhol/.jenkins/workspace/Pipeline_demo/target/$APP_NAME.war $TOMCAT_DIR/webapps/$APP_NAME.war
$TOMCAT_DIR/bin/shutdown.sh
sleep 1
$TOMCAT_DIR/bin/startup.sh
sleep 1

# Open the application in the default browser
# xdg-open http://localhost:8085/$APP_NAME
