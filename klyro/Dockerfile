# ── Stage 1: Build the Flutter Web app ────────────────────────────
FROM ghcr.io/cirruslabs/flutter:3.41.2 AS build

WORKDIR /app

# Copy dependency manifests first for better layer caching
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy the rest of the source code
COPY . .

# Build a release web bundle
RUN flutter build web --release

# ── Stage 2: Serve with Nginx ─────────────────────────────────────
FROM nginx:alpine AS production

# Remove default nginx static content
RUN rm -rf /usr/share/nginx/html/*

# Copy custom nginx config
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Copy the built Flutter web app from the build stage
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
