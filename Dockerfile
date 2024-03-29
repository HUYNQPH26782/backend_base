# Stage 1: Build the Spring Boot application with Gradle
FROM gradle:7.4.1-jdk17 AS builder

WORKDIR /app

COPY build.gradle .
COPY settings.gradle .
COPY src src

# Show the directory contents before running the build
RUN ls -al

# Run the build command with more detailed output
RUN gradle build --no-daemon --stacktrace

FROM eclipse-temurin:17

WORKDIR /app

COPY --from=builder /app/build/libs/*.jar /app/app.jar

CMD ["java", "-jar", "app.jar"]