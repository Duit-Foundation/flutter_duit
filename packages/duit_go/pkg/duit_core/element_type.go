package duit_core

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
