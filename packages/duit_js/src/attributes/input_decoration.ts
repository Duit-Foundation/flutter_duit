import { Color } from "../utils/color";
import { EdgeInsets } from "../utils/insets";
import { InputBorder } from "./input_border";
import { TextStyle } from "./text_style";

export interface InputDecoration {
    labelText?: string;
    labelStyle?: TextStyle;
    floatingLabelStyle?: TextStyle;
    helperText?: string;
    helperMaxLines?: number;
    helperStyle?: TextStyle;
    hintText?: string;
    hintStyle?: TextStyle;
    hintMaxLines?: number;
    errorText?: string;
    errorMaxLines?: number;
    errorStyle?: TextStyle;
    border?: InputBorder;
    errorBorder?: InputBorder;
    enabledBorder?: InputBorder;
    focusedBorder?: InputBorder;
    focusedErrorBorder?: InputBorder;
    enabled?: boolean;
    isCollapsed?: boolean;
    isDense?: boolean;
    suffixText?: string;
    suffixStyle?: TextStyle;
    prefixText?: string;
    prefixStyle?: TextStyle;
    counterText?: string;
    counterStyle?: TextStyle;
    alignLabelWithHint?: boolean;
    filled?: boolean;
    fillColor?: Color;
    contentPadding?: EdgeInsets;
}