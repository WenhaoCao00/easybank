# Build Stage
FROM golang:1.23-alpine3.22 AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go
RUN apk --no-cache add curl
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.18.3/migrate.linux-amd64.tar.gz | tar xvz

# Run Stage
FROM alpine:3.22
WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/migrate ./migrate
COPY app.env .
COPY start.sh .
COPY wait-for.sh .
COPY db/migration ./migration

EXPOSE 7999
CMD ["/app/main"]
ENTRYPOINT [ "/app/start.sh" ]