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

# Copy BungeeCord from the previous stage
COPY --from=downloader /download/bungee.jar ./bungee.jar

# Copy your plugins folder (with EaglerXServer.jar inside)
COPY plugins ./plugins

# Expose Render's dynamic port (BungeeCord will listen on it)
EXPOSE 25577

# Start BungeeCord and bind to Render's $PORT
# If $PORT is not set, fallback to 25577
CMD ["sh", "-c", "java -jar bungee.jar --port ${PORT:-25577}"]


