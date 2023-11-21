import { MultiChildLayout } from "./child";
import DuitElementType from "../lib/element_type";

import type { FlexAttributes } from "../attributes";
import { BaseAction } from "../lib/action";

export class RowUiElement extends MultiChildLayout {
  type = DuitElementType.row as const;
  attributes: FlexAttributes;

  constructor(attrs: FlexAttributes, id?: string, action?: BaseAction, controlled?: boolean) {
    super(id, action, controlled);
    this.attributes = attrs;
  }
}