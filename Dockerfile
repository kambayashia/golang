FROM golang:1.12-alpine

RUN apk add --no-cache git
RUN go get github.com/oxequa/realize

ENV GO111MODULE=on
WORKDIR /go/src/app

CMD ["realize","start","--server"]
