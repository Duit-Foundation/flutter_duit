class State<T = any> {
    id: string;
    stateAttributes: T;

    constructor(id: string, data: T) {
        this.id = id;
        this.stateAttributes = data;
    }

    update(newState: State<T>): State<T> {
        this.stateAttributes = newState.stateAttributes;
        return this;
    }

}