import type {DuitElement, DuitLayoutElement } from "./element";
import DuitElementType from "./element_type";
import { ColoredBoxUiElement, ColumnUiElement } from "./widget_models";

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