package main

import (
	"os"

	"github.com/lyrise/email-distributor-go/cmd/api/common"
	"github.com/lyrise/email-distributor-go/cmd/api/handler"
	"go.uber.org/zap"
)

func main() {
	info := common.NewAppInfo()

	logger := common.NewLogger(info.Mode)
	defer logger.Sync()

	logger.Info("----- START -----", zap.Object("info", info))

	// migrator, err := migration.NewMySQLMigrator()
	// migrator.Migrate()

	// email_distributor.HelloWorld()

	server := handler.NewApiServer(logger)

	if err := server.ListenAndServe(); err != nil {
		logger.Fatal("Failed to start server", zap.Error(err))
		os.Exit(1)
	}
}
