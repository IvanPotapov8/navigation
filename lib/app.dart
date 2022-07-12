import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/bloc/auth/auth_bloc.dart';
import 'package:navigation/pages/home/home_page.dart';
import 'package:navigation/pages/home/home_tab.dart';
import 'package:navigation/pages/login_page.dart';
import 'package:navigation/pages/top_up_page.dart';
import 'package:navigation/widgets/inherited_router_state.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _MyAppState();
}

class _MyAppState extends State<App> {
  late final rootRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        redirect: (_) => '/dashboard',
      ),
      GoRoute(
        path: '/:tab(dashboard|analytics|payments)',
        pageBuilder: (_, state) => homePage(state),
        routes: [
          GoRoute(
            path: 'topUp',
            builder: (_, __) => const TopUpPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/:tab(dashboard)/inboxMessages',
        pageBuilder: (_, state) => homePage(state),
      ),
      GoRoute(
        path: '/:tab(dashboard)/inboxMessages/:key',
        pageBuilder: (_, state) => homePage(state),
      ),
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginPage(),
      ),
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

  Page homePage(GoRouterState state) => MaterialPage<void>(
        key: const ValueKey('home_page_key'),
        child: InheritedRouterState(
          state,
          child: HomePage(tab: HomeTabExtension.parse(state.params['tab']!)),
        ),
      );

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        routeInformationParser: rootRouter.routeInformationParser,
        routerDelegate: rootRouter.routerDelegate,
        routeInformationProvider: rootRouter.routeInformationProvider,
      );

  AuthBloc get authBloc => context.read();
}
