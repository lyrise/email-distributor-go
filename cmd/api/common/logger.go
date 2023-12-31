package common

import (
	"go.uber.org/zap"
)

func NewLogger(mode RunMode) *zap.Logger {
	var logger *zap.Logger
	var err error

	switch mode {
	case "prd":
		logger, err = zap.NewProduction()
	default:
		logger, err = zap.NewDevelopment()
	}

	if err != nil {
		panic(err)
	}

	return logger
}
