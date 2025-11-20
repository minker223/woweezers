FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY . .

RUN chmod +x gradlew || true
RUN ./gradlew shadowJar

EXPOSE 8081

CMD ["java", "-jar", "platform-bungee/build/libs/platform-bungee-all.jar"]
