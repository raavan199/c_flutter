import 'package:permission_handler/permission_handler.dart';

/// Created by Dev 2196 on 08/10/2021
/// Modified by Dev 2196 on 08/10/2021
/// Purpose : This is a app color class, we will keep the common colors here.

class PermissionsService {
  PermissionsService._();
  Future<bool> requestPermissions(Permission permission) async {
    final permissionStatus = await permission.status;
    switch (permissionStatus) {
      case PermissionStatus.granted:
        break;
      case PermissionStatus.denied:
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.restricted:
        break;
      case PermissionStatus.permanentlyDenied:
        break;
      default:
        return false;
    }
    return false;
  }
}
