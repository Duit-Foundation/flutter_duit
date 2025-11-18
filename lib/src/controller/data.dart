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

enum PageViewAction {
  animateTo,
  animateToPage,
  prevPage,
  nextPage,
  jumpTo,
  jumpToPage;

  static PageViewAction parse(String value) {
    return _pageViewActionMap[value] ??
        (throw ArgumentError("Undefined page view action key $value"));
  }
}

const _pageViewActionMap = {
  "animateTo": PageViewAction.animateTo,
  "animateToPage": PageViewAction.animateToPage,
  "previousPage": PageViewAction.prevPage,
  "nextPage": PageViewAction.nextPage,
  "jumpTo": PageViewAction.jumpTo,
  "jumpToPage": PageViewAction.jumpToPage,
};
