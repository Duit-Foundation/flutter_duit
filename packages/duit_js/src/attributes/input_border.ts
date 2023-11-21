type Border = "outline" | "underline";

export interface InputBorder {
    type: Border;
    options?: {
        gapPadding: number;
        borderRadius: number;
    }
}