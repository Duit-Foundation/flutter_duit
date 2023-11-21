import { CenterUiElement, ColoredBoxUiElement, ColumnUiElement, RowUiElement, SizedBoxUiElement } from "../widget_models";
import DuitElementType from "./element_type";

import type { DuitElement, DuitLayoutElement } from "./element";


export default class UIBuilder {
  private root?: DuitLayoutElement;

  /**
   * Сhecks whether the type of the passed element is a container
   * @param el DuitElement
   * @returns element with layput element type or undefined
   */
  layoutTypeQualifier(el: DuitElement): DuitLayoutElement | undefined {
    if (mayHaveChildList.has(el.type)) {
      return el as DuitLayoutElement;
    }
  }

  createRootOfExactType(
    type: DuitElementType,
    rootAttributes: any
  ): DuitLayoutElement {
    switch (type) {
      case DuitElementType.coloredBox: {
        return this.root = new ColoredBoxUiElement(rootAttributes);
      }
      case DuitElementType.sizedBox: {
        return this.root = new SizedBoxUiElement(rootAttributes);
      }
      case DuitElementType.row: {
        return this.root = new RowUiElement(rootAttributes);
      }
      case DuitElementType.column: {
        return this.root = new ColumnUiElement(rootAttributes);
      }
      case DuitElementType.center: {
        return this.root = new CenterUiElement(rootAttributes);
      }
    }

    return new ColumnUiElement(rootAttributes);
  }

  createRoot(): ColumnUiElement {
    return this.root = new ColumnUiElement({});
  }

  getRoot(): DuitLayoutElement | undefined {
    return this.root;
  }

  build(): string {
    return JSON.stringify(this.root);
  }
}

const mayHaveChildList = new Set([
  DuitElementType.center,
  DuitElementType.coloredBox,
  DuitElementType.column,
  DuitElementType.row,
  DuitElementType.sizedBox,
  DuitElementType.elevatedButton,
]);