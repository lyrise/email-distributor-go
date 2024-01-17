package common

type AppConfig struct {
}

type MySQLConfig struct {
	Url string
}

func NewAppConfig(mode RunMode) *AppConfig {
	return &AppConfig{}
}
