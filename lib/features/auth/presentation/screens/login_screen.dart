import 'package:bache_finder_app/features/auth/presentation/controllers/login_controller.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bache Finder'),
            _LoginForm(),
          ],
        ),
      ),
    );
  }
}

class _LoginForm extends GetView<LoginController> {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Iniciar Sesión'),
          _EmailField(),
          _PasswordField(),
          _RecoveryPassword(),
          _LoginButton(),
          SizedBox(height: 8.0),
          _LoginWithGoogle(),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    return const TextFieldWidget(
      label: 'Correo Electrónico',
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    return const TextFieldWidget(
      label: 'Contraseña',
      isObscure: true,
      keyboardType: TextInputType.visiblePassword,
    );
  }
}

class _RecoveryPassword extends StatelessWidget {
  const _RecoveryPassword();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Text('Recuperar contraseña'),
    );
  }
}

class _LoginButton extends GetView<LoginController> {
  const _LoginButton();

  void _login() async {
    final result =
        await controller.login('fernando@example.com', 'password2024#');
    if (!result) {
      Get.snackbar('Error', 'Failed to login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: _login,
        child: const Text('Iniciar Sesión'),
      ),
    );
  }
}

class _LoginWithGoogle extends StatelessWidget {
  const _LoginWithGoogle();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: () {},
        label: const Text('Iniciar sesión con Google'),
        icon: const Icon(Icons.login),
      ),
    );
  }
}
