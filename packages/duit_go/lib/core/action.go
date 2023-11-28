package core

type action struct {
	Event     string   `json:"event"`
	DependsOn []string `json:"dependsOn"`
}

type HttpActionMetainfo struct {
	Method string `json:"method"`
}

type HttpAction struct {
	action
	meta HttpActionMetainfo `json:"meta"`
}

type WebSocketAction struct {
	action
}

type Action interface {
	HttpAction | WebSocketAction
}

func (a *HttpAction) New(event string, dependsOn []string, meta HttpActionMetainfo) *HttpAction {
	return &HttpAction{
		action: action{
			Event:     event,
			DependsOn: dependsOn,
		},
		meta: meta,
	}
}

func (a *WebSocketAction) New(event string, dependsOn []string) *WebSocketAction {
	return &WebSocketAction{
		action: action{
			Event:     event,
			DependsOn: dependsOn,
		},
	}
}
