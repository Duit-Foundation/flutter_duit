import { ColoredBoxUiElement, ColumnUiElement, RowUiElement, TextUiElement } from "../widget_models";
import DuitElementType from "./element_type";

export type DuitLayoutElement = ColumnUiElement | RowUiElement | ColoredBoxUiElement;
export type DuitElement = TextUiElement | DuitLayoutElement;

export type Xx = {
    [DuitElementType.column]: ColumnUiElement;
    [DuitElementType.row]: RowUiElement;
    [DuitElementType.coloredBox]: ColoredBoxUiElement;
    [DuitElementType.text]: TextUiElement;
}