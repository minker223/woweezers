FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy everything
COPY . .

# Build the server
RUN ./gradlew shadowJar || ./gradlew.bat shadowJar

# Expose default EaglerX port
EXPOSE 8081

# Command to run the server
CMD ["java", "-jar", "platform-bungee/build/libs/platform-bungee-all.jar"]
