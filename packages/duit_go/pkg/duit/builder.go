package duit

import (
	"encoding/json"
	"errors"

	"github.com/lesleysin/duit/packages/duit_go/pkg/duit_core"
)

type UiBuilder struct {
	root *duit_core.DuitElementModel
}

func (builder *UiBuilder) Build() (string, error) {
	json, err := json.Marshal(*builder.root)

	if err != nil {
		return "", errors.New("Failed to build JSON: " + err.Error())
	}

	return string(json), nil
}

func (builder *UiBuilder) CreateRoot() *duit_core.DuitElementModel {
	builder.root = &duit_core.DuitElementModel{
		ElementType: duit_core.Column,
	}
	return builder.root
}

func (builder *UiBuilder) CreateRootOfExactType(elType duit_core.DuitElementType, attributes interface{}, id string, tag string) *duit_core.DuitElementModel {
	builder.root = new(duit_core.DuitElementModel).CreateElement(elType, id, tag, attributes, nil, false)

	return builder.root
}
