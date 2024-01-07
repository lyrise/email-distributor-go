package common

import (
	"go.uber.org/zap"
)

func NewLogger(mode RunMode) *zap.Logger {
	var logger *zap.Logger
	var err error

	switch mode {
	case "local":
		logger, err = zap.NewDevelopment()
	default:
		logger, err = zap.NewProduction()
	}

	if err != nil {
		panic(err)
	}

	return logger
}
