import 'package:bache_finder_app/core/constants/app_colors.dart';
import 'package:bache_finder_app/core/router/app_pages.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:bache_finder_app/features/home/presentation/widgets/home_drawer_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/filled_button_icon_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends GetView<SessionController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFD),
      appBar: AppBar(
        title: Text('Bache Finder App',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white)),
        backgroundColor: const Color(0xFF2C5461),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu,
                  color: Colors.white), // Ícono de menú hamburguesa
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const HomeDrawerWidget(),
      body: const _MainView(),
    );
  }
}

class _MainView extends StatelessWidget {
  const _MainView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        padding: const EdgeInsets.all(16.0),
        child: const Column(
          children: [
            _WelcomeText(),
            GapWidget(size: 16.0),
            Expanded(child: _FeaturedImage()),
            GapWidget(size: 16.0),
            _DescriptionText(),
            GapWidget(size: 16.0),
            _Buttons(),
          ],
        ),
      ),
    );
  }
}

class _WelcomeText extends StatelessWidget {
  const _WelcomeText();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Bienvenido',
      style: Theme.of(context)
          .textTheme
          .displayMedium!
          .copyWith(color: Theme.of(context).primaryColor),
    );
  }
}

class _FeaturedImage extends StatelessWidget {
  const _FeaturedImage();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/splash_blue.png',
      width: double.infinity,
    );
  }
}

class _DescriptionText extends StatelessWidget {
  const _DescriptionText();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Reporta un defecto vial',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: const Color(0xFF2C5461)),
        ),
        const GapWidget(size: 8.0),
        Text(
          'Las vías urbanas y rurales son fundamentales en nuestras actividades diarias. Los defectos en estas pueden generar accidentes, pérdidas de mercancías, y daños a vehículos, entre otros.',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: const Color(0xFF2C5461)),
        ),
        const GapWidget(size: 8.0),
        RichText(
          text: TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: const Color(0xFF2C5461)),
              children: const [
                TextSpan(
                  text: 'BACHE FINDER:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF2C5461)),
                ),
                TextSpan(
                  text:
                      ' Te ayuda a identificar y reportar los defectos viales en tu sector, contribuyendo a mejorar la seguridad y el bienestar de tu comunidad.',
                ),
              ]),
        )
      ],
    );
  }
}

class _Buttons extends GetView<SessionController> {
  const _Buttons();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // ElevatedButton(
          //   onPressed: () {
          //     context.push(AppPaths.profile);
          //   },
          //   child: const Text('Ir a mi perfil'),
          // ),
          const GapWidget(size: 8),
          FilledButtonIconWidget(
            onPressed: () {
              context.push('${AppPaths.potholes}/new');
            },
            label: 'Reportar bache',
            icon: Icons.add,
          ),
          const GapWidget(size: 8),
          FilledButtonIconWidget(
            onPressed: () {
              context.push('${AppPaths.potholes}/all');
            },
            label: 'Baches reportados',
            icon: Icons.list_alt,
            color: AppColors.anakiwa,
            contentColor: AppColors.blumine,
          ),
          const GapWidget(size: 8),
        ],
      ),
    );
  }
}

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget(
      {super.key, required this.onPressed, required this.label});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
