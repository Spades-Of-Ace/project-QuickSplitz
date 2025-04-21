import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // Import the camera package

class QRScanPage extends StatefulWidget {
  const QRScanPage({Key? key}) : super(key: key);

  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  CameraController? _controller; // Controller for the camera
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Get the available cameras and initialize the controller
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    _initializeControllerFuture = _controller?.initialize();
  }

  @override
  void dispose() {
    _controller?.dispose(); // Dispose of the controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF72777F), // Top bar color
        title: Center(
          child: Image.asset('assets/images/logo/logo.png', height: 50), // Logo in the AppBar
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.white, // White background for the page
          width: double.infinity,
          height: double.infinity,
          child: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: 1.0, // Adjust aspect ratio as needed
                  child: CameraPreview(_controller!), // Display the camera preview
                );
              } else {
                return const Center(child: CircularProgressIndicator()); // Loading indicator while initializing
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF72777F), // Bottom bar color
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // Logic for scanning text (implement your scanning functionality here)
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text(
              'Scan',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
