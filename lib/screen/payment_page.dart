import 'package:flutter/material.dart';
import 'home_page.dart';

class PaymentPage extends StatelessWidget {
  final String imagePath;
  final String total;

  const PaymentPage({
    Key? key,
    required this.imagePath,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const grayColor = Color(0xFF72777F);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: grayColor,
        title: Center(
          child: Image.asset('assets/images/logo/logo.png', height: 50),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: grayColor, // Make whole background gray
      body: Column(
        children: [
          Container(height: 50, color: Colors.white), // Top white gap
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Use a smaller QR image, similar to QR setup
                Image.asset('assets/images/qr/qr.png', height: 350),
                const SizedBox(height: 40),
                Text(
                  total,
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                          (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: const Text('Confirm Payment', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Container(height: 50, color: Colors.white), // Bottom white gap
        ],
      ),
    );
  }
}
