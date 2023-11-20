import { randomUUID } from "crypto";
import { DuitElement } from "../element";
import { Nullable } from "../nullable";

export class DuitWidget {
  id: string;
  
  constructor(id?: string) {
    if (id) {
      this.id = id;
    } else {
      this.id = randomUUID();
    }
  }
}

class DuitLayout extends DuitWidget {
  constructor(id?: string) {
    super(id);
  }

  closeTree() {
    return this;
  }
}

export class SingleChildLayout extends DuitLayout {
  protected child: Nullable<DuitElement>;

  constructor(id?: string) {
    super(id);
  }

  addChild(child: DuitElement): DuitElement {
    this.child = child;
    return child;
  }
}

export class MultiChildLayout extends DuitLayout {
  protected children: Nullable<DuitElement[]> = [];

  constructor(id?: string) {
    super(id);
  }

  addChild(child: DuitElement): DuitElement {
    this.children?.push(child);
    return child;
  }
}