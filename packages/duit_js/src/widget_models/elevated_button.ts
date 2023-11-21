import { SingleChildLayout } from "./child";
import DuitElementType from "../lib/element_type";

import type { ElevatedButtonAttributes } from "../attributes";
import { BaseAction } from "../lib/action";

export class ElevatedButtonUiElement extends SingleChildLayout {
    type = DuitElementType.elevatedButton as const;
    attributes: ElevatedButtonAttributes;

    constructor(attrs: ElevatedButtonAttributes, id?: string, action?: BaseAction, controlled?: boolean) {
        super(id, action, controlled);
        this.attributes = attrs;
    }
}