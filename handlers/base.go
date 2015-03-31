package handlers

import (
	"encoding/json"
	"fmt"
	"github.com/Nebuleuse/Nebuleuse/core"
	"github.com/gorilla/mux"
	"net/http"
)

func RegisterHandlers() {
	r := mux.NewRouter()
	r.HandleFunc("/", status)
	r.HandleFunc("/status", status).Methods("GET")
	r.HandleFunc("/connect", connectUser).Methods("POST")
	r.HandleFunc("/disconnect", disconnectUser).Methods("POST")
	r.HandleFunc("/getUserInfos", getUserInfos).Methods("POST")
	r.HandleFunc("/updateAchievements", updateAchievements).Methods("POST")
	r.HandleFunc("/updateStats", updateStats).Methods("POST")
	r.HandleFunc("/addComplexStats", addComplexStats).Methods("POST")
	r.HandleFunc("/longpoll", longPollRequest).Methods("POST")
	r.HandleFunc("/sendMessage", sendMessage).Methods("POST")
	r.HandleFunc("/subscribeTo", subscribeTo).Methods("POST")
	http.Handle("/", r)
}

type easyResponse struct {
	Code    int
	Message string
}

func EasyResponse(code int, message string) string {
	e := easyResponse{code, message}
	res, err := json.Marshal(e)
	if err != nil {
		core.Warning.Println("Could not encode easy response")
	}

	return string(res)
}
func EasyErrorResponse(code int, err error) string {
	v, ok := err.(core.NebuleuseError)
	var e easyResponse
	if ok {
		e = easyResponse{v.Code, v.Msg}
	} else {
		e = easyResponse{code, err.Error()}
	}
	res, err := json.Marshal(e)
	if err != nil {
		core.Warning.Println("Could not encode easy response")
	}

	return string(res)
}

type statusResponse struct {
	Maintenance       bool
	NebuleuseVersion  int
	GameVersion       int
	UpdaterVersion    int
	ComplexStatsTable []core.ComplexStatTableInfo
}

func status(w http.ResponseWriter, r *http.Request) {
	CStatsInfos, err := core.GetComplexStatsTablesInfos()
	if err != nil {
		fmt.Fprint(w, EasyErrorResponse(core.NebError, err))
		return
	}
	response := statusResponse{false, core.NebuleuseVersion, core.GetGameVersion(), core.GetUpdaterVersion(), CStatsInfos}

	if core.Cfg["maintenance"] != "0" {
		response.Maintenance = true
	}

	res, err := json.Marshal(response)
	if err != nil {
		core.Warning.Println("Could not encode status response")
		fmt.Fprint(w, EasyErrorResponse(core.NebError, err))
	} else {
		fmt.Fprint(w, string(res))
	}
}

func subscribeTo(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	if r.PostForm["sessionid"] == nil && r.PostForm["channel"] == nil {
		fmt.Fprint(w, EasyResponse(core.NebError, "Missing sessionid or channel"))
		return
	}

	user, err := core.GetUserBySession(r.PostForm["sessionid"][0], core.UserMaskOnlyId)
	if err != nil {
		fmt.Fprint(w, EasyErrorResponse(core.NebErrorDisconnected, err))
	}

	core.Listen(r.FormValue("channel"), user.Id)
}
