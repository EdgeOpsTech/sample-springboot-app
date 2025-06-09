FROM eclipse-temurin:17-jdk-alpine

WORKDIR /opt

# Copy pre-built JAR (adjust if JAR name is known)
COPY target/*.jar app.jar

# Download OpenTelemetry agent
ADD https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar /opt/opentelemetry-javaagent.jar

EXPOSE 9090

ENTRYPOINT ["java", "-jar", "/opt/app.jar"]
