import 'package:flutter/material.dart';
import 'custom_splitz_detail.dart';

class TransactionDetailPage extends StatelessWidget {
  final String type;
  final String name;
  final double amount;
  final int totalPeople;
  final int discPeople;
  final double pct;
  final List<String> breakdown;

  const TransactionDetailPage({
    Key? key,
    required this.type,
    required this.name,
    required this.amount,
    required this.totalPeople,
    required this.discPeople,
    required this.pct,
    required this.breakdown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> details = [];

    // Common details for both split types
    details.add('Transaction type: $type');
    details.add('Name: $name');
    details.add('Total bill: \$${amount.toStringAsFixed(2)}');
    details.add('Number of people: $totalPeople');

    // Even Split logic
    if (type == 'Even') {
      double baseShare = (amount / totalPeople);
      double roundedBase = (baseShare * 100).floorToDouble() / 100;
      double diff = double.parse((amount - (roundedBase * totalPeople)).toStringAsFixed(2));

      for (int i = 0; i < totalPeople; i++) {
        double personShare = roundedBase;
        if (i == totalPeople - 1) {
          personShare += diff;
        }
        details.add('Person ${i + 1}: \$${personShare.toStringAsFixed(2)}');
      }
    }

    // Custom Split logic
    else if (type == 'Custom') {
      details.add('Number of people with discount: $discPeople');
      details.add('Discount percentage: ${pct.toStringAsFixed(0)}%');

      int normalPeople = totalPeople - discPeople;  // People without discount

      // Calculate the total discount amount
      double totalDiscount = (amount / totalPeople) * (pct / 100) * discPeople;
      double remaining = amount - totalDiscount;  // Remaining amount to be split

      // Split remaining amount among normal people
      double baseShare = remaining / normalPeople;
      double roundedBase = (baseShare * 100).floorToDouble() / 100;
      double diff = double.parse((remaining - (roundedBase * normalPeople)).toStringAsFixed(2));

      int discIndex = 0;
      int normalIndex = 0;

      // Iterate through totalPeople to display the breakdown
      for (int i = 0; i < totalPeople; i++) {
        if (discIndex < discPeople) {
          details.add('Person ${i + 1}: \$0.00 (Disc)');
          discIndex++;
        } else {
          // Ensure people without discount share the remaining amount
          double personShare = roundedBase;
          if (normalIndex == normalPeople - 1) {
            personShare += diff;
          }
          details.add('Person ${i + 1}: \$${personShare.toStringAsFixed(2)}');
          normalIndex++;
        }
      }
    }

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
          Container(height: 50, color: Colors.white),
          Expanded(
            child: Container(
              color: const Color(0xFF72777F),
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: details.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        details[index],
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(height: 50, color: Colors.white),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF72777F),
        child: Container(height: 50),
      ),
    );
  }
}
