// import path from "path";
import UIBuilder from "./builder";

export default class DuitView {
    // private static provider: StateProvider;
    // private initialStatesArr : State[];

    // private constructor() {};

    // static setProvider(provider: StateProvider) {
    //     this.provider = provider;
    // }

    // static static(filePath: string): string {
    //     if (filePath === undefined) throw Error("Invalid path provided");

    //     const jsonPath = path.join(__dirname, filePath);
    //     const file = require(jsonPath);

    //     return JSON.stringify(file);
    // }

    static builder(): UIBuilder {
        return new UIBuilder();
    }

}