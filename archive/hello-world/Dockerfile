FROM golang:1.8 as builder

COPY server.go /server.go

RUN CGO_ENABLED=0 GOOS=linux go build -o /server /server.go && strip /server


FROM alpine:3.6

COPY --from=builder /server /server

CMD ["/server"]
