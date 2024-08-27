import 'package:bache_finder_app/core/router/app_pages.dart';
import 'package:bache_finder_app/features/pothole/domain/entities/pothole.dart';
import 'package:bache_finder_app/features/pothole/presentation/controllers/potholes_controller.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/gap_widget.dart';
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
        margin: const EdgeInsets.only(top: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: Color(0xFFDFF2FA),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GapWidget(size: 8.0),
                  Text(pothole.type, style: Theme.of(context).textTheme.titleMedium,),
                  const GapWidget(size: 8.0),
                  Text(pothole.locality, overflow: TextOverflow.ellipsis),
                  Text(pothole.address, overflow: TextOverflow.ellipsis),
                  const GapWidget(size: 16.0),
                  Text('${pothole.latitude}, ${pothole.longitude}', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey),),
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
      width: 150,
      height: 150,
      child: ImageViewerWidget(path),
    );
  }
}
