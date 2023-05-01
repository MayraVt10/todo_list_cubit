import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/cubits/login_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usuarioController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _usuarioController,
            decoration: const InputDecoration(labelText: 'usuario'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese nombre de usuario ';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese su contraseña';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Llamamos al método `submit` de nuestro Cubit
                context.read<LoginCubit>().submit(
                      _usuarioController.text,
                      _passwordController.text,
                    );
              }
              Navigator.pushNamed(context, '/list');
            },
            child: const Text('Iniciar sesión'),
          ),
        ],
      ),
    );
  }
}
