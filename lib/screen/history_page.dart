import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'transaction_detail_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<String> _transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _transactions = prefs.getStringList('transactions') ?? [];
    });
  }

  void _goToDetail(String tx) {
    final parts = tx.split('|');

    if (parts.isEmpty) {
      // Handle invalid transaction format
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid transaction format!")),
      );
      return;
    }

    final type = parts[0]; // "Even" or "Custom"
    final name = parts[1]; // Transaction name
    final amount = double.tryParse(parts[2]) ?? 0;
    final totalPeople = int.tryParse(parts[3]) ?? 0;

    if (type == "Even") {
      // Handle Even Split (no discounts, just equal split)
      final equalAmount = (amount / totalPeople).toStringAsFixed(2);
      final breakdown = List.generate(totalPeople, (_) => equalAmount); // Equal distribution for all people

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TransactionDetailPage(
            type: type,
            name: name,
            amount: amount,
            totalPeople: totalPeople,
            discPeople: 0, // No discounts for Even transactions
            pct: 0, // No discount percentage for Even transactions
            breakdown: breakdown, // Show the equal breakdown
          ),
        ),
      );
    } else if (type == "Custom") {
      // Handle Custom Split (with discounts)
      final discountPeople = int.tryParse(parts[4]) ?? 0; // Get the number of discounted people
      final discountPercentage = double.tryParse(parts[5]) ?? 0; // Get the discount percentage

      // Calculate the total discounted amount for discounted people
      final discountedAmount = amount * (discountPercentage / 100);
      final nonDiscountedAmount = amount - discountedAmount;

      // Calculate the amount for each discounted person
      final discountedPerPerson = discountedAmount / discountPeople;

      // Calculate the remaining amount per person for non-discounted people
      final nonDiscountedPerPerson = nonDiscountedAmount / (totalPeople - discountPeople);

      // Generate the breakdown with the correct amounts for discounted and non-discounted people
      final breakdown = List.generate(
        totalPeople,
            (index) => index < discountPeople
            ? discountedPerPerson.toStringAsFixed(2) // Discounted people
            : nonDiscountedPerPerson.toStringAsFixed(2), // Non-discounted people
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TransactionDetailPage(
            type: type,
            name: name,
            amount: amount,
            totalPeople: totalPeople,
            discPeople: discountPeople,
            pct: discountPercentage,
            breakdown: breakdown, // Show the custom breakdown
          ),
        ),
      );
    } else {
      // Handle invalid transaction type
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid transaction type!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF72777F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF72777F),
        title: Center(
          child: Image.asset('assets/images/logo/logo.png', height: 50),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(height: 50, color: Colors.white), // top white gap
          Expanded(
            child: _transactions.isEmpty
                ? const Center(
              child: Text(
                'No transactions found.',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final tx = _transactions[index];
                final parts = tx.split('|');
                final type = parts[0]; // "Even" or "Custom"
                final name = parts[1]; // Transaction name

                // We now display the transaction name (e.g., "Dinner")
                return GestureDetector(
                  onTap: () => _goToDetail(tx),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        name, // Display the transaction name
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(height: 50, color: Colors.white), // bottom white gap
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF72777F),
        child: Container(height: 50),
      ),
    );
  }
}
