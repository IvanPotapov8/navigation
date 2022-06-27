import 'package:flutter/material.dart';
import 'package:navigation/widgets/accent_button.dart';

class InboxListPage extends StatefulWidget {
  final Function(BuildContext, String)? onInboxMessageClicked;
  final VoidCallback? onDispose;

  const InboxListPage({
    Key? key,
    this.onInboxMessageClicked,
    this.onDispose,
  }) : super(key: key);

  @override
  State<InboxListPage> createState() => _InboxListPageState();
}

class _InboxListPageState extends State<InboxListPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Inbox List Page')),
        body: Center(
          child: AccentButton(
            'Open Details Page',
            () => widget.onInboxMessageClicked?.call(context, 'jQ1lm9Va'),
          ),
        ),
      );

  @override
  void dispose() {
    widget.onDispose?.call();
    super.dispose();
  }
}
