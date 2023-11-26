import DuitElementType from "../lib/element_type";
import { DuitLeafElement } from "./child";

import type { TextAttributes } from "../attributes";
import { BaseAction } from "../lib/action";

export class TextUiElement extends DuitLeafElement {
  type = DuitElementType.text as const;
  attributes: TextAttributes;

  constructor(attrs: TextAttributes, id?: string, action?: BaseAction, controlled?: boolean) {
    super(id, action, controlled);
    this.attributes = attrs;
  }
}