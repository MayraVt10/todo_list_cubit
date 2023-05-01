import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/cubits/login_cubit.dart';
import 'package:proyecto/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: LoginForm(),
        ),
      ),
    );
  }
}
