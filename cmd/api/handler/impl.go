package handler

import (
	"net/http"

	"github.com/lyrise/email-distributor-go/cmd/api/openapi"
)

type ServerImpl struct{}

var _ openapi.ServerInterface = (*ServerImpl)(nil)

func newServerImpl() *ServerImpl {
	return &ServerImpl{}
}

func (s *ServerImpl) SendEmail(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
}
