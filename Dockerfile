# Define build arguments
ARG SOURCE_REGISTRY
ARG SOURCE_IMAGE
ARG SOURCE_IMAGE_TAG

FROM ${SOURCE_REGISTRY}/${SOURCE_IMAGE}:${SOURCE_IMAGE_TAG} AS base

# Use OpenJDK as the runtime base image
FROM eclipse-temurin:17-jdk-alpine

# Set JAR file location (assuming it's built using Maven/Gradle)
ARG JAR_FILE=target/*.jar

# Copy the JAR file from the previous stage
COPY ${JAR_FILE} /opt/app.jar

# Expose port 9090 instead of 8080
EXPOSE 9090

# Set working directory
WORKDIR /opt

# Run the application with OpenTelemetry support (if required)
ENTRYPOINT ["java", "-javaagent:/opt/opentelemetry-javaagent.jar", "-jar", "/opt/app.jar"]
