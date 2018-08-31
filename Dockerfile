FROM golang:alpine  as builder
LABEL maintainer="Dmitry Rodin <madiedinro@gmail.com>"
RUN apk --no-cache add ca-certificates git make gcc musl-dev

EXPOSE 9090

WORKDIR /go/src/github.com/Vertamedia/chproxy
ENV GOPATH=/go
RUN git clone https://github.com/Vertamedia/chproxy .
# RUN go build -ldflags '-extldflags "-static"' github.com/Vertamedia/chproxy
RUN make build
FROM alpine:latest

WORKDIR /
COPY --from=builder /go/src/github.com/Vertamedia/chproxy/chproxy /usr/bin/chproxy

CMD ["/usr/bin/chproxy", "-config=/config.yml"]
