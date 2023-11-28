package core

import "encoding/json"

type UiBuilder struct {
	root *DuitElement
}

func (builder *UiBuilder) Build() string {
	json, err := json.Marshal(builder.root)

	if err != nil {

		println(err)
		return ""
	}

	return string(json)
}

func (b *UiBuilder) CreateRoot() *DuitElement {
	b.root = &DuitElement{
		ElementType: Column,
	}
	return b.root
}

func (b *UiBuilder) CreateRootOfExactType(elType DuitElementType, data *DuitElementConstructorParams) *DuitElement {
	b.root = &DuitElement{
		ElementType: elType,
		Id:          data.Id,
		Controlled:  data.Controlled,
		Tag:         data.Tag,
		Action:      &data.Action,
	}

	return b.root
}
