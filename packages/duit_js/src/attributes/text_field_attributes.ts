import { InputBorder } from "./input_border";
import { InputDecoration } from "./input_decoration";
import { TextAlign } from "./text_align";
import { TextDirection } from "./text_direction";
import { TextStyle } from "./text_style";

export interface TextFieldAttributes {
    style?: TextStyle;
    decoration?: InputDecoration;
    textAlign?: keyof typeof TextAlign;
    textDirection?: keyof typeof TextDirection;
    autocorrect?: boolean;
    enableSuggestions?: boolean;
    expands?: boolean;
    readOnly?: boolean;
    showCursor?: boolean;
    enabled?: boolean;
    obscureText?: boolean;
    autofocus?: boolean;
    obscuringCharacter?: string;
    maxLines?: number;
    minLines?: number;
    maxLength?: number;
    border?: InputBorder;
    errorBorder?: InputBorder;
    enabledBorder?: InputBorder;
    focusedBorder?: InputBorder;
    focusedErrorBorder?: InputBorder;
}