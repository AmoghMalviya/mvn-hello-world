# Use the Tomcat 9 image with JDK 11
FROM tomcat:9.0-jdk11-openjdk

# Remove the default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file to the webapps directory
COPY target/mvn-hello-world.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8085 (assuming your application runs on this port)
EXPOSE 8085
