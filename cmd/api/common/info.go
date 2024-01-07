package common

import (
	"fmt"
	"os"

	"go.uber.org/zap/zapcore"
)

var (
	gitSemver string
	gitSha    string
)

type RunMode string

const (
	Local RunMode = "local"
	Dev   RunMode = "dev"
	Stg   RunMode = "stg"
	Prd   RunMode = "prd"
)

type AppInfo struct {
	Mode      RunMode
	GitSemver string
	GitSha    string
}

func (a *AppInfo) MarshalLogObject(enc zapcore.ObjectEncoder) error {
	enc.AddString("mode", string(a.Mode))
	enc.AddString("gitSemver", a.GitSemver)
	enc.AddString("gitSha", a.GitSha)
	return nil
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
		Mode:      runMode,
		GitSemver: gitSemver,
		GitSha:    gitSha,
	}
}

func (a AppInfo) String() string {
	return fmt.Sprintf("mode: %s, git_semver: %s, git_sha: %s",
		a.Mode, a.GitSemver, a.GitSha)
}
