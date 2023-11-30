package duit

import "github.com/lesleysin/duit/packages/duit_go/pkg/duit_core"

type HttpActionMetainfo struct {
	Method string `json:"method"`
}

func CreateHttpAction(event string, dependsOn []string, metainfo *HttpActionMetainfo) *duit_core.Action {
	return &duit_core.Action{
		Event:     event,
		DependsOn: dependsOn,
		Meta:      *metainfo,
	}
}

func CreateWebSocketAction(event string, dependsOn []string) *duit_core.Action {
	return &duit_core.Action{
		Event:     event,
		DependsOn: dependsOn,
	}
}
