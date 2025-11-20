FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY . .

RUN chmod +x gradlew

# Build all modules
RUN ./gradlew build

# DEBUG: list all jars to see what gets built
RUN ls -R backend-rpc-server/build/libs

EXPOSE 8081

# Placeholder CMD so container doesn't exit
CMD ["sleep", "infinity"]
