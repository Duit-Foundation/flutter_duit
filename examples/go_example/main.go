package main

import (
	"encoding/json"
	"fmt"
)

type Nested struct {
	id  string `json:"id"`
	num int    `json:"num"`
}

type Test struct {
	n    Nested   `json:"n"`
	narr []Nested `json:"narr"`
}

func main() {
	var x = Test{
		n: Nested{
			id:  "1",
			num: 1,
		},
		narr: nil,
	}
	json, _ := json.Marshal(x)
	fmt.Println(string(json))
}
