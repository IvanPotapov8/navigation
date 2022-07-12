import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/navigators/dashboard_navigator.dart';
import 'package:navigation/pages/analytics_page.dart';
import 'package:navigation/pages/home/home_tab.dart';
import 'package:navigation/pages/payments_page.dart';
import 'package:navigation/widgets/inherited_router_state.dart';

class HomePage extends StatefulWidget {
  final HomeTab tab;

  const HomePage({Key? key, required this.tab}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageController = PageController();

  late GoRouterState dashboardTabHistory;

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    pageController.animateToPage(widget.tab.index, duration: const Duration(milliseconds: 300), curve: Curves.linear);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    final state = rootRouterState;
    if (state.location.startsWith('/dashboard')) {
      dashboardTabHistory = state;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => Material(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                itemBuilder: (context, index) {
                  final tab = HomeTab.values[index];
                  switch (tab) {
                    case HomeTab.dashboard:
                      return buildDashboardTabNavigator(context);
                    case HomeTab.analytics:
                      return buildAnalyticsTabView();
                    case HomeTab.payments:
                      return buildPaymentsTabView();
                  }
                },
                itemCount: HomeTab.values.length,
              ),
            ),
            Theme(
              data: ThemeData(canvasColor: Colors.blue),
              child: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
                  BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Analytics'),
                  BottomNavigationBarItem(icon: Icon(Icons.payments), label: 'Payments'),
                  BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
                ],
                currentIndex: widget.tab.index,
                backgroundColor: Colors.yellow,
                onTap: (index) => onBottomTabClicked(context, index),
              ),
            ),
          ],
        ),
      );

  Widget buildDashboardTabNavigator(BuildContext context) {
    return DashboardNavigator(dashboardTabHistory: dashboardTabHistory);
  }

  void onBottomTabClicked(BuildContext context, int index) {
    if (index == HomeTab.dashboard.index) {
      context.go(dashboardTabHistory.location);
    } else {
      context.go('/${HomeTab.values[index].name}');
    }
  }

  Widget buildAnalyticsTabView() => const AnalyticsPage();

  Widget buildPaymentsTabView() => const PaymentsPage();

  GoRouterState get rootRouterState {
    return context.dependOnInheritedWidgetOfExactType<InheritedRouterState>()!.rootRouterState;
  }
}
