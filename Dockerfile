FROM jenkins/jenkins
 
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Enables easy setting of username and password for jenkins
COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy

# Install Plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Add custom packages
RUN apt update && apt install -y nano rpl

# Needed to display JavaDoc correctly: https://wiki.jenkins.io/display/JENKINS/Configuring+Content+Security+Policy
RUN rpl -i -w 'JAVA_ARGS="-Djava.awt.headless=true"' 'JAVA_ARGS="-Djava.awt.headless=true -Dhudson.model.DirectoryBrowserSupport.CSP=' /etc/default/jenkins