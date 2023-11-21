import { MultiChildLayout } from "./child";
import DuitElementType from "../lib/element_type";

import type { FlexAttributes } from "../attributes";


export class RowUiElement extends MultiChildLayout {
    type = DuitElementType.row as const;
    attributes: FlexAttributes;
  
    constructor(attrs: FlexAttributes, id?: string) {
      super(id);
      this.attributes = attrs;
    }
  }