FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY . .

RUN chmod +x gradlew

# Build all modules
RUN ./gradlew build

# Find the backend server jar
RUN ls backend-rpc-server/build/libs

# Run backend server
CMD ["java", "-jar", "backend-rpc-server/build/libs/backend-rpc-server-1.0.jar"]

EXPOSE 8081
