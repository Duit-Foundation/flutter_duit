import { SingleChildLayout } from "./child";
import DuitElementType from "../lib/element_type";

import type { ColoredBoxAttributes } from "../attributes";
  
  export class ColoredBoxUiElement extends SingleChildLayout {
    type = DuitElementType.coloredBox as const;
    attributes: ColoredBoxAttributes;
  
    constructor(attrs: ColoredBoxAttributes, id?: string) {
      super(id);
      this.attributes = attrs;
    }
  }