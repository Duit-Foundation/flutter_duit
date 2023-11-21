import { Clip } from "./clip";

export class ElevatedButtonAttributes {
    autofocus?: boolean;
    clipBehavior?: keyof typeof Clip;
}