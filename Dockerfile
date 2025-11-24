# Build stage  
FROM eclipse-temurin:17-jdk AS builder  
WORKDIR /app  
COPY . .  
RUN chmod +x gradlew  

# Build the core module using ShadowJar  
RUN ./gradlew :core:shadowJar -x test  

# Runtime stage  
FROM eclipse-temurin:17-jre-alpine  
WORKDIR /app  

# Copy the shadow JAR from the build output  
COPY --from=builder /app/core/build/libs/core-*-all.jar ./server.jar  

EXPOSE 25577  

CMD ["java", "-jar", "server.jar"]
