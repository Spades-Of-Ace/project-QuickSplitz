import 'package:flutter/material.dart';
import 'package:quicksplitz/screen/split_selection_page.dart';

class NewSplitzPage extends StatefulWidget {
  const NewSplitzPage({Key? key}) : super(key: key);

  @override
  State<NewSplitzPage> createState() => _NewSplitzPageState();
}

class _NewSplitzPageState extends State<NewSplitzPage> {
  final TextEditingController _nameController = TextEditingController();
  final String imagePath = 'assets/images/logo/logo.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF72777F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        // Center the logo properly even with a leading icon
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 50),
            const Spacer(), // balances the back button
          ],
        ),
      ),
      body: Column(
        children: [
          Container(height: 25, color: Colors.white),
          Expanded(
            child: Container(
              color: const Color(0xFF72777F),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Enter Name',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        onSubmitted: (_) => _goToSplitSelection(context),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF72777F),
        child: Center(
          child: ElevatedButton(
            onPressed: () => _goToSplitSelection(context),
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

  void _goToSplitSelection(BuildContext context) {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a name')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SplitSelectionPage(
          name: name,
          imagePath: imagePath,
        ),
      ),
    );
  }
}
