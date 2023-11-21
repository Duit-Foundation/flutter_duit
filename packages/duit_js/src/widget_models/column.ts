import { MultiChildLayout } from "./child";
import DuitElementType from "../lib/element_type";

import type { FlexAttributes } from "../attributes";

export class ColumnUiElement extends MultiChildLayout {
    type = DuitElementType.column as const;
    attributes: FlexAttributes;
  
    constructor(attrs: FlexAttributes, id?: string) {
      super(id);
      this.attributes = attrs;
    }
  }