import 'package:bache_finder_app/features/auth/presentation/controllers/forms/login_form_controller.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<SessionController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.isLoading.listen((status) {
      final errorMessage = controller.errorMessage;
      if (status == false) {
        if (errorMessage != '') {
          controller.resetErrorMessage();
          Get.snackbar(
            'Error',
            errorMessage,
            backgroundGradient:
                LinearGradient(colors: [Colors.red[300]!, Colors.red[100]!]),
            margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          );
        }
      }
    });

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

class _LoginForm extends StatelessWidget {
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

class _EmailField extends GetView<LoginFormController> {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFieldWidget(
        label: 'Correo Electrónico',
        keyboardType: TextInputType.emailAddress,
        onChanged: controller.onEmailChanged,
        errorMessage:
            controller.isPosted ? controller.email.errorMessage : null,
      ),
    );
  }
}

class _PasswordField extends GetView<LoginFormController> {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFieldWidget(
        label: 'Contraseña',
        isObscure: true,
        keyboardType: TextInputType.visiblePassword,
        onChanged: controller.onPasswordChanged,
        errorMessage:
            controller.isPosted ? controller.password.errorMessage : null,
      ),
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

class _LoginButton extends GetView<LoginFormController> {
  const _LoginButton();

  // void _login() async {
  //   final result =
  //       await controller.login('fernando@example.com', 'password2024#');
  //   if (!result) {
  //     Get.snackbar('Error', 'Failed to login');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Obx(
        () => FilledButton(
          onPressed: controller.isPosting ? null : controller.submit,
          child: const Text('Iniciar Sesión'),
        ),
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
