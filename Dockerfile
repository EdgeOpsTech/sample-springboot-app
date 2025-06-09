# --- Stage 1: Base image with built JAR ---
ARG SOURCE_REGISTRY
ARG SOURCE_IMAGE
ARG SOURCE_IMAGE_TAG

FROM ${SOURCE_REGISTRY}/${SOURCE_IMAGE}:${SOURCE_IMAGE_TAG} AS base

# --- Stage 2: Runtime image ---
FROM eclipse-temurin:17-jdk-alpine

# Set working directory
WORKDIR /opt

# Copy JAR from base image
ARG JAR_FILE=target/*.jar
COPY --from=base ${JAR_FILE} app.jar

# Download the OpenTelemetry Java agent
ADD https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar /opt/opentelemetry-javaagent.jar

# Expose the port your app runs on
EXPOSE 9090

# Entrypoint
ENTRYPOINT ["java", "-javaagent:/opt/opentelemetry-javaagent.jar", "-jar", "/opt/app.jar"]

