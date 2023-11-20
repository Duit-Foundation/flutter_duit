import DuitElementType from "../element_type";
import { DuitWidget } from "./child";

interface TextAttributes {
    data?: string;
  }
  
  export class TextUiElement extends DuitWidget {
    type = DuitElementType.text as const;
    attributes: TextAttributes;
  
    constructor(attrs: TextAttributes, id?: string) {
      super(id);
      this.attributes = attrs;
    }
  }