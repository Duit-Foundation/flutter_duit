package duit

type HttpActionMetainfo struct {
	Method string `json:"method"`
}

func CreateHttpAction(event string, dependsOn []string, metainfo *HttpActionMetainfo) *Action {
	return &Action{
		Event:     event,
		DependsOn: dependsOn,
		Meta:      *metainfo,
	}
}

func CreateWebSocketAction(event string, dependsOn []string) *Action {
	return &Action{
		Event:     event,
		DependsOn: dependsOn,
	}
}
