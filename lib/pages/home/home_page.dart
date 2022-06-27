import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/bloc/auth/auth_bloc.dart';
import 'package:navigation/pages/home/home_tab.dart';
import 'package:navigation/widgets/accent_button.dart';

class HomePage extends StatefulWidget {
  final Function(BuildContext)? onInboxClicked;
  final Function(BuildContext)? onInboxSubClicked;
  final Function(BuildContext, int)? onBottomTabClicked;

  final HomeTab tab;

  const HomePage({
    Key? key,
    this.onInboxClicked,
    this.onInboxSubClicked,
    this.onBottomTabClicked,
    required this.tab,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    debugPrint('HomePage initState()');
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Home')),
        bottomNavigationBar: Theme(
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
            onTap: (index) => widget.onBottomTabClicked?.call(context, index),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AccentButton('Logout', () => context.read<AuthBloc>().add(AuthEvent(false))),
              AccentButton('Inbox', () => widget.onInboxClicked?.call(context)),
              AccentButton('Inbox (sub)', () => widget.onInboxSubClicked?.call(context)),
            ],
          ),
        ),
      );
}
