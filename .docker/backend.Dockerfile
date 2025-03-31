# Development stage
FROM golang:1.24-alpine AS development

WORKDIR /app

# Install development tools
RUN apk add --no-cache git

# Set environment variables
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# Copy go.mod and go.sum
COPY backend/go.mod backend/go.sum ./

# Download dependencies
RUN go mod download

# Copy the rest of the backend code
COPY backend/ ./

# Expose port
EXPOSE 8080

# Install air for hot-reloading during development
RUN go install github.com/air-verse/air@latest

# Start the application with hot-reloading
CMD ["air", "-c", ".air.toml"]

# Build stage
FROM golang:1.24-alpine AS build

WORKDIR /app

# Set environment variables
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# Copy go.mod and go.sum
COPY backend/go.mod backend/go.sum ./

# Download dependencies
RUN go mod download

# Copy the rest of the backend code
COPY backend/ ./

# Build the application
RUN go build -o api ./cmd/api/main.go

# Production stage
FROM alpine:latest AS production

WORKDIR /app

# Install necessary runtime dependencies
RUN apk --no-cache add ca-certificates

# Copy the binary from the build stage
COPY --from=build /app/api .

# Create a non-root user and switch to it
RUN adduser -D appuser
USER appuser

# Expose port
EXPOSE 8080

# Start the application
CMD ["./api"] 