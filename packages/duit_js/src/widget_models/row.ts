import { MultiChildLayout } from "./child";
import DuitElementType from "../element_type";
import { FlexAttributes } from "./flex_attributes";

export class RowUiElement extends MultiChildLayout {
    type = DuitElementType.row as const;
    attributes: FlexAttributes;
  
    constructor(attrs: FlexAttributes, id?: string) {
      super(id);
      this.attributes = attrs;
    }
  }