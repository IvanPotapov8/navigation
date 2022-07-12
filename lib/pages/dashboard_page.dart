import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/bloc/auth/auth_bloc.dart';
import 'package:navigation/widgets/accent_button.dart';

class DashboardPage extends StatelessWidget {
  final Function(BuildContext)? onInboxSubClicked;
  final Function(BuildContext)? onTopUpClicked;

  const DashboardPage({super.key, this.onInboxSubClicked, this.onTopUpClicked});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.red.withOpacity(0.3),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AccentButton('Logout', () => context.read<AuthBloc>().add(AuthEvent(false))),
              AccentButton('Inbox (sub)', () => onInboxSubClicked?.call(context)),
              AccentButton('Top Up', () => onTopUpClicked?.call(context)),
            ],
          ),
        ),
      );
}
