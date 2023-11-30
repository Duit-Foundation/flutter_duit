package duit_widget

import (
	attrs "github.com/lesleysin/duit/packages/duit_go/pkg/duit_attributes"
	core "github.com/lesleysin/duit/packages/duit_go/pkg/duit_core"
)

func TextUiElement(attributes *attrs.TextAttributes, id string, controlled bool, action *core.Action) *core.DuitElementModel {
	return new(core.DuitElementModel).CreateElement(core.Text, id, "", attributes, action, controlled)
}
