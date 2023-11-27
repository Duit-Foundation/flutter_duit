import DuitElementType from "../lib/element_type";
import { MultiChildLayout } from "./child";

import type { BaseAction } from "../lib/action";
import type { StackAttributes } from "../attributes/stack_attributes";

export class StackUiElement extends MultiChildLayout {
    type = DuitElementType.stack as const;
    attributes: StackAttributes;

    constructor(attrs: StackAttributes, id?: string, action?: BaseAction, controlled?: boolean) {
        super(id, action, controlled);
        this.attributes = attrs;
    }
}