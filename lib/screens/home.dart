import 'package:flutter/material.dart';
import 'package:gal2/services/media_service.dart';
import 'package:gal2/utils/date_formatter.dart';
import 'package:gal2/models/grouped_assets.dart';
import 'package:gal2/widgets/custom_app_bar.dart';
import 'package:gal2/widgets/grouped_list.dart';
import 'package:photo_manager/photo_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MediaService _mediaService;
  List<GroupedAssets> groupedAssets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _mediaService = MediaService();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final media = await _mediaService.loadAllImages();
    final Map<String, List<AssetEntity>> groupedMap = {};

    for (var asset in media) {
      final date = DateFormatter.formatDate(asset.createDateTime.toLocal());
      if (!groupedMap.containsKey(date)) groupedMap[date] = [];
      groupedMap[date]?.add(asset);
    }

    // Sort by real date
    final sortedEntries = groupedMap.entries.toList()
      ..sort((a, b) {
        final dateA = DateFormatter.extractDateFromHeader(a.key);
        final dateB = DateFormatter.extractDateFromHeader(b.key);
        return dateB.compareTo(dateA); // newest first
      });

    setState(() {
      groupedAssets = sortedEntries.map((e) => GroupedAssets(e.key, e.value)).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: customAppBar(),
      body: groupedAssets.isEmpty
          ? const Center(child: Text("No images found"))
          : GroupedListSection(groups: groupedAssets),
    );
  }
}