import { ID } from "../utils/id";

type HttpMethod = "POST" | "GET" | "PATCH" | "DELETE";

interface ActionDependency {
    id: ID;
    target: string;
}

interface HttpActionMetainfo {
    method: HttpMethod;
}

export class BaseAction {
    depensOn: ActionDependency[];

    /**
     * Url (for http) of event name (for ws)
     */
    event: string;

    constructor(event: string, depndsOn: ActionDependency[] = []) {
        this.event = event;
        this.depensOn = depndsOn;
    }
}


export class HttpAction extends BaseAction {
    meta: HttpActionMetainfo;

    constructor(event: string, meta: HttpActionMetainfo, depndsOn: ActionDependency[] = []) {
        super(event, depndsOn);
        this.meta = meta;
    }
}

export class WebSocketAction extends BaseAction {
    constructor(event: string, depndsOn: ActionDependency[] = []) {
        super(event, depndsOn);
    }
}
