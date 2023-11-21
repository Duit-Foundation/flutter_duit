import DuitElementType from "../lib/element_type";
import { SingleChildLayout } from "./child";

import type { SizedBoxAttributes } from "../attributes/sized_box_attributes";
  
  export class SizedBoxUiElement extends SingleChildLayout {
    type = DuitElementType.coloredBox as const;
    attributes: SizedBoxAttributes;
  
    constructor(attrs: SizedBoxAttributes, id?: string) {
      super(id);
      this.attributes = attrs;
    }
  }