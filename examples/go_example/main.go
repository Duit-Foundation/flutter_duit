package main

import (
	"fmt"
	"goexample/internal"

	"github.com/lesleysin/duit/packages/duit_go/pkg/duit"
)

func main() {
	var view duit.DuitView

	builder := view.Builder()
	root := builder.CreateRootOfExactType(duit.Column, nil, "", "")

	ch := duit.TextUiElement(&duit.TextAttributes{}, "", false, nil)
	ch2 := duit.TextUiElement(&duit.TextAttributes{}, "", false, nil)

	root.AddChild(ch).AddChild(ch2).AddChild(internal.CustomWidgetUiElement())

	x, err := builder.Build()

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println(x)
}
