
# Start from golang base imageee
FROM golang:alpine as builder

# Add Maintainer info
LABEL maintainer="Steven Victor <chikodi543@gmail.com>"

# Install git.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git

# Set the current working directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Copy the source from the current directory to the working Directory inside the container
COPY . .

# Download all dependencies. Dependencies will be cached if the go.mod and the go.sum files are not changed
RUN go mod tidy

# Build the Go app
RUN go build -o main main.go

# Start a new stage from scratch
FROM alpine:latest
RUN apk --no-cache add ca-certificates

WORKDIR /root/

# Copy the Pre-built binary file from the previous stage. Observe we also copied the .env file
COPY --from=builder /app/main .
COPY --from=builder /app/.env .

# Expose port 8080 to the outside world
EXPOSE 8090

#Command to run the executable
CMD ["./main"]




