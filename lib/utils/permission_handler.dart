import 'package:photo_manager/photo_manager.dart';

class PermissionHandler {
  static Future<bool> requestPhotoPermission() async {
    final result = await PhotoManager.requestPermissionExtend();
    return result.isAuth;
  }
}