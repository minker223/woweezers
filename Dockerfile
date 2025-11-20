# Use Eclipse Temurin Java 17 JDK
FROM eclipse-temurin:17-jdk

# Set working directory inside container
WORKDIR /app

# Copy all project files into container
COPY . .

# Make Gradle wrapper executable
RUN chmod +x gradlew

# Build all modules (including core-platform-bungee)
RUN ./gradlew build --no-daemon

# Optional: list all JARs to confirm build
RUN find . -name "*.jar"

# Expose port for Bungee server
EXPOSE 8081

# Run the Bungee server JAR
CMD ["java", "-jar", "core/core-platform-bungee/build/libs/core-platform-bungee.jar"]
