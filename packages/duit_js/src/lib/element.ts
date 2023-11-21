import { CenterUiElement, ColoredBoxUiElement, ColumnUiElement, RowUiElement, SizedBoxUiElement, TextUiElement } from "../widget_models";

export type DuitLayoutElement = ColumnUiElement | RowUiElement | ColoredBoxUiElement | SizedBoxUiElement | CenterUiElement;
export type DuitElement = TextUiElement | DuitLayoutElement;