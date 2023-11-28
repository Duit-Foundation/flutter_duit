package duit

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

func (b *UiBuilder) CreateRootOfExactType(elType DuitElementType) *DuitElement {
	b.root = &DuitElement{
		ElementType: elType,
	}

	return b.root
}
