import 'package:bache_finder_app/core/router/app_pages.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/forms/login_form_controller.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/gap_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/snackbar_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/text_button_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends GetView<SessionController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.isLoading.listen((status) {
      final errorMessage = controller.errorMessage;
      if (status == false) {
        if (errorMessage != '') {
          SnackbarWidget.show(context, message: errorMessage);
          controller.resetErrorMessage();
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.errorMessage != '') {
        SnackbarWidget.show(context, message: controller.errorMessage);
        controller.resetErrorMessage();
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFE8F5FB),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bache Finder',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: Theme.of(context).primaryColor)),
            const _LoginForm(),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Iniciar Sesión', style: Theme.of(context).textTheme.titleLarge),
          const GapWidget(size: 8),
          const _EmailField(),
          const GapWidget(size: 8),
          const _PasswordField(),
          const _RecoveryPassword(),
          const SizedBox(height: 32.0),
          const _LoginButton(),
          const SizedBox(height: 8.0),
          const _LoginWithGoogle(),
          const SizedBox(height: 8.0),
          const _RegisterButton(),
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
    return TextButtonWidget(
      'Recuperar contraseña',
      onPressed: () {},
    );
  }
}

class _LoginButton extends GetView<LoginFormController> {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Obx(
        () => FilledButton(
          onPressed: controller.isPosting ? null : controller.onSubmit,
          style: ButtonStyle(
              shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          )),
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
      height: 56,
      child: FilledButton.icon(
        onPressed: () {},
        style: ButtonStyle(
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        )),
        label: const Text('Iniciar sesión con Google'),
        icon: const Icon(Icons.login),
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton();

  @override
  Widget build(BuildContext context) {
    return TextButtonWidget(
      'Registrarse',
      onPressed: () => context.push(AppPaths.register),
    );
  }
}