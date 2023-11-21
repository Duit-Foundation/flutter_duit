import { CenterUiElement, ColoredBoxUiElement, ColumnUiElement, RowUiElement, SizedBoxUiElement, TextFieldUiElement, TextUiElement } from "../widget_models";

export type DuitLayoutElement = ColumnUiElement | RowUiElement | ColoredBoxUiElement | SizedBoxUiElement | CenterUiElement;
export type DuitElement = TextUiElement | TextFieldUiElement | DuitLayoutElement;