import 'package:bache_finder_app/core/router/app_pages.dart';
import 'package:bache_finder_app/features/pothole/presentation/controllers/potholes_controller.dart';
import 'package:bache_finder_app/features/pothole/presentation/widgets/pothole_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PotholesScreen extends StatelessWidget {
  const PotholesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const _MainView(),
      backgroundColor: const Color(0xFFF4FAFD),
      floatingActionButton: const _AddPotholeButton(),
      appBar: AppBar(
        title: Text('Baches reportados',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white)),
        backgroundColor: const Color(0xFF2C5461),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
    );
  }
}

class _AddPotholeButton extends StatelessWidget {
  const _AddPotholeButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      onPressed: () => context.push('${AppPaths.potholes}/new'),
      icon: const Icon(Icons.add),
      label: const Text('Reportar bache'),
      backgroundColor: const Color(0xFFB9E1F2),
    );
  }
}

class _MainView extends StatelessWidget {
  const _MainView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: _PotholesView(),
          ),
        ),
      ),
    );
  }
}

class _PotholesView extends GetView<PotholesController> {
  const _PotholesView();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller.scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        const _PotholesList(),
        Obx(
          () => controller.isLoading.value
              ? const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()))
              : const SliverToBoxAdapter(child: SizedBox.shrink()),
        ),
      ],
    );
  }
}

class _PotholesList extends GetView<PotholesController> {
  const _PotholesList();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return PotholeCardWidget(
              pothole: controller.potholes.value[index],
            );
          },
          childCount: controller.potholes.value.length,
        ),
      ),
    );
  }
}
