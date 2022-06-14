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
	resp := fmt.Sprintf("time=%v, host=%s, method=%s, uri=%s\n", time.Now().Format("20060102T150405Z0700"), host, r.Method, r.RequestURI)
	fmt.Println(resp)
	io.WriteString(w, resp)
}

func main() {
	addr := os.Getenv("ADDR")
	if addr == "" {
		addr = ":8080"
	}

	mux := http.NewServeMux()
	mux.HandleFunc("/", rootHandler)
	http.ListenAndServe(addr, mux)
}
