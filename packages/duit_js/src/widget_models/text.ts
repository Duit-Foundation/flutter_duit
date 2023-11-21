import DuitElementType from "../lib/element_type";
import { DuitWidget } from "./child";

import type { TextAttributes } from "../attributes";
  
  export class TextUiElement extends DuitWidget {
    type = DuitElementType.text as const;
    attributes: TextAttributes;
  
    constructor(attrs: TextAttributes, id?: string) {
      super(id);
      this.attributes = attrs;
    }
  }