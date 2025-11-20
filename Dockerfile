# Use a JDK image to build and run
FROM gradle:8.3.3-jdk17 AS builder

WORKDIR /app

# Copy all the project files
COPY . .

# Build the main Bungee server JAR (shadowJar includes dependencies)
RUN ./gradlew :core:core-platform-bungee:shadowJar -x test

# Use a smaller JRE image to run the server
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy the built server JAR from the builder
COPY --from=builder /app/core/core-platform-bungee/build/libs/core-platform-bungee-*-all.jar ./server.jar

# Expose default BungeeCord port
EXPOSE 25577

# Run the server
CMD ["java", "-jar", "server.jar"]
