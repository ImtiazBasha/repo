#!/bin/bash
yum update -y
amazon-linux-extras install java-openjdk11 -y
wget -O /opt/apache-tomcat-9.0.71-windows-x64.zip \
   https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.71/bin/apache-tomcat-9.0.71-windows-x64.zip
cd /opt/
unzip apache-tomcat-9.0.71-windows-x64.zip
rm -rf apache-tomcat-9.0.71-windows-x64.zip
mv apache-tomcat-9.0.71 tomcat9
cd tomcat9
cd bin
chmod 755 *.sh
./startup.sh