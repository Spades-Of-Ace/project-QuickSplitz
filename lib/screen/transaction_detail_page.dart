import 'package:flutter/material.dart';

class TransactionDetailPage extends StatelessWidget {
  final String type;
  final String name;
  final double amount;
  final int totalPeople;
  final int discPeople;
  final double pct;

  const TransactionDetailPage({
    Key? key,
    required this.type,
    required this.name,
    required this.amount,
    required this.totalPeople,
    required this.discPeople,
    required this.pct, required List<String> breakdown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> details = [];

    details.add('Transaction type: $type');
    details.add('Name: $name');
    details.add('Total bill: \$${amount.toStringAsFixed(2)}');
    details.add('Number of people: $totalPeople');

    if (type == 'Custom') {
      details.add('Number of people with discount: $discPeople');
      details.add('Discount percentage: ${pct.toStringAsFixed(0)}%');

      int normalPeople = totalPeople - discPeople;

      // Amount discounted totally
      double totalDiscount = (amount / totalPeople) * (pct / 100) * discPeople;

      // Remaining amount to split among non-discount people
      double remaining = amount - totalDiscount;

      // Base share per non-discount person
      double baseShare = (remaining / normalPeople);
      double roundedBase = (baseShare * 100).floorToDouble() / 100;
      double diff = remaining - (roundedBase * normalPeople);

      int discIndex = 0;
      int normalIndex = 0;

      for (int i = 0; i < totalPeople; i++) {
        if (i < discPeople) {
          details.add('Person ${i + 1}: \$0.00 (Disc)');
          discIndex++;
        } else {
          double personShare = roundedBase;
          // Add the leftover cents to the last person
          if (normalIndex == normalPeople - 1) {
            personShare += diff;
          }
          details.add('Person ${i + 1}: \$${personShare.toStringAsFixed(2)}');
          normalIndex++;
        }
      }
    } else {
      // Even split
      double baseShare = (amount / totalPeople);
      double roundedBase = (baseShare * 100).floorToDouble() / 100;
      double diff = amount - (roundedBase * totalPeople);

      for (int i = 0; i < totalPeople; i++) {
        double personShare = roundedBase;
        if (i == totalPeople - 1) {
          personShare += diff;
        }
        details.add('Person ${i + 1}: \$${personShare.toStringAsFixed(2)}');
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
