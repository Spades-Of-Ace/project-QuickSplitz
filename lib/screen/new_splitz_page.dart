import 'package:flutter/material.dart';
import 'split_selection_page.dart'; // Import the Split Selection Page

class NewSplitzPage extends StatelessWidget {
  const NewSplitzPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Image.asset('assets/images/logo/logo.png', height: 50),
        ),
        backgroundColor: const Color(0xFF72777F), // Set the top bar color to match the bottom bar
      ),
      body: Column(
        children: [
          // White background container for top area
          Container(
            height: 25, // Height of the white gap
            color: Colors.white,
          ),
          Expanded(
            child: Container(
              color: const Color(0xFF72777F), // Gray background for the input area
              child: Column(
                children: [
                  const SizedBox(height: 25), // 25 pixels gap from the top
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // White background for the name input box
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Enter Name',
                          border: InputBorder.none, // Remove default border
                          contentPadding: const EdgeInsets.all(16), // Padding for the input
                        ),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black), // Bold black text
                      ),
                    ),
                  ),
                  const SizedBox(height: 15), // Space below the text field
                  Expanded(
                    child: Container(
                      color: Colors.white, // White background below the name input
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF72777F), // Bottom bar color
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // Navigate to the Split Selection Page after clicking Next
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SplitSelectionPage()), // Navigate to SplitSelectionPage
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text(
              'Next',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
