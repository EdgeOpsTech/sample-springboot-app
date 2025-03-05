# Use OpenJDK as the base image
FROM eclipse-temurin:17-jdk-alpine

# Set environment variables for GHCR
ARG SOURCE_REGISTRY=ghcr.io
ARG SOURCE_IMAGE=edgeopstech/sample-springboot-app
ARG SOURCE_IMAGE_TAG=latest

# Pull image from GitHub Container Registry (GHCR)
FROM ${SOURCE_REGISTRY}/${SOURCE_IMAGE}:${SOURCE_IMAGE_TAG}

# Set JAR file location (assuming it's built using Maven/Gradle)
ARG JAR_FILE=target/*.jar

# Copy the JAR file into the container
COPY ${JAR_FILE} /opt/app.jar

# Expose the application port
EXPOSE 9090

# Set working directory
WORKDIR /opt

# Run the application with OpenTelemetry support (if required)
ENTRYPOINT ["java", "-javaagent:/opt/opentelemetry-javaagent.jar", "-jar", "/opt/app.jar"]
