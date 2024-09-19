import 'package:bache_finder_app/core/router/app_pages.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/gap_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5FB),
      body: Center(
        child: Container(
          constraints: const BoxConstraints.expand(
            width: 320,
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GapWidget(size: 100),
              HeaderImage(),
              GapWidget(size: 4),
              WelcomeText(),
              GapWidget(size: 80),
              LoginButton(),
              GapWidget(size: 4),
              RegisterTextButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderImage extends StatelessWidget {
  const HeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/splash.png',
      width: 300,
    );
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Reporta defectos viales y transforma tu sector.',
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: const Color(0xFF2C5461)),
      textAlign: TextAlign.center,
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: FilledButton(
        onPressed: () => context.push(AppPaths.login),
        style: ButtonStyle(
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        )),
        child: const Text('Ingresar'),
      ),
    );
  }
}

class RegisterTextButton extends StatelessWidget {
  const RegisterTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButtonWidget('Registrarse',
        onPressed: () => context.push(AppPaths.register));
  }
}
