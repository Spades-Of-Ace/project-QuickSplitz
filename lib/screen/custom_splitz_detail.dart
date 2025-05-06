import 'package:flutter/material.dart';

class CustomSplitzDetail extends StatelessWidget {
  final double amount;
  final int totalPeople;
  final int discPeople;
  final double pct;

  const CustomSplitzDetail({
    Key? key,
    required this.amount,
    required this.totalPeople,
    required this.discPeople,
    required this.pct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> details = [];

    details.add('Total bill: \$${amount.toStringAsFixed(2)}');
    details.add('Number of people: $totalPeople');
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

    return Container(
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
    );
  }
}
