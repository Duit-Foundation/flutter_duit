package internal

import "github.com/lesleysin/duit/packages/duit_go/pkg/duit"

type CustomWidget struct {
	duit.DuitCustomWidget
}

type CustomWidgetAttrs struct {
	Duit int
}

func (widget *CustomWidget) CreateElement(elemType duit.DuitElementType, elemId string, tag string, attributes *CustomWidgetAttrs, action *duit.Action, controlled bool) *duit.DuitElementModel {
	model := new(duit.DuitElementModel)
	model.ElementType = elemType
	model.Id = elemId
	model.Tag = tag
	model.Attributes = attributes
	model.Action = action
	return model
}

func CustomWidgetUiElement() *duit.DuitElementModel {
	return new(CustomWidget).CreateElement(duit.Custom, "", "CustomWidget", &CustomWidgetAttrs{Duit: 100500}, nil, false)
}
