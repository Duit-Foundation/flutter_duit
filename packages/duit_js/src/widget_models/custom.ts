import { BaseAction } from "../lib/action";
import DuitElementType from "../lib/element_type";
import { DuitLeafElement, MultiChildLayout, SingleChildLayout } from "./child";

export class CustomTreeElement<T> extends DuitLeafElement {
    type = DuitElementType.custom as const;
    attributes: T;
    tag: string;

    constructor(attrs: T, tag: string, id?: string, action?: BaseAction, controlled?: boolean) {
        super(id, action, controlled);
        this.attributes = attrs;
        this.tag = tag;
    }
}

export class CustomSingleChildWidget<T> extends SingleChildLayout {
    type = DuitElementType.custom as const;
    attributes: T;
    tag: string;

    constructor(attrs: T, tag: string, id?: string, action?: BaseAction, controlled?: boolean) {
        super(id, action, controlled);
        this.attributes = attrs;
        this.tag = tag;
    }
}

export class CustomMultiChildWidget<T> extends MultiChildLayout {
    type = DuitElementType.custom as const;
    attributes: T;
    tag: string;

    constructor(attrs: T, tag: string, id?: string, action?: BaseAction, controlled?: boolean) {
        super(id, action, controlled);
        this.attributes = attrs;
        this.tag = tag;
    }
}