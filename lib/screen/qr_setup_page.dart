// lib/screen/qr_setup_page.dart
import 'package:flutter/material.dart';
import 'package:quicksplitz/screen/payment_page.dart';

class QRSetupPage extends StatelessWidget {
  const QRSetupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const assetPath = 'assets/images/qr/qr.png';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF72777F),
        leading: BackButton(color: Colors.white),
        title: Center(
          child: Image.asset('assets/images/logo/logo.png', height: 50),
        ),
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Image.asset(
            assetPath,
            fit: BoxFit.contain,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF72777F),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // When pressed, just navigate back or forward as you like;
              // but we can also pass this assetPath to PaymentPage:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentPage(
                    imagePath: assetPath,
                    total: '—', // you can pass an actual amount here
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text('Use This QR', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
