package main

import (
	"net"

	"github.com/labstack/gommon/log"

	gprc2 "kambayashia/golang/go/pkg/logic/grpc"
	"kambayashia/golang/go/pkg/proto/v1/hello"

	"google.golang.org/grpc"
)

func main() {
	listenPort, err := net.Listen("tcp", ":3002")
	if err != nil {
		log.Fatal(err)
	}
	server := grpc.NewServer()

	service := gprc2.HelloService{}
	hello.RegisterHelloServiceServer(server, service)
	log.Fatal(server.Serve(listenPort))
}
