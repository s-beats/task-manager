FROM golang:1.19-alpine as builder

WORKDIR /app

RUN apk update && apk add git
COPY go.mod go.sum ./
RUN go mod download

COPY . /app/
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o /app/todo ./cmd/api/main.go


# FROM scratch as api
FROM golang:1.19-alpine as api

COPY --from=builder /app/todo /bin/todo

CMD ["/bin/todo"]
