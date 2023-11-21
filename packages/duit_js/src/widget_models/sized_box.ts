import DuitElementType from "../lib/element_type";
import { SingleChildLayout } from "./child";

import type { SizedBoxAttributes } from "../attributes/sized_box_attributes";
import { BaseAction } from "../lib/action";

export class SizedBoxUiElement extends SingleChildLayout {
  type = DuitElementType.sizedBox as const;
  attributes: SizedBoxAttributes;

  constructor(attrs: SizedBoxAttributes, id?: string, action?: BaseAction, controlled?: boolean) {
    super(id, action, controlled);
    this.attributes = attrs;
  }
}