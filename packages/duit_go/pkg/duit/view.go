package duit

import (
	"encoding/json"
	"os"

	"github.com/lesleysin/duit/packages/duit_go/pkg/duit_core"
)

type DuitView struct{}

func (view *DuitView) Static(filePath string) (*duit_core.DuitElementModel, error) {
	jsonObj, err := os.ReadFile(filePath)

	if err != nil {
		return nil, err
	}

	var root *duit_core.DuitElementModel

	err = json.Unmarshal(jsonObj, root)

	if err != nil {
		return nil, err
	}

	return root, nil
}

func (view *DuitView) Builder() *UiBuilder {
	return &UiBuilder{}
}
