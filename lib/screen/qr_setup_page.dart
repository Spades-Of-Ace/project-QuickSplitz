import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class QRSetupPage extends StatefulWidget {
  const QRSetupPage({Key? key}) : super(key: key);

  @override
  _QRSetupPageState createState() => _QRSetupPageState();
}

class _QRSetupPageState extends State<QRSetupPage> {
  String? _imagePath; // Variable to store the path of the selected image

  Future<void> _choosePhoto() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery); // Choose photo from gallery

      if (pickedFile != null) {
        setState(() {
          _imagePath = pickedFile.path; // Update the state with the selected image path
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e'); // Print any error that occurs
      _showErrorDialog('Failed to pick image. Please try again.'); // Show error dialog
    }
  }

  // Show an error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
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
          color: Colors.white, // White background for the middle section
          width: double.infinity,
          height: double.infinity,
          child: _imagePath == null
              ? const Center(
            child: Text(
              'No image selected.',
              style: TextStyle(fontSize: 24),
            ),
          )
              : Image.file(
            File(_imagePath!), // Display the selected image
            fit: BoxFit.cover,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF72777F), // Bottom bar color
        child: Center(
          child: ElevatedButton(
            onPressed: _choosePhoto, // Choose photo action
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text(
              'Choose Photo',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
