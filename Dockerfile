# Build Stage
FROM golang:1.23-alpine3.22 AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go

# Run Stage
FROM alpine:3.22
WORKDIR /app
COPY --from=builder /app/main .

EXPOSE 7999
CMD ["/app/main"]