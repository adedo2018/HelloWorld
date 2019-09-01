#!/bin/bash

APP_NAME=HelloWorld
TOMCAT_DIR=$2

# Finding web content directory
WEB_INF=$(find -type d -name 'WEB-INF')
webapp=$(dirname "$WEB_INF")

# exporting CLASSPATH
export CLASSPATH=$3
aray_arg=${@:4}
for arg in $aray_arg; do
  export CLASSPATH=$CLASSPATH:$arg
done

# Find all the .java files inside src/ directory
# and list them in source.txt file 
find src -name *.java > source.txt

# Create the classes/ directory where the .java files should be compiled
mkdir $webapp/WEB-INF/classes

# Compile all the .java files listed inside source.txt
javac -d $webapp/WEB-INF/classes @source.txt
# Remove source.txt after the compilation
rm source.txt

# Create the deployment .war file inside the web content directory
cd $webapp
jar -cvf $APP_NAME.war *
# Remove the classes/ folder after the .war file is created
rm -r WEB-INF/classes/

# Deploy the .war file to tomcat and restart the server
mv $APP_NAME.war $TOMCAT_DIR/webapps/$APP_NAME.war
$TOMCAT_DIR/bin/shutdown.sh
sleep 1
$TOMCAT_DIR/bin/startup.sh
sleep 1

# Open the application in the default browser
xdg-open http://localhost:8080/$APP_NAME
