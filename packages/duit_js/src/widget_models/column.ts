import { MultiChildLayout } from "./child";
import DuitElementType from "../element_type";
import { FlexAttributes } from "./flex_attributes";

export class ColumnUiElement extends MultiChildLayout {
    type = DuitElementType.column as const;
    attributes: FlexAttributes;
  
    constructor(attrs: FlexAttributes, id?: string) {
      super(id);
      this.attributes = attrs;
    }
  }