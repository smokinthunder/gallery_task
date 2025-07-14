import 'package:flutter/material.dart';
import 'package:gal2/models/grouped_assets.dart';
import 'package:gal2/providers/selection_provider.dart';
import 'package:gal2/screens/image_view.dart';
import 'package:gal2/widgets/asset_thumbnail.dart';
import 'package:provider/provider.dart';

class GroupedListSection extends StatelessWidget {
  final List<GroupedAssets> groups;

  const GroupedListSection({super.key, required this.groups});

  void imageOpen(GroupedAssets group, BuildContext context, int idx) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageViewScreen(asset: group.assets[idx]),
      ),
    );
  }

  void imageSelect(GroupedAssets group, BuildContext context, int idx) {
    final selectionProvider = Provider.of<SelectionProvider>(
      context,
      listen: false,
    );
    selectionProvider.toggle(group.assets[idx]);
  }

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
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: group.assets.length,
              itemBuilder: (context, idx) {
                // Extract hasSelection here without affecting the whole list
                return Consumer<SelectionProvider>(
                  builder: (context, selectionProvider, _) {
                    final hasSelection = selectionProvider.hasSelection;
                    return InkWell(
                      onTap: () {
                        if (hasSelection) {
                          imageSelect(group, context, idx);
                        } else {
                          imageOpen(group, context, idx);
                        }
                      },
                      onLongPress: () {
                        if (hasSelection) {
                          imageOpen(group, context, idx);
                        } else {
                          imageSelect(group, context, idx);
                        }
                      },
                      child: AssetThumbnail(asset: group.assets[idx]),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}