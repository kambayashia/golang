package main

import (
	"net"

	"github.com/labstack/gommon/log"

	gprc2 "kambayashia/golang/mytool/src/pkg/logic/grpc"
	pb "kambayashia/golang/mytool/src/pkg/logic/proto"

	"google.golang.org/grpc"
)

func main() {
	listenPort, err := net.Listen("tcp", ":3002")
	if err != nil {
		log.Fatal(err)
	}
	server := grpc.NewServer()

	service := gprc2.HelloService{}
	pb.RegisterHelloServiceServer(server, service)
	log.Fatal(server.Serve(listenPort))
}
