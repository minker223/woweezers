FROM eclipse-temurin:17-jdk AS builder
WORKDIR /app
COPY . .
RUN chmod +x gradlew
RUN ./gradlew :core:shadowJar -x test

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=builder /app/core/build/libs/*.jar ./server.jar

EXPOSE 25577
CMD ["java", "-jar", "server.jar"]
