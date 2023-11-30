package duit_core

type eventType string

const (
	update eventType = "update"
)

type event struct {
	Type eventType `json:"type"`
}

type updateEvent struct {
	event
	Updates map[string]interface{} `json:"updates"`
}

// NewUpdateEvent creates a new update event.
//
// It takes a map of updates as a parameter.
// It returns a pointer to an updateEvent.
func NewUpdateEvent(updates map[string]interface{}) *updateEvent {
	return &updateEvent{
		event: event{
			Type: update,
		},
		Updates: updates,
	}
}
