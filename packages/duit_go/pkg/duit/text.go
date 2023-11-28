package duit

import "github.com/lesleysin/duit/packages/duit_go/internal/core"

type TextAttributes struct {
	Data string `json:"data"`
}

func TextUiElement(attributes *TextAttributes, id string, controlled bool, action *core.Action) *DuitElement {
	var newElem DuitElement
	return newElem.New(Text, id, "", attributes, action, controlled)
}
