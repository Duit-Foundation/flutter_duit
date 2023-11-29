package duit

import (
	"encoding/json"
	"errors"
)

type UiBuilder struct {
	root *DuitElementModel
}

func (builder *UiBuilder) Build() (string, error) {
	json, err := json.Marshal(*builder.root)

	if err != nil {
		return "", errors.New("Failed to build JSON: " + err.Error())
	}

	return string(json), nil
}

func (builder *UiBuilder) CreateRoot() *DuitElementModel {
	builder.root = &DuitElementModel{
		ElementType: Column,
	}
	return builder.root
}

func (builder *UiBuilder) CreateRootOfExactType(elType DuitElementType, attributes interface{}, id string, tag string) *DuitElementModel {
	builder.root = new(DuitElementModel).CreateElement(elType, id, tag, attributes, nil, false)

	return builder.root
}
