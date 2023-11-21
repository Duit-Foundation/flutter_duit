import { randomUUID } from "crypto";
import { DuitElement } from "../lib/element";
import { Nullable } from "../utils/nullable";

export class DuitWidget {
  id: string;
  controlled;

  constructor(id?: string, controlled?: boolean) {
    this.controlled = controlled ?? false;
    if (id) {
      this.id = id;
    } else {
      this.id = randomUUID();
    }
  }
}

export class SingleChildLayout extends DuitWidget {
  protected child: Nullable<DuitElement>;

  constructor(id?: string, controlled?: boolean) {
    super(id, controlled);
  }

  addChild<T extends DuitElement>(child: T) {
    this.child = child;
    return child;
  }
}

export class MultiChildLayout extends DuitWidget {
  protected children: Nullable<DuitElement[]> = [];

  constructor(id?: string, controlled?: boolean) {
    super(id, controlled);
  }

  addChild<T extends DuitElement>(child: T) {
    this.children?.push(child);
    return child;
  }
}