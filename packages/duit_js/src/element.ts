import { ColoredBoxUiElement, ColumnUiElement, RowUiElement, TextUiElement } from "./widget_models";

export type DuitLayoutElement = ColumnUiElement | RowUiElement | ColoredBoxUiElement;
export type DuitElement = TextUiElement | DuitLayoutElement;