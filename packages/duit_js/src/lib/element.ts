import { CenterUiElement, ColoredBoxUiElement, ColumnUiElement, RowUiElement, SizedBoxUiElement, StackUiElement, TextFieldUiElement, TextUiElement } from "../widget_models";
import { ExpandedUiElement } from "../widget_models/expanded";

export type DuitLayoutElement =
    ColumnUiElement
    | RowUiElement
    | ColoredBoxUiElement
    | SizedBoxUiElement
    | CenterUiElement
    | StackUiElement
    | ExpandedUiElement;
    
export type DuitElement =
    TextUiElement
    | TextFieldUiElement
    | DuitLayoutElement;