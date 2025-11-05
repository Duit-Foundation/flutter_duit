enum OverlayAction {
  open,
  close;

  static OverlayAction parse(String value) {
    return _overlayActionMap[value] ?? OverlayAction.open;
  }
}

const _overlayActionMap = {
  "open": OverlayAction.open,
  "close": OverlayAction.close,
};
