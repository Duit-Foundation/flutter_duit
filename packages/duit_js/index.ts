import UIBuilder from "./src/builder";
import DuitView from "./src/duit_view";
import DuitElementType from "./src/element_type";
import { ColumnUiElement, RowUiElement, TextUiElement, ColoredBoxUiElement } from "./src/widget_models";

function tst2() {
    const UI = DuitView.builder();

    const root = UI.createRoot();

    const row1 = root.addChild(new RowUiElement({}, "row1").closeTree());

    const x = UI.layoutTypeQualifier(row1);

    if (x) {
        for (let index = 0; index < 5; index++) {
            x.addChild(new TextUiElement({data: index.toString()}))
        }
    }

    const json = UI.getRoot();
    console.log(json);
}

tst2();