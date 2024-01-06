abstract interface class NavigationResolver {
  void resolveNavigationToPath(String link);
  void resolveOpenUrlEvent(String url);
}