import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/bloc/auth/auth_bloc.dart';
import 'package:navigation/widgets/accent_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Center(
          child: AccentButton('Login', () => context.read<AuthBloc>().add(AuthEvent(true))),
        ),
      );
}
