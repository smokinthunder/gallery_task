import 'package:flutter/material.dart';
import 'package:gal2/providers/selection_provider.dart';
import 'package:gal2/widgets/curved_share_bar.dart';
import 'package:provider/provider.dart';

class BottomDrawer extends StatefulWidget {
  const BottomDrawer({super.key});

  @override
  State<BottomDrawer> createState() => _BottomDrawerState();
}

class _BottomDrawerState extends State<BottomDrawer> {
  bool isShare = false;
  @override
  Widget build(BuildContext context) {
    final selectionProvider = Provider.of<SelectionProvider>(context);
    final int count = selectionProvider.count;

    return Stack(
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          color: Colors.transparent,
          height: 400,
          child: isShare
              ? null
              : Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Select All',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.check,
                                  size: 20,
                                  color: Colors.grey[600],
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () => selectionProvider.clearSelection(),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '$count selected',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Action buttons grid
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            // First row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildActionButton(
                                  icon: Icons.photo_library_outlined,
                                  label: 'Add to album',
                                  color: Colors.black87,
                                ),
                                _buildActionButton(
                                  icon: Icons.favorite_outline,
                                  label: 'Favourite',
                                  color: Colors.black87,
                                ),
                                _buildActionButton(
                                  icon: Icons.download_outlined,
                                  label: 'Download',
                                  color: Colors.black87,
                                ),
                              ],
                            ),

                            const SizedBox(height: 32),

                            // Second row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildActionButton(
                                  icon: Icons.visibility_off_outlined,
                                  label: 'Hide',
                                  color: Colors.black87,
                                ),
                                _buildActionButton(
                                  icon: Icons.archive_outlined,
                                  label: 'Archive',
                                  color: Colors.black87,
                                ),
                                _buildActionButton(
                                  icon: Icons.edit_outlined,
                                  label: 'Edit time',
                                  color: Colors.black87,
                                ),
                                _buildActionButton(
                                  icon: Icons.delete_outline,
                                  label: 'Delete',
                                  color: Colors.red,
                                ),
                              ],
                            ),

                            const SizedBox(height: 32),

                            // Delete button (centered)
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
        ),
        Positioned(
          top: 45,
          left: 0,
          right: 0,
          child: Center(
            child: InkWell(
              onLongPress: () => setState(() {
                isShare = true;
              }),
              onTap: () {
                if (isShare) {
                  setState(() {
                    isShare = false;
                  });
                } else {
                  // Handle the send action here
                }
              },
              

              child: Container(
                decoration: BoxDecoration(
                  color: isShare? Colors.transparent: Colors.white,
                  borderRadius: BorderRadius.circular(52),
                ),
                padding: const EdgeInsets.all(10),
                child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(52),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.send_rounded,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: (!isShare)
                ? null
                : CurvedShareBar(),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(28),
          ),
          child: Icon(icon, size: 24, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}
