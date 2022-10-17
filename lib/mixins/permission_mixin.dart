import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../exports/resources.dart';
import '../exports/utilities.dart';
import '../exports/widgets.dart';

/// Created by Dev 2301 on 8/12/2021
/// Modified by Dev 2196 on 8/12/2021
/// Purpose : mixin for app permissions
mixin PermissionMixin {
  /// Created by Dev 2301 on 8/12/2021
  /// Modified by Dev 2196 on 8/12/2021
  /// Purpose : function to request and grant permission
  Future<bool> grantPermission(
      Permission permission, BuildContext context) async {
    var status = await permission.status;

    Logger.d("permission", "status - $status");
    if (status == PermissionStatus.granted) {
      return true;
    }
    if (status == PermissionStatus.denied) {
      status = await permission.request();
      if (status.isPermanentlyDenied == true) {
        _askToOpenAppSettings(
            context,
            permission == Permission.camera
                ? AppStrings.msgCameraPermission
                : AppStrings.msgStoragePermission);
      } else {
        if (status.isGranted) {
          return true;
        }
      }
      return false;
    }

    if (status == PermissionStatus.permanentlyDenied) {
      _askToOpenAppSettings(
          context,
          permission == Permission.camera
              ? AppStrings.msgCameraPermission
              : AppStrings.msgStoragePermission);
      return false;
    }
    return false;
  }

  /// Created by Dev 2301 on 8/12/2021
  /// Modified by Dev 2301 on 8/12/2021
  /// Purpose : open app settings to manually allow storage access
  void _askToOpenAppSettings(BuildContext context, String msg) {
    CustomAlert().showConfirmationAlertDialog(
      context,
      title: AppStrings.permissionRequired,
      content: msg,
      btnOkText: AppStrings.ok,
      onOkTap: () async {
        Navigator.of(context, rootNavigator: true).pop();
        await openAppSettings();
      },
    );
  }
}

typedef OnPermanentlyDenied = void Function();

typedef OnGranted = void Function();

class PermissionService {
  Future<void> requestForPermission(
      {required Permission permission,
      required OnPermanentlyDenied onPermatentlyDenied,
      required OnGranted onGranted}) async {
    final status = await permission.status;
    if (status == PermissionStatus.granted) {
      onGranted.call();
      return;
    } else if (status == PermissionStatus.denied) {
    } else if (status == PermissionStatus.permanentlyDenied) {
      onPermatentlyDenied.call();
      return;
    }
  }
}
