import 'package:flutter/material.dart';

class TransactionDetailPage extends StatelessWidget {
  final String transactionName;
  final double totalAmount;
  final int numberOfPeople;

  const TransactionDetailPage({
    Key? key,
    required this.transactionName,
    required this.totalAmount,
    required this.numberOfPeople,
  }) : super(key: key);

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
      body: Column(
        children: [
          Container(
            height: 50, // Height of the white gap
            color: Colors.white, // White background for the gap
          ),
          const SizedBox(height: 25), // Space between top and middle
          Expanded(
            child: Container(
              color: const Color(0xFF72777F), // Gray background for middle section
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transaction Name: $transactionName',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Number of People: $numberOfPeople',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
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
        child: Container(), // No buttons in the bottom bar
      ),
    );
  }
}
