export GOTOOLCHAIN=go1.21.1
export GOEXPERIMENTALS=loopvar

install:
	go install github.com/deepmap/oapi-codegen/cmd/oapi-codegen@v1.16.2

gen:
	oapi-codegen -generate "types" -package openapi openapi.yml > ./openapi/types.gen.go
	oapi-codegen -generate "echo-server" -package openapi openapi.yml > ./openapi/server.gen.go
	oapi-codegen -generate "spec" -package openapi openapi.yml > ./openapi/spec.gen.go

test:
	go test -v ./...
