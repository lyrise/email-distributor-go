package main

import (
	"github.com/lyrise/email-distributor-go/cmd/api/common"
)

func main() {
	info := common.NewAppInfo()

	logger := common.NewLogger(info.Mode)
	defer logger.Sync()

	logger.Info("----- START -----")

	// migrator := migration.NewMySQLMigrator()

	// email_distributor.HelloWorld()
}
