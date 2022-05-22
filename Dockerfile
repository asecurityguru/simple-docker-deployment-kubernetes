FROM tomcat:7-jdk8-openjdk
LABEL maintainer="support@asecurityguru.in"
ADD TomcatMavenApp.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]