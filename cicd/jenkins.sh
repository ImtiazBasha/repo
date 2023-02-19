#!/bin/bash
yum update -y
yum install git -y
git config --global user.name "imtiaz"
git config --global user.email "imtiazbashaaws@gmail.com"
wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum upgrade
amazon-linux-extras install java-openjdk11 -y
yum install jenkins -y
systemctl daemon-reload
systemctl start jenkins
systemctl enable jenkins