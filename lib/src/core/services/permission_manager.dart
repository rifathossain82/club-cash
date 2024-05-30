import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PermissionManager {
  static Future<bool> requestContactPermission() async {
    return await _requestPermission(
      permission: Permission.contacts,
      permissionName: 'Contact',
    );
  }

  static Future<bool> _requestPermission({
    required Permission permission,
    required String permissionName,
  }) async {
    final PermissionStatus status = await permission.request();
    switch (status) {
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.denied:
        return await _handleDeniedPermission(
          permission: permission,
          permissionName: permissionName,
        );
      case PermissionStatus.permanentlyDenied:
        return await _handlePermanentlyDeniedPermission(
          permissionName: permissionName,
        );
      default:
        return false;
    }
  }

  static Future<bool> _handleDeniedPermission({
    required Permission permission,
    required String permissionName,
  }) async {
    final bool reRequested = await _showPermissionDeniedDialog(
      permissionName: permissionName,
    );
    if (reRequested) {
      return await _requestPermission(
        permission: permission,
        permissionName: permissionName,
      );
    } else {
      return false;
    }
  }

  static Future<bool> _handlePermanentlyDeniedPermission({
    required String permissionName,
  }) async {
    _showPermissionSettingsDialog(permissionName: permissionName);
    return false;
  }

  static Future<bool> _showPermissionDeniedDialog({
    required String permissionName,
  }) async {
    return await Get.dialog<bool>(
          AlertDialog(
            title: const Text('Permission Denied'),
            content: Text(
              'This app requires $permissionName permission to function properly. Would you like to request it again?',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Get.back(result: true),
                child: const Text('Request Again'),
              ),
              TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text('Cancel'),
              ),
            ],
          ),
          barrierDismissible: false,
        ) ??
        false; // Default to false if user cancels dialog
  }

  static void _showPermissionSettingsDialog({required String permissionName}) {
    Get.dialog(
      AlertDialog(
        title: const Text('Permission Required'),
        content: Text(
          'This app requires $permissionName permission to function properly. Please enable it in your device settings.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
