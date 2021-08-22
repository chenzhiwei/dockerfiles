package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
	"time"
)

func rootHandler(w http.ResponseWriter, r *http.Request) {
	host, _ := os.Hostname()
	resp := fmt.Sprintf("time=%v, host=%s, uri=%s\n", time.Now().UTC(), host, r.RequestURI)
	fmt.Println(resp)
	io.WriteString(w, resp)
}

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/", rootHandler)
	http.ListenAndServe(":8080", mux)
}
