import 'package:bache_finder_app/core/constants/app_colors.dart';
import 'package:bache_finder_app/core/theme/styles/custom_text_styles.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/container_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/dual_text_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/filled_button_icon_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/gap_widget.dart';
import 'package:bache_finder_app/features/user/presentation/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFD),
      appBar: AppBar(
        title: Text('Perfil de usuario',
            style: CustomTextStyles.getAppBarTitle(context)),
        backgroundColor: AppColors.blumine,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const _MainView(),
    );
  }
}

class _MainView extends StatelessWidget {
  const _MainView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ImageViewer(),
            GapWidget(size: 16.0),
            _ProfileInfoView(),
            GapWidget(size: 16.0),
            GapWidget(size: 16.0),
            _EditButton(),
          ],
        ),
      ),
    );
  }
}

class _ImageViewer extends StatelessWidget {
  const _ImageViewer();

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(minHeight: 80, maxHeight: 150),
        child: Image.asset('assets/images/user_logo.png'));
  }
}

class _ProfileInfoView extends StatelessWidget {
  const _ProfileInfoView();

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    return ContainerWidget(
      child: Column(children: [
        DualTextWidget(
          leftText: 'Nombre',
          rightText: userController.currentUser.value?.name ?? '',
        ),
        DualTextWidget(
          leftText: 'Email',
          rightText: userController.currentUser.value?.email ?? '',
        ),
        DualTextWidget(
          leftText: 'Roles',
          rightText: userController.currentUser.value?.roles?.join(', ') ?? '',
        ),
      ]),
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton();

  @override
  Widget build(BuildContext context) {
    return const FilledButtonIconWidget(
      label: 'Editar',
      icon: Icons.edit,
      color: AppColors.anakiwa,
      contentColor: AppColors.blumine,
    );
  }
}
