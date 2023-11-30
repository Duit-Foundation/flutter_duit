package main

import (
	"fmt"
	"goexample/internal"

	"github.com/lesleysin/duit/packages/duit_go/pkg/duit"
	"github.com/lesleysin/duit/packages/duit_go/pkg/duit_attributes"
	"github.com/lesleysin/duit/packages/duit_go/pkg/duit_core"
	"github.com/lesleysin/duit/packages/duit_go/pkg/duit_widget"
)

func main() {
	var view duit.DuitView

	builder := view.Builder()
	root := builder.CreateRootOfExactType(duit_core.Column, nil, "", "")

	ch := duit_widget.TextUiElement(&duit_attributes.TextAttributes{}, "", false, nil)
	ch2 := duit_widget.TextUiElement(&duit_attributes.TextAttributes{}, "", false, nil)

	root.AddChild(ch).AddChild(ch2).AddChild(internal.CustomWidgetUiElement())

	x, err := builder.Build()

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println(x)
}
