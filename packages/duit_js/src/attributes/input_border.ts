import { Color } from "../utils/color";

type Border = "outline" | "underline";
type BorderStyle = "solid" | "none";
export interface InputBorder {
    type: Border;
    options?: {
        borderSide?: {
            color?: Color;
            width?: number;
            style?: BorderStyle;
        }
        gapPadding: number;
        borderRadius: number;
    }
}