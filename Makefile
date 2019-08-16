.PHONY: up gofmt proto cert
up:
	yarn --cwd=react/app
	docker-compose up

gofmt:
	GO111MODULE=off go get golang.org/x/tools/cmd/goimports
	goimports -local "kambayashia/golang" -l . | xargs goimports  -local "kambayashia/golang" -w

proto:
	rm -rf go/pkg/proto react/app/src/proto
	mkdir -p go/pkg/proto react/app/src/proto
	# latestが更新されてなくて古いままなので0.4.0を指定
	docker run -v "`pwd`:/build" -w /build --rm znly/protoc:0.4.0 -I proto \
	--go_out=plugins=grpc:/build/go/pkg/proto \
	--js_out=import_style=commonjs,binary:/build/react/app/src/proto \
	--grpc-web_out=import_style=commonjs,mode=grpcweb:/build/react/app/src/proto \
	proto/v1/hello.proto
	# NOTE: 下記のようにビルドエラーが出てしまうのでts出力したものが使えない
	# https://github.com/grpc/grpc-web/pull/537
	# またコード的に修正してみてもjs実行時に下記エラーがでる
	# grpc: received message larger than max (1094795585 vs. 4194304)
	# docker run -v "`pwd`:/build" -w /build --rm namely/protoc-all:latest -d proto -l go -o /build/go/src/proto
	# docker run -v "`pwd`:/build" -w /build --rm namely/protoc-all:latest -d proto -l web -o /build/react/app/src/proto

	# TODO reactのeslintでeslintignoreが効かないので暫定的に各ファイルに挿入
	find react/app/src/proto/ -name "*.js" | xargs -n1 sed -i -e "1i/* eslint-disable */"

cert:
	brew install mkcert
	mkcert -install
	mkcert 0.0.0.0 localhost 127.0.0.1 ::1
	mv 0.0.0.0*-key.pem docker/nginx/certs/localhost-key.pem
	mv 0.0.0.0*.pem docker/nginx/certs/localhost.pem
