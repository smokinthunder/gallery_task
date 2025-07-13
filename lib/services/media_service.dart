import 'package:photo_manager/photo_manager.dart';

class MediaService {
  Future<bool> requestPermission() async {
    final result = await PhotoManager.requestPermissionExtend();
    return result.isAuth;
  }

  Future<List<AssetEntity>> loadAllImages() async {
    final albums = await PhotoManager.getAssetPathList(type: RequestType.image);
    if (albums.isNotEmpty) {
      return await albums.first.getAssetListRange(start: 0, end: 999);
    }
    return [];
  }
}