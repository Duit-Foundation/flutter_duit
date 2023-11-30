package duit_attributes

type TextAttributes struct {
	Data            string        `json:"data"`
	SemanticsLabel  string        `json:"semanticsLabel,omitempty"`
	TextAlign       TextAlign     `json:"textAlign,omitempty"`
	TextDirection   TextDirection `json:"textDirection,omitempty"`
	TextOverflow    TextOverflow  `json:"textOverflow,omitempty"`
	SoftWrap        bool          `json:"softWrap,omitempty"`
	TextScaleFactor float32       `json:"textScaleFactor,omitempty"`
	MaxLines        int           `json:"maxLines,omitempty"`
}
