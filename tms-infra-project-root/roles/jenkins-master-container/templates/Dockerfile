FROM jenkins/jenkins:lts

USER root

COPY plugins.txt /tmp/plugins.txt
COPY jenkins.jks {{ master_keystore }}

RUN jenkins-plugin-cli --plugin-file /tmp/plugins.txt

USER jenkins
