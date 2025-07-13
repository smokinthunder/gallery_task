import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';


import 'package:shimmer/shimmer.dart';

class ImageViewScreen extends StatelessWidget {
  final AssetEntity asset;

  const ImageViewScreen({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,

        title: Text(asset.title ?? 'Image'),
      ),

      body: Center(
        child: Hero(
          tag: asset.id,

          child: SizedBox.expand(
            child: FutureBuilder<Uint8List?>(
              future: asset.originBytes,

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return InteractiveViewer(
                    panEnabled: false,

                    boundaryMargin: const EdgeInsets.all(double.infinity),

                    minScale: 1.0,

                    maxScale: 4.0,

                    child: SizedBox.expand(child: Image.memory(snapshot.data!)),
                  );
                } else {
                  return Shimmer(
                    gradient: LinearGradient(
                      colors: [Colors.grey[300]!, Colors.grey[100]!],

                      begin: Alignment.topLeft,

                      end: Alignment.bottomRight,
                    ),

                    child: SizedBox(height: 400, width: double.infinity),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
