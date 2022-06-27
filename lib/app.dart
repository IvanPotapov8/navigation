import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/bloc/auth/auth_bloc.dart';
import 'package:navigation/bloc/inbox/inbox_bloc.dart';
import 'package:navigation/pages/home/home_page.dart';
import 'package:navigation/pages/home/home_tab.dart';
import 'package:navigation/pages/inbox_details_page.dart';
import 'package:navigation/pages/inbox_list_page.dart';
import 'package:navigation/pages/login_page.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _MyAppState();
}

class _MyAppState extends State<App> {
  late final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        redirect: (_) => '/dashboard',
      ),
      GoRoute(
        path: '/:tab(dashboard|analytics|payments)',
        builder: (_, state) {
          return HomePage(
            onInboxClicked: onInboxClicked,
            onInboxSubClicked: onInboxSubClicked,
            onBottomTabClicked: onBottomTabClicked,
            tab: HomeTabExtension.parse(state.params['tab']!),
          );
        },
        routes: [..._InboxRouter(isSub: true).routes],
      ),
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginPage(),
      ),
      ..._InboxRouter().routes,
    ],
    redirect: (state) {
      final subLocation = state.location;
      final isAuthorized = authBloc.state.isAuthorized;
      if (!isAuthorized) return subLocation == '/login' ? null : '/login';
      if (isAuthorized && subLocation == '/login') return '/';
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    debugLogDiagnostics: true,
  );

  void onBottomTabClicked(BuildContext context, int index) {
    GoRouter.of(context).go('/${HomeTab.values[index].name}');
  }

  void onInboxClicked(BuildContext context) {
    context.push('/inboxMessages');
  }

  void onInboxSubClicked(BuildContext context) {
    context.go('${GoRouter.of(context).location}/inboxMessages');
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
      );

  AuthBloc get authBloc => context.read();
}

class _InboxRouter {
  InboxBloc? _bloc;

  final bool isSub;

  _InboxRouter({this.isSub = false});

  List<GoRoute> get routes => [
        GoRoute(
          path: '${isSub ? '' : '/'}inboxMessages',
          builder: (_, __) => BlocProvider.value(
            value: _getBloc(),
            child: InboxListPage(
              onInboxMessageClicked: onInboxMessageClicked,
              onDispose: onDispose,
            ),
          ),
        ),
        GoRoute(
          path: '${isSub ? '' : '/'}inboxMessages/:key',
          builder: (_, __) => BlocProvider.value(
            value: _getBloc(),
            child: InboxDetailsPage(onHomeClicked: onHomeClicked),
          ),
        ),
      ];

  void onInboxMessageClicked(BuildContext context, String key) {
    context.push('${GoRouter.of(context).location}/$key');
  }

  void onHomeClicked(BuildContext context) {
    context.go('/dashboard');
  }

  InboxBloc _getBloc() => _bloc ??= InboxBloc();

  void onDispose() {
    _bloc?.close();
    _bloc = null;
  }
}
