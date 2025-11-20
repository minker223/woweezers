# Use Java 17 JDK
FROM eclipse-temurin:17-jdk

# Set working directory
WORKDIR /app

# Copy all project files
COPY . .

# Make Gradle wrapper executable
RUN chmod +x gradlew

# Build all projects
RUN ./gradlew build

# Find the first jar in core-platform-bungee or backend-rpc-server (or whatever project you want)
# This avoids hardcoding the exact jar name
RUN export JAR_FILE=$(find . -type f -name "*core-platform-bungee*.jar" | head -n 1) && \
    echo "Using jar: $JAR_FILE" && \
    mv "$JAR_FILE" /app/server.jar

# Expose port (adjust if needed)
EXPOSE 8081

# Run the jar
CMD ["java", "-jar", "/app/server.jar"]
