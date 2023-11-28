package core

import "github.com/google/uuid"

type DuitElementType string

const (
	SizedBox       DuitElementType = "SizedBox"
	Row            DuitElementType = "Row"
	Column         DuitElementType = "Column"
	Stack          DuitElementType = "Stack"
	ColoredBox     DuitElementType = "ColoredBox"
	Text           DuitElementType = "Text"
	TextField      DuitElementType = "TextField"
	Empty          DuitElementType = "Empty"
	Custom         DuitElementType = "Custom"
	Center         DuitElementType = "Center"
	ElevatedButton DuitElementType = "ElevatedButton"
)

// 0 - cannot have children
//
// 1 - single child model
//
// 2 - multi child model
var childMapper = map[DuitElementType]int8{
	SizedBox:       0,
	Row:            2,
	Column:         2,
	Stack:          2,
	ColoredBox:     1,
	Text:           0,
	TextField:      0,
	Empty:          0,
	Custom:         0,
	Center:         1,
	ElevatedButton: 0,
}

type DuitElement struct {
	ElementType DuitElementType `json:"type"`
	Id          string          `json:"id"`
	Controlled  bool            `json:"controlled"`
	Attributes  interface{}     `json:"attributes"`
	Action      interface{}     `json:"action,omitempty"`
	Tag         string          `json:"tag,omitempty"`
	Child       *DuitElement    `json:"child,omitempty"`
	Children    []*DuitElement  `json:"children,omitempty"`
}

type DuitElementConstructorParams struct {
	Id         string
	Controlled bool
	Action     interface{}
	Tag        string
}

type TextAttributes struct {
	Data string `json:"data"`
}

func TextUiElement(id string, attributes *TextAttributes, controlled bool, action interface{}) *DuitElement {
	var newElem DuitElement
	return newElem.new(Text, id)
}

func (e *DuitElement) new(elemType DuitElementType, elemId string) *DuitElement {
	var id string

	if elemId == "" {
		id = uuid.NewString()
	} else {
		id = elemId
	}

	e.Id = id
	e.ElementType = elemType
	return e
}
