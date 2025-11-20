# Use a stable Java image Railway will pull reliably
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy all code into container
COPY . .

# Make sure gradlew is executable (just in case)
RUN chmod +x gradlew || true

# Build the jar
RUN ./gradlew shadowJar

# Expose server port (matching EaglerX default)
EXPOSE 8081

# Run the server jar (adjust path if your build output is different)
CMD ["java", "-jar", "platform-bungee/build/libs/platform-bungee-all.jar"]
