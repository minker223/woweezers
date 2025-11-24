# Stage 1: Download BungeeCord
FROM eclipse-temurin:17-jre-alpine AS downloader
WORKDIR /download
RUN apk add --no-cache curl \
    && curl -L -o bungee.jar https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar

# Stage 2: Runtime Image
FROM eclipse-temurin:17-jre-alpine
WORKDIR /server

# Install netcat / busybox so we can run a dummy HTTP server
RUN apk add --no-cache busybox-extras

# Copy BungeeCord
COPY --from=downloader /download/bungee.jar ./bungee.jar
# Copy your EaglerX plugin(s)
COPY plugins ./plugins

# Expose the game port + health-check port
EXPOSE 25577 10000

# Launch both: the game server + a dummy HTTP server to respond to health check
CMD sh -c "\
  java -jar bungee.jar --port 25577 & \
  while true; do echo -e 'HTTP/1.1 200 OK\r\nContent-Length: 2\r\n\r\nOK' | nc -l -p ${PORT:-10000}; done"
