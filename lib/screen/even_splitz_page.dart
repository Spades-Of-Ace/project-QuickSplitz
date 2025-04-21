import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'payment_page.dart'; // Import the Payment Page

class EvenSplitzPage extends StatefulWidget {
  final String imagePath; // Image path to be passed from QRSetupPage

  const EvenSplitzPage({Key? key, required this.imagePath}) : super(key: key);

  @override
  _EvenSplitzPageState createState() => _EvenSplitzPageState();
}

class _EvenSplitzPageState extends State<EvenSplitzPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _peopleController = TextEditingController();
  String _total = '';

  void _calculateSplit() {
    final double amount = double.tryParse(_amountController.text) ?? 0;
    final int people = int.tryParse(_peopleController.text) ?? 1;

    if (amount > 0 && people > 0) {
      final double splitAmount = amount / people;
      setState(() {
        _total = 'Total: \$${splitAmount.toStringAsFixed(2)}';
      });
    } else {
      _showError("Please enter valid values.");
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
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

  Future<void> _saveTransaction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> transactions = prefs.getStringList('transactions') ?? [];
    transactions.add('Transaction: $_total'); // Save total
    await prefs.setStringList('transactions', transactions);
  }

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
              color: const Color(0xFF72777F), // Gray background for the input area
              child: Column(
                children: [
                  const SizedBox(height: 25), // Space from the top
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // White background for the amount input box
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _amountController,
                        decoration: const InputDecoration(
                          labelText: 'Amount',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // Space between inputs
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // White background for the number of people input box
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _peopleController,
                        decoration: const InputDecoration(
                          labelText: 'Amount of People',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Space below the inputs
                  ElevatedButton(
                    onPressed: () {
                      _calculateSplit();
                      _saveTransaction(); // Save transaction to history
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text(
                      'Splitz',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20), // Space below the Splitz button
                  Text(
                    _total, // Display total
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
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
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // Navigate to Payment Page, pass imagePath and total
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentPage(
                    imagePath: widget.imagePath, // Pass the image path
                    total: _total, // Pass the calculated total amount
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text(
              'Payment',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
