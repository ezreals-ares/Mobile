import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();

  runApp(const CameraApp());
}

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  XFile? image;

  @override
  void initState() {
    super.initState();

    controller = CameraController(
      _cameras[0],
      ResolutionPreset.max,
    );

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }

      setState(() {});
    }).catchError((Object e) {
      if (!mounted) {
        return;
      }

      setState(() {});
    });
  }

  Future<void> takePicture() async {
    if (!controller.value.isInitialized) {
      return;
    }

    if (controller.value.isTakingPicture) {
      return;
    }

    try {
      final XFile photo = await controller.takePicture();

      setState(() {
        image = photo;
      });
    } catch (e) {
      // Gagal mengambil foto
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            CameraPreview(controller),

            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Center(
                child: FloatingActionButton(
                  onPressed: takePicture,
                  child: const Icon(Icons.camera_alt),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
