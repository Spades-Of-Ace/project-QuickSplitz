import 'package:flutter/material.dart';
import 'even_splitz_page.dart'; // Import the Even Splitz Page

class SplitSelectionPage extends StatelessWidget {
  const SplitSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF72777F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Image.asset('assets/images/logo/logo.png', height: 50),
        ),
      ),
      body: Container(
        color: Colors.white, // White background for the page
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: const Text(
            'Select a Split Option',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF72777F), // Bottom bar color
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Even Splitz Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EvenSplitzPage(imagePath: '',)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                'Even Splitz',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to Custom Splitz Page (not implemented yet)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                'Custom Splitz',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
