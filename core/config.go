package core

import (
	"github.com/robfig/config"
	"strconv"
)

var defaultOptions = map[string]string{"serverAddress": "127.0.0.1",
	"serverPort":               "8080",
	"dbType":                   "mysql",
	"dbAddress":                "127.0.0.1:3306",
	"dbUser":                   "",
	"dbPass":                   "",
	"dbBase":                   "",
	"MaxSessionsChannelBuffer": "10",
	"LongpollingTimeout":       "10",
	"DashboardLocation":        "./admin/"}

func initConfig() error {
	var err error
	Cfg = make(map[string]string)
	SysCfg = make(map[string]string)

	c, err := config.ReadDefault(".config")
	if err != nil {
		Error.Fatal("Could not open config file. Please run 'nebuleuse install' to generate one")
		return err
	}
	configs, err := c.Options("default")
	if err != nil {
		Error.Fatal("Could not read values from config file")
		return err
	}

	for _, value := range configs {
		SysCfg[value], err = c.String("default", value)
	}

	return nil
}
func GetSysConfigInt(name string) int {
	res, _ := strconv.Atoi(SysCfg[name])
	return res
}
func GetConfigInt(name string) int {
	res, _ := strconv.Atoi(Cfg[name])
	return res
}
func GetConfigFloat(name string) float64 {
	res, _ := strconv.ParseFloat(Cfg[name], 64)
	return res
}

func loadConfig() {
	var (
		name  string
		value string
	)

	rows, err := Db.Query("select name, value from neb_config")
	if err != nil {
		Error.Fatal(err)
	}

	defer rows.Close()

	for rows.Next() {
		err := rows.Scan(&name, &value)
		if err != nil {
			Error.Fatal(err)
		}
		Cfg[name] = value
	}

	err = rows.Err()
	if err != nil {
		Error.Fatal(err)
	} else {
		Info.Println("Successfully read configuration")
	}
}

func (c *ConfigMgr) SetConfig(name, value string) error {
	_, err := Db.Query("UPDATE neb_config SET value=? WHERE name=?", value, name)
	if err != nil {
		Error.Println("Failed to update config : ", value, name)
		return err
	}
	(*c)[name] = value
	return nil
}
