import { SingleChildLayout } from "./child";
import DuitElementType from "../lib/element_type";

import type { CenterAttributes } from "../attributes";
import { BaseAction } from "../lib/action";

export class CenterUiElement extends SingleChildLayout {
  type = DuitElementType.center as const;
  attributes: CenterAttributes;

  constructor(attrs: CenterAttributes, id?: string, action?: BaseAction, controlled?: boolean) {
    super(id, action, controlled);
    this.attributes = attrs;
  }
}