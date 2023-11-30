package duit_core

import (
	"github.com/google/uuid"
)

// 0 - cannot have children
//
// 1 - single child model
//
// 2 - multi child model
var childMapper = map[DuitElementType]uint8{
	SizedBox:       0,
	ElevatedButton: 0,
	Text:           0,
	TextField:      0,
	Empty:          0,
	Custom:         0,
	ColoredBox:     1,
	Center:         1,
	Row:            2,
	Column:         2,
	Stack:          2,
}

type DuitCustomWidget interface {
	CreateElement(elemType string, elemId string, tag string, attributes interface{}, action *Action, controlled bool) *DuitElementModel
}

type DuitElementModel struct {
	DuitCustomWidget
	ElementType DuitElementType     `json:"type"`
	Id          string              `json:"id"`
	Controlled  bool                `json:"controlled"`
	Attributes  interface{}         `json:"attributes"`
	Action      *Action             `json:"action,omitempty"`
	Tag         string              `json:"tag,omitempty"`
	Child       *DuitElementModel   `json:"child,omitempty"`
	Children    []*DuitElementModel `json:"children,omitempty"`
}

// CreateElement creates a new instance of DuitElement.
//
// It takes the following parameters:
// - elemType: the type of the element
// - elemId: the ID of the element (optional)
// - tag: the tag of the element
// - attributes: the attributes of the element
// - action: the action associated with the element (optional)
// - controlled: a boolean indicating whether the element is controlled
//
// It returns a pointer to the newly created DuitElement.
func (element *DuitElementModel) CreateElement(elemType DuitElementType, elemId string, tag string, attributes interface{}, action *Action, controlled bool) *DuitElementModel {
	var id string
	var isControlled bool

	if elemId == "" {
		id = uuid.NewString()
	} else {
		id = elemId
	}

	if action != nil {
		isControlled = true
	} else {
		isControlled = controlled
	}

	element.Id = id
	element.ElementType = elemType
	element.Action = action
	element.Attributes = attributes
	element.Tag = tag
	element.Controlled = isControlled
	return element
}

// AddChild adds a child element to the DuitElement.
//
// The child parameter is the element to be added as a child.
// The function returns the modified DuitElement.
func (element *DuitElementModel) AddChild(child *DuitElementModel) *DuitElementModel {
	childProp := childMapper[element.ElementType]

	switch childProp {
	case 1:
		element.Child = child
	case 2:
		element.Children = append(element.Children, child)
	}

	return element
}

// AddChildren adds the specified children to the DuitElement.
//
// It accepts a slice of *DuitElement as the children parameter.
// It returns a *DuitElement, which is the modified DuitElement.
//
// If DuitElement may contains only one child element, last element of slice will be added as child
func (element *DuitElementModel) AddChildren(children []*DuitElementModel) *DuitElementModel {
	childProp := childMapper[element.ElementType]

	switch childProp {
	case 1:
		element.Child = children[len(children)-1]
	case 2:
		element.Children = append(element.Children, children...)
	}

	return element
}
