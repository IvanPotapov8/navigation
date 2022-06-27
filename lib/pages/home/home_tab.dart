enum HomeTab { dashboard, analytics, payments }

extension HomeTabExtension on HomeTab {
  static HomeTab parse(String name) => HomeTab.values.firstWhere((tab) => tab.name == name);
}
