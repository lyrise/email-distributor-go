package handler

import (
	"net/http"

	"github.com/lyrise/email-distributor-go/cmd/api/openapi"
	"go.uber.org/zap"
)

type ServerImpl struct {
	logger *zap.Logger
}

var _ openapi.ServerInterface = (*ServerImpl)(nil)

func newServerImpl(logger *zap.Logger) *ServerImpl {
	return &ServerImpl{logger}
}

func (s *ServerImpl) SendEmail(w http.ResponseWriter, r *http.Request) {
	s.logger.Info("SendEmail")
	w.WriteHeader(http.StatusOK)
}
