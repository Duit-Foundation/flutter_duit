package main

import "github.com/lesleysin/duit/packages/duit_go/pkg/duit"

func main() {
	var view duit.DuitView

	builder := view.Builder()

	builder.CreateRootOfExactType(duit.Column)

	duit.TextUiElement("", &duit.TextAttributes{}, false, nil)
}
