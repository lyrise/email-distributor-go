package handler

import (
	"net"
	"net/http"
	"os"

	"github.com/getkin/kin-openapi/openapi3"
	"github.com/go-chi/chi/v5"
	middleware "github.com/oapi-codegen/nethttp-middleware"
	httpSwagger "github.com/swaggo/http-swagger"
	"go.uber.org/zap"

	openapi "github.com/lyrise/email-distributor-go/cmd/api/openapi"
)

type ApiServer struct {
	logger *zap.Logger
}

func NewApiServer(logger *zap.Logger) *http.Server {
	router := chi.NewRouter()

	// Add handler
	serverImpl := newServerImpl()
	openapi.HandlerFromMux(serverImpl, router)

	// Add swagger docs
	router.Get("/api/openapi.yml", func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, "./openapi.yml")
	})
	router.Get("/api/docs/*", httpSwagger.Handler(
		httpSwagger.URL("/api/openapi.yml"),
	))

	// Add request validation
	swagger, err := openapi.GetSwagger()
	if err != nil {
		logger.Fatal("Failed to get swagger spec", zap.Error(err))
		os.Exit(1)
	}
	swagger.Servers = nil
	swagger.AddOperation("/api/openapi.yml", "GET", &openapi3.Operation{})
	swagger.AddOperation("/api/docs/{path}", "GET", &openapi3.Operation{})
	router.Use(middleware.OapiRequestValidator(swagger))

	server := &http.Server{
		Handler: router,
		Addr:    net.JoinHostPort("0.0.0.0", "8080"),
	}

	return server
}
