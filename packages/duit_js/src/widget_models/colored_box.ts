import { SingleChildLayout } from "./child";
import DuitElementType from "../element_type";

interface ColoredBoxAttributes {
    color?: string;
  }
  
  export class ColoredBoxUiElement extends SingleChildLayout {
    type = DuitElementType.coloredBox as const;
    attributes: ColoredBoxAttributes;
  
    constructor(attrs: ColoredBoxAttributes, id?: string) {
      super(id);
      this.attributes = attrs;
    }
  }