import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gal2/providers/selection_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AssetThumbnail extends StatelessWidget {
  final AssetEntity asset;

  const AssetThumbnail({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {

    return Stack(
      fit: StackFit.expand,
      children: [
        FutureBuilder<Uint8List?>(
          future: asset.thumbnailData,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Image.memory(snapshot.data!, fit: BoxFit.cover);
            } else {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.white,
                child: Container(
                  color: Colors.grey[300],
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            }
          },
        ),
          Selector<SelectionProvider, bool>(
          selector: (context, provider) =>
              provider.selectedAssets.contains(asset),
          shouldRebuild: (prev, next) => prev != next,
          builder: (context, isSelected, _) {
            if (!isSelected) return const SizedBox.shrink();

            return Positioned(
              top: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(204),
                ),
                child: Icon(Icons.check_circle, color: Colors.blue, size: 24),
              ),
            );
          },
        )
      ],
    );
  }
}
