enum ServerEventType {
    update = "update",
  }

export class ServerEvent {

}

export class UpdateEvent extends ServerEvent {
    type = ServerEventType.update as const;
    updates: Record<string, any>;

    constructor(updates?: Record<string, any>) {
        super();
        this.updates = updates ?? {}
    }
}