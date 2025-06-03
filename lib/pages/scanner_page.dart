import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'preview_page.dart';
import 'package:easy_localization/easy_localization.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;
  String? _lastImagePath;

  @override
  void initState() {
    super.initState();
    _initCamera();

    // Fullscreen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    if (_cameras!.isNotEmpty) {
      _controller = CameraController(
        _cameras![0],
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _controller!.initialize();
      await _controller!.setFlashMode(FlashMode.off);

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    }
  }

  Future<void> _takePicture() async {
    if (!_controller!.value.isInitialized) return;

    final Directory tempDir = await getTemporaryDirectory();
    final String filePath = p.join(tempDir.path, '${DateTime.now()}.jpg');

    try {
      final XFile image = await _controller!.takePicture();
      await image.saveTo(filePath);

      setState(() {
        _lastImagePath = filePath;
      });

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PreviewPage(imagePath: filePath)),
        );
      }
    } catch (e) {
      debugPrint('scan.Gagal mengambil gambar: $e'.tr());
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    // Kembalikan status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
          !_isInitialized
              ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
              : Stack(
                children: [
                  CameraPreview(_controller!),

                  // Tombol kembali (pojok kiri atas)
                  Positioned(
                    top: 50,
                    left: 16,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  // Tombol bawah
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 24,
                      ),
                      color: Colors.black.withOpacity(0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Thumbnail gambar terakhir
                          GestureDetector(
                            onTap: () {
                              if (_lastImagePath != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => PreviewPage(
                                          imagePath: _lastImagePath!,
                                        ),
                                  ),
                                );
                              }
                            },
                            child:
                                _lastImagePath != null
                                    ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        File(_lastImagePath!),
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                    : const Icon(
                                      Icons.photo,
                                      color: Colors.white70,
                                      size: 32,
                                    ),
                          ),

                          // Tombol shutter tengah
                          GestureDetector(
                            onTap: _takePicture,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 36,
                                ),
                              ),
                            ),
                          ),

                          // Spacer kanan
                          const SizedBox(width: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
