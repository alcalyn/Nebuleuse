package core

import (
	"strings"
)

type ComplexStatTableInfo struct {
	Name      string
	Fields    []string
	AutoCount bool
}

func GetComplexStatsTableInfos(table string) (ComplexStatTableInfo, error) {
	var values string
	var info ComplexStatTableInfo
	err := Db.QueryRow("SELECT fields, autoCount FROM neb_stats_tables WHERE tableName = ?", table).Scan(&values, &info.AutoCount)
	if err != nil {
		Info.Println("Could not read ComplexStatsTableInfos: ", err)
		return info, err
	}
	info.Fields = strings.Split(values, ",")
	return info, nil
}

func GetComplexStatsTablesInfos() ([]ComplexStatTableInfo, error) {
	var ret = make([]ComplexStatTableInfo, 0)

	rows, err := Db.Query("SELECT tableName, fields, autoCount FROM neb_stats_tables")
	defer rows.Close()

	if err != nil {
		return ret, err
	}

	for rows.Next() {
		var info ComplexStatTableInfo
		var fields string
		err = rows.Scan(&info.Name, &fields, &info.AutoCount)
		if err != nil {
			return ret, err
		}
		info.Fields = strings.Split(fields, ",")
		ret = append(ret, info)
	}

	err = rows.Err()

	if err != nil {
		return ret, err
	}
	return ret, nil
}
