import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class PaymentPage extends StatelessWidget {
  final String imagePath; // Path of the image to display
  final String total; // Total amount to display

  const PaymentPage({Key? key, required this.imagePath, required this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF72777F), // Top bar color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Image.asset('assets/images/logo/logo.png', height: 50), // Logo in the AppBar
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 50, // Height of the white gap
            color: Colors.white, // White background for the gap
          ),
          Expanded(
            child: Container(
              color: Colors.white, // White background for the middle section
              child: imagePath.isNotEmpty
                  ? Image.file(
                File(imagePath), // Display the selected image
                fit: BoxFit.cover,
              )
                  : const Center(
                child: Text(
                  'No image selected.',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
          Container(
            height: 50, // Height of the white gap
            color: Colors.white, // White background for the gap
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF72777F), // Bottom bar color
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                total, // Display total amount
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // Save the transaction to shared preferences
                SharedPreferences prefs = await SharedPreferences.getInstance();
                List<String> transactions = prefs.getStringList('transactions') ?? [];
                transactions.add(total);
                await prefs.setStringList('transactions', transactions);

                // Navigate back to Home Page
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()), // Navigate to Home Page
                      (route) => false, // Clear all previous pages
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                'Confirm Payment',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
