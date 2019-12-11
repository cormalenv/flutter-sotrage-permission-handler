import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:storage_permissions/src/permission_enums.dart';

/// Provides a cross-platform (iOS, Android) API to request and check permissions.
class StoragePermissions {
  factory StoragePermissions() {
    if (_instance == null) {
      const MethodChannel methodChannel =
          MethodChannel('flutter.baseflow.com/permissions/methods');

      _instance = StoragePermissions.private(methodChannel);
    }
    return _instance;
  }

  @visibleForTesting
  StoragePermissions.private(this._methodChannel);

  static StoragePermissions _instance;

  final MethodChannel _methodChannel;

  /// Check current permission status.
  ///
  /// Returns a [Future] containing the current permission status for the supplied [StoragePermissionLevel].
  Future<PermissionStatus> checkPermissionStatus(
      {StoragePermissionLevel level =
          StoragePermissionLevel.location}) async {
    final int status =
    await _methodChannel.invokeMethod('checkPermissionStatus', level.index);

    return PermissionStatus.values[status];
  }

  /// Check current service status.
  ///
  /// Returns a [Future] containing the current service status for the supplied [LocationPermissionLevel].
  Future<ServiceStatus> checkServiceStatus(
      {StoragePermissionLevel level =
          StoragePermissionLevel.location}) async {
    final int status =
    await _methodChannel.invokeMethod('checkServiceStatus', level.index);

    return ServiceStatus.values[status];
  }

  /// Open the App settings page.
  ///
  /// Returns [true] if the app settings page could be opened, otherwise [false] is returned.
  Future<bool> openAppSettings() async {
    final bool hasOpened = await _methodChannel.invokeMethod('openAppSettings');

    return hasOpened;
  }

  /// Request the user for access to the location services.
  ///
  /// Returns a [Future<PermissionStatus>] containing the permission status.
  Future<PermissionStatus> requestPermissions(
      {StoragePermissionLevel permissionLevel =
          StoragePermissionLevel.location}) async {
    final int status = await _methodChannel.invokeMethod(
        'requestPermission', permissionLevel.index);

    return PermissionStatus.values[status];
  }

  /// Request to see if you should show a rationale for requesting permission.
  ///
  /// This method is only implemented on Android, calling this on iOS always
  /// returns [false].
  Future<bool> shouldShowRequestPermissionRationale(
      {StoragePermissionLevel permissionLevel =
          StoragePermissionLevel.location}) async {
    if (!Platform.isAndroid) {
      return false;
    }

    final bool shouldShowRationale = await _methodChannel.invokeMethod(
        'shouldShowRequestPermissionRationale', permissionLevel.index);

    return shouldShowRationale;
  }
}
