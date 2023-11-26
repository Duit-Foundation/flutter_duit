import { randomUUID } from "crypto";
import { DuitElement } from "../lib/element";
import { Nullable } from "../utils/nullable";
import { ID } from "../utils/id";
import { BaseAction } from "../lib/action";

export class DuitLeafElement {
  protected id: ID;
  protected controlled: boolean;
  protected action: Nullable<BaseAction>;

  constructor(id?: string, action?: BaseAction, controlled?: boolean) {
    this.controlled = controlled ?? action !== undefined ?? false;
    this.action = action;
    if (id) {
      this.id = id;
    } else {
      this.id = randomUUID();
    }
  }
}

export class SingleChildLayout extends DuitLeafElement {
  protected child: Nullable<DuitElement>;

  constructor(id?: string, action?: BaseAction, controlled?: boolean) {
    super(id, action, controlled);
  }

  addChild<T extends DuitElement>(child: T): this {
    this.child = child;
    return this;
  }

}

export class MultiChildLayout extends DuitLeafElement {
  protected children: Nullable<DuitElement[]> = [];

  constructor(id?: string, action?: BaseAction, controlled?: boolean) {
    super(id, action, controlled);
  }

  addChild<T extends DuitElement>(child: T): this {
    this.children?.push(child);
    return this;
  }

  addChildren<T extends DuitElement>(...children: T[]): this
  addChildren<T extends DuitElement>(children: T[] = []): this {
    children.forEach((child) => this.children?.push(child));
    return this;
  }
}