# Use an official JDK image as a base
FROM openjdk:17-jdk-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from Maven build output into the container
COPY target/sample-springboot-app-1.0.0.jar app.jar

# Expose port 9090 inside the container
EXPOSE 9090

# Run the application and ensure Spring Boot uses port 9090
ENTRYPOINT ["java", "-jar", "app.jar"]
