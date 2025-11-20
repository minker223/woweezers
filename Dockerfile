FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY . .

# Make gradlew executable (fixes your error)
RUN chmod +x gradlew

# Build the jar
RUN ./gradlew shadowJar

EXPOSE 8081

CMD ["java", "-jar", "platform-bungee/build/libs/platform-bungee-all.jar"]
