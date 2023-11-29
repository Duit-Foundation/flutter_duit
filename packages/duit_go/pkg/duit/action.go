package duit

type Action struct {
	Event     string      `json:"event"`
	DependsOn []string    `json:"dependsOn"`
	Meta      interface{} `json:"meta,omitempty"`
}
