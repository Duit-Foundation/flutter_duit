import express, { Router } from "express";

import http from "http";

class DuitHost {
    private provider: StateProvider;
    private initialStatesArr : State[];

    constructor(provider: StateProvider, initialStatesArr: State[] = []) {

        this.provider = provider;
        this.initialStatesArr = initialStatesArr;
    }

    async init(): Promise<void> {
        await this.provider.initStates(this.initialStatesArr);
    }

}

const host = new DuitHost(new DefaultStateProvider());

host.init();

const app = express();

const router = Router();

app.use("/", router);

const server = http.createServer(app);

const x = server.listen(3000);






