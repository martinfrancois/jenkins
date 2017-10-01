FROM jenkins/jenkins
 
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Enables easy setting of username and password for jenkins
COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy

# Install Plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER root

# Add custom packages
RUN apt-get update && apt-get install -y nano rpl

USER jenkins