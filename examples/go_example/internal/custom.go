package internal

import (
	"github.com/lesleysin/duit_go/pkg/duit_core"
)

type CustomWidget struct {
	duit_core.Action
}

type CustomWidgetAttrs struct {
	Duit int `json:"duit"`
}

func (widget *CustomWidget) CreateElement(elemType duit_core.DuitElementType, elemId string, tag string, attributes *CustomWidgetAttrs, action *duit_core.Action, controlled bool) *duit_core.DuitElementModel {
	model := new(duit_core.DuitElementModel)
	model.ElementType = elemType
	model.Id = elemId
	model.Tag = tag
	model.Attributes = attributes
	model.Action = action
	return model
}

func CustomWidgetUiElement() *duit_core.DuitElementModel {
	return new(CustomWidget).CreateElement(duit_core.Custom, "", "CustomWidget", &CustomWidgetAttrs{Duit: 100500}, nil, false)
}
