package duit

import "github.com/lesleysin/duit/packages/duit_go/internal/core"

type HttpActionMetainfo struct {
	Method string `json:"method"`
}

func CreateHttpAction(event string, dependsOn []string, metainfo *HttpActionMetainfo) *core.Action {
	return &core.Action{
		Event:     event,
		DependsOn: dependsOn,
		Meta:      *metainfo,
	}
}

func CreateWebSocketAction(event string, dependsOn []string) *core.Action {
	return &core.Action{
		Event:     event,
		DependsOn: dependsOn,
	}
}
