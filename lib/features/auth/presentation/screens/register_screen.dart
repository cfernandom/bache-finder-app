import 'package:bache_finder_app/core/router/app_pages.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/forms/register_form_controller.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/gap_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/snackbar_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/text_button_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends GetView<RegisterFormController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5FB),
      key: controller.scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bache Finder',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: Theme.of(context).primaryColor)),
            const _RegisterForm(),
          ],
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Registrarse', style: Theme.of(context).textTheme.titleLarge),
          const GapWidget(size: 8),
          const _NameField(),
          const GapWidget(size: 8),
          const _EmailField(),
          const GapWidget(size: 8),
          const _PasswordField(),
          const GapWidget(size: 8),
          const _ConfirmPasswordField(),
          const GapWidget(size: 16),
          const _RegisterButton(),
          const GapWidget(size: 8),
          const _LoginButton(),
        ],
      ),
    );
  }
}

class _NameField extends GetView<RegisterFormController> {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFieldWidget(
        label: 'Nombre',
        onChanged: controller.onNameChanged,
        errorMessage: controller.isPosted ? controller.name.errorMessage : null,
      ),
    );
  }
}

class _EmailField extends GetView<RegisterFormController> {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFieldWidget(
        label: 'Email',
        keyboardType: TextInputType.emailAddress,
        onChanged: controller.onEmailChanged,
        errorMessage:
            controller.isPosted ? controller.email.errorMessage : null,
      ),
    );
  }
}

class _PasswordField extends GetView<RegisterFormController> {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFieldWidget(
        label: 'Contraseña',
        isObscure: true,
        onChanged: controller.onPasswordChanged,
        errorMessage:
            controller.isPosted ? controller.password.errorMessage : null,
      ),
    );
  }
}

class _ConfirmPasswordField extends GetView<RegisterFormController> {
  const _ConfirmPasswordField();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFieldWidget(
        label: 'Confirmar Contraseña',
        isObscure: true,
        onChanged: controller.onConfirmPasswordChanged,
        errorMessage: controller.isPosted
            ? controller.confirmPassword.errorMessage
            : null,
      ),
    );
  }
}

class _RegisterButton extends GetView<RegisterFormController> {
  const _RegisterButton();

  @override
  Widget build(BuildContext context) {
    final sessionControler = Get.find<SessionController>();
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: FilledButton(
        onPressed: controller.isPosting
            ? null
            : () async {
                final result = await controller.onSubmit();

                if (result) {
                  SnackbarWidget.show(
                    controller.scaffoldKey.currentContext!,
                    message: 'Registro exitoso',
                  );
                  controller.scaffoldKey.currentContext?.pop();
                } else {
                  SnackbarWidget.show(
                    controller.scaffoldKey.currentContext!,
                    message:
                        'Error al registrar. ${sessionControler.errorMessage}',
                  );
                }
              },
        style: ButtonStyle(
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        child: Obx(
          () => controller.isPosting
              ? const CircularProgressIndicator()
              : const Text('Registrarse'),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return TextButtonWidget(
      'Iniciar Sesión',
      onPressed: () => context.go(AppPaths.login),
    );
  }
}