import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Future<bool> requestStoragePermission() async {
    PermissionStatus status;

    // Handle Android 13 and above, which use granular permissions
    if (Theme.of(context).platform == TargetPlatform.android &&
        (await Permission.storage.status).isDenied) {
      if (await Permission.storage.request().isGranted) {
        return true;
      }
    }

    // Handle Android 12 and below, and iOS
    status = await Permission.photos.request();

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      // The user has permanently denied the permission.
      // You should direct them to the app settings.
      openAppSettings();
      return false;
    } else {
      // The user has denied the permission, but can be asked again.
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: Text('Hello World!'))),
    );
  }
}
