package common

import (
	"fmt"
	"os"
)

var (
	gitSemver      string
	gitSha         string
	buildTimestamp string
)

type RunMode string

const (
	Local RunMode = "local"
	Dev   RunMode = "dev"
	Stg   RunMode = "stg"
	Prd   RunMode = "prd"
)

type AppInfo struct {
	Mode           RunMode
	GitSemver      string
	GitSha         string
	BuildTimestamp string
}

func NewAppInfo() *AppInfo {
	mode := os.Getenv("RUN_MODE")

	var runMode RunMode
	switch mode {
	case "local":
		runMode = Local
	case "dev":
		runMode = Dev
	case "stg":
		runMode = Stg
	case "prd":
		runMode = Prd
	default:
		panic(fmt.Errorf("invalid RUN_MODE: %s", mode))
	}

	return &AppInfo{
		Mode:           runMode,
		GitSemver:      gitSemver,
		GitSha:         gitSha,
		BuildTimestamp: buildTimestamp,
	}
}

func (a AppInfo) String() string {
	return fmt.Sprintf("mode: %s, git_semver: %s, git_sha: %s, build_timestamp: %s",
		a.Mode, a.GitSemver, a.GitSha, a.BuildTimestamp)
}
