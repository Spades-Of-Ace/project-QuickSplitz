import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'transaction_detail_page.dart'; // Import the Transaction Detail Page

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  Future<List<String>> _loadTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('transactions') ?? [];
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
      body: FutureBuilder<List<String>>(
        future: _loadTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No transactions available.'));
          }

          final transactions = snapshot.data!;

          return Column(
            children: [
              Container(
                height: 50, // Height of the white gap
                color: Colors.white, // White background for the gap
              ),
              Container(
                height: 25, // Height of the colored gap
                color: const Color(0xFF72777F), // Set the desired color for the gap
              ),
              Expanded(
                child: Container(
                  color: const Color(0xFF72777F), // Set the background for transaction area to white
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index].split(": "); // Split to get name and total
                      final transactionName = transaction[0];
                      final transactionTotal = transaction.length > 1 ? transaction[1] : 'Unknown';

                      return GestureDetector(
                        onTap: () {
                          // Navigate to Transaction Detail Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransactionDetailPage(
                                transactionName: transactionName,
                                totalAmount: double.tryParse(transactionTotal.split('\$')[1]) ?? 0.0,
                                numberOfPeople: 1, // This value can be adjusted based on your logic
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white, // Gray background for transaction
                              borderRadius: BorderRadius.circular(10), // Rounded corners
                            ),
                            child: Text(
                              transactionName, // Display the transaction name
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF72777F), // Bottom bar color
        child: Container(), // No buttons in the bottom bar
      ),
    );
  }
}
