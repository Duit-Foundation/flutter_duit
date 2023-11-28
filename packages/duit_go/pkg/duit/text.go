package duit

type TextAttributes struct {
	Data string `json:"data"`
}

func TextUiElement(id string, attributes *TextAttributes, controlled bool, action interface{}) *DuitElement {
	var newElem DuitElement
	return newElem.New(Text, id)
}
