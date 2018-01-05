package main
import (
	"fmt"
	"net/http"
	"io"
)

func helloHandler(w http.ResponseWriter, r *http.Request) {
	io.WriteString(w, "Hello world!\n")
}


func main() {
	fmt.Println("HTTP Server starts at port 80")
	http.HandleFunc("/", helloHandler)
	http.ListenAndServe(":8080", nil)
}
