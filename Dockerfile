FROM golang:1.18-alpine as builder

WORKDIR /go-docker

# COPY go.mod, go.sum and download the dependencies
COPY go.* ./
RUN go mod download && go mod verify

# COPY All things inside the project and build
COPY . .
RUN go build -o /go-docker/build/myapp .

FROM alpine:latest
COPY --from=builder /go-docker/build/myapp /go-docker/build/myapp

EXPOSE 8080
ENTRYPOINT [ "/go-docker/build/myapp" ]
