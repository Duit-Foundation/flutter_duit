import { randomUUID } from "crypto";
import { DuitElement } from "../lib/element";
import { Nullable } from "../utils/nullable";
import { ID } from "../utils/id";
import { BaseAction } from "../lib/action";

export class DuitTreeElement {
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

export class SingleChildLayout extends DuitTreeElement {
  protected child: Nullable<DuitElement>;

  constructor(id?: string, action?: BaseAction, controlled?: boolean) {
    super(id, action, controlled);
  }

  addChild<T extends DuitElement>(child: T) {
    this.child = child;
    return child;
  }
}

export class MultiChildLayout extends DuitTreeElement {
  protected children: Nullable<DuitElement[]> = [];

  constructor(id?: string, action?: BaseAction, controlled?: boolean) {
    super(id, action, controlled);
  }

  addChild<T extends DuitElement>(child: T) {
    this.children?.push(child);
    return child;
  }
}