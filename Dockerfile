FROM eclipse-temurin:17-jdk AS builder
WORKDIR /app
COPY . .

RUN chmod +x gradlew
RUN ./gradlew :backend-server:shadowJar -x test

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

COPY --from=builder /app/backend-server/build/libs/*-all.jar ./server.jar

EXPOSE 8081

CMD ["java", "-jar", "server.jar"]
