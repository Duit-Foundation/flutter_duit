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
    dependsOn: ActionDependency[];

    /**
     * Url (for http) of event name (for ws)
     */
    event: string;

    constructor(event: string, dependsOn: ActionDependency[] = []) {
        this.event = event;
        this.dependsOn = dependsOn;
    }
}


export class HttpAction extends BaseAction {
    meta: HttpActionMetainfo;

    constructor(event: string, meta: HttpActionMetainfo, dependsOn: ActionDependency[] = []) {
        super(event, dependsOn);
        this.meta = meta ?? {};
    }
}

export class WebSocketAction extends BaseAction {
    constructor(event: string, dependsOn: ActionDependency[] = []) {
        super(event, dependsOn);
    }
}
