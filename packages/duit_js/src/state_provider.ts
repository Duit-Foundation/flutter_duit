interface StateProvider {
    setState<T>(newState: State<T>): Promise<void>;
    getState<T>(id: string): Promise<State<T> | null>;
    updateState<T>(newState: State<T>): Promise<void>;
    initStates(stateData: State[]): Promise<void>;
}

class DefaultStateProvider extends Map implements StateProvider {
    async setState<T>(newState: State<T>): Promise<void> {
        this.set(newState.id, newState);
    }

    async getState<T>(id: string): Promise<State<T> | null> {
        return this.get(id) ?? null;
    }

    async updateState<T>(newState: State<T>): Promise<void> {
        const data = this.get(newState.id) ?? null;

        if (data) {
            const state = data as State<T>;
            state.update(newState);
        }
    }

    async initStates(stateData: State[]): Promise<void> {
        stateData.forEach((initialState) => {
            this.setState(initialState);
        });
    }
}