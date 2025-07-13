import 'package:flutter/material.dart';
import 'package:gal2/models/grouped_assets.dart';
import 'package:gal2/screens/image_view.dart';
import 'package:gal2/widgets/asset_thumbnail.dart';

class GroupedListSection extends StatelessWidget {
  final List<GroupedAssets> groups;

  const GroupedListSection({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: groups.length,
      separatorBuilder: (_, __) => Container(),
      itemBuilder: (context, index) {
        final group = groups[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                group.header,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: group.assets.length,
              itemBuilder: (context, idx) {
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ImageViewScreen(asset: group.assets[idx]),
                    ),
                  ),
                  child: AssetThumbnail(asset: group.assets[idx]),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
