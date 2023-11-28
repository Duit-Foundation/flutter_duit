import { AlignmentDirectional } from "./alignment";
import { Clip } from "./clip";
import { TextDirection } from "./text_direction";

type StackFit = "loose" | "expand" | "passthrough";

export interface StackAttributes {
    alignment?: keyof typeof AlignmentDirectional;
    textDirection?: keyof typeof TextDirection;
    fit?: StackFit;
    clipBehavior?: Clip;
}