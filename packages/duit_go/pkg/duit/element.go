package duit

import (
	"github.com/google/uuid"
	"github.com/lesleysin/duit/packages/duit_go/internal/core"
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
	Action      *core.Action    `json:"action,omitempty"`
	Tag         string          `json:"tag,omitempty"`
	Child       *DuitElement    `json:"child,omitempty"`
	Children    []*DuitElement  `json:"children,omitempty"`
}

func (e *DuitElement) New(elemType DuitElementType, elemId string) *DuitElement {
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
