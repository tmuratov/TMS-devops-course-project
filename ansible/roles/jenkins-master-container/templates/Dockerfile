FROM jenkins/jenkins:lts

USER root

COPY plugins.txt /tmp/plugins.txt
COPY jenkins.jks {{ master_keystore }}
# COPY id_rsa {{ master_private_key_file }}

RUN jenkins-plugin-cli --plugin-file /tmp/plugins.txt

USER jenkins
