module github.com/lyrise/email-distributor-go/cmd/api

go 1.21.3

replace (
	github.com/lyrise/email-distributor-go/pkg/email_distributor => ../../pkg/email_distributor
	github.com/omnius-labs/core-go/migration => ../../refs/core-go
)

require (
	github.com/getkin/kin-openapi v0.122.0
	github.com/labstack/echo/v4 v4.11.3
	github.com/oapi-codegen/runtime v1.1.0
	github.com/onsi/ginkgo/v2 v2.13.2
	github.com/onsi/gomega v1.29.0
	go.uber.org/zap v1.26.0
)

require (
	github.com/apapsch/go-jsonmerge/v2 v2.0.0 // indirect
	github.com/go-logr/logr v1.3.0 // indirect
	github.com/go-openapi/jsonpointer v0.19.6 // indirect
	github.com/go-openapi/swag v0.22.4 // indirect
	github.com/go-task/slim-sprig v0.0.0-20230315185526-52ccab3ef572 // indirect
	github.com/google/go-cmp v0.6.0 // indirect
	github.com/google/pprof v0.0.0-20210407192527-94a9f03dee38 // indirect
	github.com/google/uuid v1.4.0 // indirect
	github.com/invopop/yaml v0.2.0 // indirect
	github.com/josharian/intern v1.0.0 // indirect
	github.com/labstack/gommon v0.4.0 // indirect
	github.com/mailru/easyjson v0.7.7 // indirect
	github.com/mattn/go-colorable v0.1.13 // indirect
	github.com/mattn/go-isatty v0.0.19 // indirect
	github.com/mohae/deepcopy v0.0.0-20170929034955-c48cc78d4826 // indirect
	github.com/perimeterx/marshmallow v1.1.5 // indirect
	github.com/valyala/bytebufferpool v1.0.0 // indirect
	github.com/valyala/fasttemplate v1.2.2 // indirect
	go.uber.org/multierr v1.10.0 // indirect
	golang.org/x/crypto v0.14.0 // indirect
	golang.org/x/net v0.17.0 // indirect
	golang.org/x/sys v0.15.0 // indirect
	golang.org/x/text v0.13.0 // indirect
	golang.org/x/tools v0.14.0 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
)
