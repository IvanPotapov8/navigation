import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/bloc/inbox/inbox_bloc.dart';
import 'package:navigation/widgets/accent_button.dart';

class InboxDetailsPage extends StatelessWidget {
  final String messageKey;
  final Function(BuildContext)? onHomeClicked;

  const InboxDetailsPage({Key? key, required this.messageKey, this.onHomeClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Inbox Details Page')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AccentButton('Trigger TestEvent', () => context.read<InboxBloc>().add(InboxEvent())),
              AccentButton('Home', () => onHomeClicked?.call(context)),
            ],
          ),
        ),
      );
}
