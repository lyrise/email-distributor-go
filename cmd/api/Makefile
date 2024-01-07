export GOTOOLCHAIN=go1.21.3
export GOEXPERIMENTALS=loopvar

install:
	go install github.com/deepmap/oapi-codegen/cmd/oapi-codegen@v1.16.2
	go install github.com/onsi/ginkgo/v2/ginkgo

gen:
	oapi-codegen -generate "types" -package openapi openapi.yml > ./openapi/types.gen.go
	oapi-codegen -generate "chi-server" -package openapi openapi.yml > ./openapi/server.gen.go
	oapi-codegen -generate "spec" -package openapi openapi.yml > ./openapi/spec.gen.go

test:
	ginkgo -r
