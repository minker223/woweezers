# -------------------------------------------------
# Stage 1: Download BungeeCord
# -------------------------------------------------
FROM eclipse-temurin:17-jre-alpine AS downloader

WORKDIR /download

# Install curl and download the official BungeeCord jar
RUN apk add --no-cache curl && \
    curl -L -o bungee.jar https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar

# -------------------------------------------------
# Stage 2: Final Runtime Image
# -------------------------------------------------
FROM eclipse-temurin:17-jre-alpine

WORKDIR /server

# Install tiny HTTP server for health checks
RUN apk add --no-cache busybox-extras

# Copy BungeeCord from previous stage
COPY --from=downloader /download/bungee.jar ./bungee.jar

# Copy your plugins folder (with EaglerXServer.jar inside)
COPY plugins ./plugins

# Expose ports
EXPOSE 25577 10000

# Start both servers: game server + HTTP health check
# Render will hit ${PORT} for the health check
CMD sh -c "java -jar bungee.jar --port 25577 & while true; do echo 'HTTP/1.1 200 OK\n\nOK' | nc -l -p ${PORT:-10000}; done"
