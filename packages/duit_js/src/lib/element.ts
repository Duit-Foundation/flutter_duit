import { CenterUiElement, ColoredBoxUiElement, ColumnUiElement, RowUiElement, SizedBoxUiElement, StackUiElement, TextFieldUiElement, TextUiElement } from "../widget_models";

export type DuitLayoutElement =
    ColumnUiElement
    | RowUiElement
    | ColoredBoxUiElement
    | SizedBoxUiElement
    | CenterUiElement
    | StackUiElement;
    
export type DuitElement =
    TextUiElement
    | TextFieldUiElement
    | DuitLayoutElement;