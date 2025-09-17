import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io'; // To check the platform (Android/iOS)

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Request permission when the widget is first created.
    _requestStoragePermission();
  }

  // --- The Core Permission Logic ---
  Future<void> _requestStoragePermission() async {
    // Determine which permission to request based on the platform and Android version.
    Permission permission;
    if (Platform.isAndroid) {
      // For Android, we request the 'storage' permission group which handles the logic internally.
      // On modern Android versions, this will trigger the new granular media permissions dialogs.
      permission = Permission.storage;
    } else if (Platform.isIOS) {
      // For iOS, we request photos permission.
      permission = Permission.photos;
    } else {
      // Handle other platforms if necessary
      return;
    }

    // Check the status of the permission.
    final status = await permission.request();

    if (status.isGranted) {
      // Permission is granted. You can now access storage.
      print('Storage permission granted!');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission Granted!')),
      );
    } else if (status.isDenied) {
      // Permission is denied. Show a message to the user.
      print('Storage permission denied.');
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission Denied. The feature may not work.')),
      );
    } else if (status.isPermanentlyDenied) {
      // The user has permanently denied the permission.
      // You need to guide them to the app settings.
      print('Storage permission permanently denied.');
      _showSettingsDialog();
    }
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content: const Text('This app needs storage permission to function properly. Please enable it in the app settings.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () {
                // This opens the app settings page.
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission Example'),
      ),
      body: const Center(
        child: Text('Checking for storage permission on startup...'),
      ),
    );
  }
}