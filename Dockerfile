# Use OpenJDK as the base image
FROM eclipse-temurin:17-jdk-alpine

# Define build arguments with default values
ARG SOURCE_REGISTRY=ghcr.io
ARG SOURCE_IMAGE=edgeopstech/sample-springboot-app
ARG SOURCE_IMAGE_TAG=latest

# Use the provided build arguments
FROM ${SOURCE_REGISTRY}/${SOURCE_IMAGE}:${SOURCE_IMAGE_TAG}

# Set JAR file location (assuming it's built using Maven/Gradle)
ARG JAR_FILE=target/*.jar

# Copy the JAR file into the container
COPY ${JAR_FILE} /opt/app.jar

# Expose port 9090 instead of 8080
EXPOSE 9090

# Set working directory
WORKDIR /opt

# Run the application with OpenTelemetry support (if required)
ENTRYPOINT ["java", "-javaagent:/opt/opentelemetry-javaagent.jar", "-jar", "/opt/app.jar"]
