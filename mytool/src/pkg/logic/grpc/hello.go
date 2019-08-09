package grpc

import (
	"context"

	"github.com/labstack/gommon/log"

	pb "kambayashia/golang/mytool/src/pkg/logic/proto"
)

type HelloService struct{}

func (h HelloService) Hello(ctx context.Context, in *pb.HelloRequest) (*pb.HelloResponse, error) {
	log.Infof("Hello: %v", *in)

	return &pb.HelloResponse{
		Message: "Hello, " + in.Name,
	}, nil
}
