import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/pages/dashboard_page.dart';
import 'package:navigation/pages/inbox_details_page.dart';
import 'package:navigation/pages/inbox_list_page.dart';

class DashboardNavigator extends StatelessWidget {
  final GoRouterState dashboardTabHistory;

  const DashboardNavigator({Key? key, required this.dashboardTabHistory}) : super(key: key);

  @override
  Widget build(BuildContext context) => Navigator(
        pages: [
          MaterialPage(
            child: DashboardPage(
              onInboxSubClicked: onInboxSubClicked,
              onTopUpClicked: onTopUpClicked,
            ),
          ),
          ...buildInboxPages(),
        ],
        onPopPage: (route, result) {
          if (route.didPop(result)) {
            if (dashboardTabHistory.params.containsKey('key')) {
              context.go('/dashboard/inboxMessages');
            } else {
              context.go('/dashboard');
            }
            return true;
          }
          return false;
        },
      );

  List<Page> buildInboxPages() {
    final showInboxMessagesList = dashboardTabHistory.location.contains('/inboxMessages');

    final key = dashboardTabHistory.params['key'];
    final showInboxMessageDetails = key != null;

    return [
      if (showInboxMessagesList)
        MaterialPage(
          child: InboxListPage(
            onInboxMessageClicked: onInboxMessageClicked,
          ),
        ),
      if (showInboxMessageDetails)
        MaterialPage(
          child: InboxDetailsPage(
            messageKey: key,
            onHomeClicked: onHomeClicked,
          ),
        ),
    ];
  }

  void onHomeClicked(BuildContext context) => context.go('/dashboard');

  void onInboxMessageClicked(BuildContext context, String key) {
    final router = GoRouter.of(context);
    router.go('${router.location}/$key');
  }

  void onInboxSubClicked(BuildContext context) {
    final router = GoRouter.of(context);
    router.go('${router.location}/inboxMessages');
  }

  void onTopUpClicked(BuildContext context) => context.go('/dashboard/topUp');
}
