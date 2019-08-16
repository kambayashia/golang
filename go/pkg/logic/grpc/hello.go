package grpc

import (
	"context"

	"github.com/labstack/gommon/log"

	"kambayashia/golang/go/pkg/proto/v1/hello"
)

type HelloService struct{}

func (h HelloService) Hello(ctx context.Context, in *hello.HelloRequest) (*hello.HelloResponse, error) {
	log.Infof("Hello: %v", *in)

	return &hello.HelloResponse{
		Message: "Hello, " + in.Name,
	}, nil
}
