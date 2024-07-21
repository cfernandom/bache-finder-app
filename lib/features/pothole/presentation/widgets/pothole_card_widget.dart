import 'package:bache_finder_app/core/router/app_pages.dart';
import 'package:bache_finder_app/features/pothole/domain/entities/pothole.dart';
import 'package:bache_finder_app/features/pothole/presentation/controllers/potholes_controller.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/image_viewer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PotholeCardWidget extends GetView<PotholesController> {
  final Pothole pothole;

  const PotholeCardWidget({
    required this.pothole,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('${AppPaths.potholes}/${pothole.id}'),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pothole.address, overflow: TextOverflow.ellipsis),
                  const Text('Ubicación'),
                  Text('${pothole.latitude}, ${pothole.longitude}'),
                  const Text('Tipo'),
                  Text(pothole.type),
                ],
              ),
            ),
            _Image(
              path: pothole.image,
            ),
          ],
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final String path;
  const _Image({
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 150,
      child: ImageViewerWidget(path),
    );
  }
}
