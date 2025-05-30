FROM golang:1.20-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o time-app .

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/time-app .
EXPOSE 8080
CMD ["./time-app"]
