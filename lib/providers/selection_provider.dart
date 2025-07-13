import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';

class SelectionProvider with ChangeNotifier {
  final Set<AssetEntity> _selectedAssets = {};

  Set<AssetEntity> get selectedAssets => _selectedAssets;
  bool get hasSelection => _selectedAssets.isNotEmpty;

  void toggle(AssetEntity asset) {
    if (_selectedAssets.contains(asset)) {
      _selectedAssets.remove(asset);
    } else {
      _selectedAssets.add(asset);
    }
    notifyListeners();
  }

  void clearSelection() {
    _selectedAssets.clear();
    notifyListeners();
  }



  int get count => _selectedAssets.length;
}