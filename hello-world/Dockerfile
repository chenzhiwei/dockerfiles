FROM golang:1.8

COPY server.go /server.go

RUN CGO_ENABLED=0 GOOS=linux go build -o /server /server.go && strip /server


FROM alpine:3.6

COPY --from=0 /server /server

CMD ["/server"]
