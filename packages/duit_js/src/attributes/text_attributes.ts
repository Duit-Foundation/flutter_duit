import { TextAlign } from "./text_align";
import { TextDirection } from "./text_direction";
import { TextOverflow } from "./text_overflow";
import { TextStyle } from "./text_style";

export interface TextAttributes {
    data: string;
    textAlign?: keyof typeof TextAlign;
    textDirection?: keyof typeof TextDirection;
    softWrap?: boolean;
    overflow?: keyof typeof TextOverflow;
    textScaleFactor?: number;
    maxLines?: number;
    semanticsLabel?: string;
    style?: TextStyle;
}