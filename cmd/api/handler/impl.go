package handler

import (
	"encoding/json"
	"fmt"
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
	v, err := parseRequestJson[openapi.SendEmail](r)
	if err != nil {
		s.logger.Error("Failed to parse request json", zap.Error(err))
		w.WriteHeader(http.StatusBadRequest)
		return
	}
	fmt.Printf("%+v\n", v)
	w.WriteHeader(http.StatusOK)
}

func parseRequestJson[T any](r *http.Request) (T, error) {
	var requestBody T
	err := json.NewDecoder(r.Body).Decode(&requestBody)
	if err != nil {
		var zeroValue T
		return zeroValue, err
	}
	return requestBody, nil
}
