import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InheritedRouterState extends InheritedWidget {
  final GoRouterState rootRouterState;

  const InheritedRouterState(this.rootRouterState, {Key? key, required super.child}) : super(key: key);

  @override
  bool updateShouldNotify(covariant InheritedRouterState oldWidget) {
    return oldWidget.rootRouterState.location != rootRouterState.location;
  }
}
