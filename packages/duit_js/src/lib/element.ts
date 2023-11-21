import { ColoredBoxUiElement, ColumnUiElement, RowUiElement, SizedBoxUiElement, TextUiElement } from "../widget_models";
import DuitElementType from "./element_type";

export type DuitLayoutElement = ColumnUiElement | RowUiElement | ColoredBoxUiElement | SizedBoxUiElement;
export type DuitElement = TextUiElement | DuitLayoutElement;