package duit

type TextAttributes struct {
	Data string `json:"data"`
}

func TextUiElement(attributes *TextAttributes, id string, controlled bool, action *Action) *DuitElementModel {
	return new(DuitElementModel).CreateElement(Text, id, "", attributes, action, controlled)
}
