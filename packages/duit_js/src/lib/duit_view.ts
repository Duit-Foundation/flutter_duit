// import path from "path";
import UIBuilder from "./builder";

export default class DuitView {

    static static(filePath: string): string {
        if (filePath === undefined) throw Error("Invalid path provided");

        const file = require("../utils/testview.json");
        return JSON.stringify(file);
    }

    static builder(): UIBuilder {
        return new UIBuilder();
    }

}