import type { Color } from "../utils/color";
import type { FontWeight } from "./font_weight";

export interface TextStyle {
    color?: Color;
    fontFamily?: string;
    fontSize?: number;
    fontWeight?: FontWeight;
    letterSpacing?: number;
    wordSpacing?: number;
    height?: number;
}