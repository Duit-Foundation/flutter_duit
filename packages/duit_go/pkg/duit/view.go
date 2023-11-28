package duit

import (
	"encoding/json"
	"os"
)

type DuitView struct{}

func (view *DuitView) Static(filePath string) (*DuitElement, error) {
	jsonObj, err := os.ReadFile(filePath)

	if err != nil {
		return nil, err
	}

	var root *DuitElement

	err = json.Unmarshal(jsonObj, root)

	if err != nil {
		return nil, err
	}

	return root, nil
}

func (view *DuitView) Builder() *UiBuilder {
	return &UiBuilder{}
}
