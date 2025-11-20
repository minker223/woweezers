# Build stage
FROM eclipse-temurin:17-jdk AS builder

WORKDIR /app
COPY . .
RUN chmod +x gradlew
RUN ./gradlew :core:core-platform-bungee:shadowJar -x test

# Run stage
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app
COPY --from=builder /app/core/core-platform-bungee/build/libs/core-platform-bungee-*-all.jar ./server.jar

EXPOSE 25577

CMD ["java", "-jar", "server.jar"]
