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
    final selectionProvider = Provider.of<SelectionProvider>(context);
    final isSelected = selectionProvider.selectedAssets.contains(asset);
    return Stack(
      fit: StackFit.expand,
      children: [
        FutureBuilder<Uint8List?>(
          future: asset.thumbnailData,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Image.memory(
                colorBlendMode: BlendMode.darken,
                color: isSelected
                    ? Colors.black.withAlpha(100)
                    : Colors.transparent,
                snapshot.data!,
                fit: BoxFit.cover,
              );
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
        if (isSelected)
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Icon(
                Icons.check_circle_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
      ],
    );
  }
}
