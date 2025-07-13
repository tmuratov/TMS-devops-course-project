FROM jenkins/inbound-agent:latest

USER root

COPY jenkins.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

# changeit is default java keystore password, so ok
RUN keytool -import -trustcacerts -keystore /opt/java/openjdk/lib/security/cacerts \
    -storepass changeit -noprompt -alias jenkins \
    -file /usr/local/share/ca-certificates/jenkins.crt

RUN apt update && apt install maven -y

USER jenkins
