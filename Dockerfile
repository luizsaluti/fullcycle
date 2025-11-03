#FROM golang:1.13-alpine AS builder

#FROM scratch

#COPY --from=builder /usr/local/go/ /usr/local/go/

#ENV PATH="/usr/local/go/bin:${PATH}"

#COPY ./fullcycle.go .

FROM golang:alpine AS builder

WORKDIR /fullcycle

COPY ./aplicacao/fullcycle.go .

RUN GO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o /compilado fullcycle.go
RUN rm -rf /fullcycle
RUN go clean -cache

FROM scratch

COPY --from=builder /compilado /compilado

CMD ["/compilado"]