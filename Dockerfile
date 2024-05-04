# Use Tomcat image
FROM tomcat:9.0-jdk11-openjdk-slim

# Remove the default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the build output to the Tomcat webapps directory
COPY ./build/web /usr/local/tomcat/webapps/ROOT

# Expose port 8080 for the Tomcat server
EXPOSE 8080