import { ExpandedAttributes } from "../attributes";
import { BaseAction } from "../lib/action";
import DuitElementType from "../lib/element_type";
import { DuitLeafElement, SingleChildLayout } from "./child";

export class ExpandedUiElement extends SingleChildLayout {
    type = DuitElementType.expanded as const
    attributes: ExpandedAttributes
    constructor(attrs: ExpandedAttributes, id?: string, action?: BaseAction, controlled?: boolean) {
        super(id, action, controlled);
        this.attributes = attrs;
    }
}