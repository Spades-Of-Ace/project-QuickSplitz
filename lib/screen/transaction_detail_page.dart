import 'package:flutter/material.dart';

class TransactionDetailPage extends StatelessWidget {
  final String type; // 'Even' or 'Custom'
  final String name;
  final double totalAmount;
  final int numberOfPeople;

  // Only for Custom
  final int? discountedPeople;
  final double? discountPercentage;

  const TransactionDetailPage({
    Key? key,
    required this.type,
    required this.name,
    required this.totalAmount,
    required this.numberOfPeople,
    this.discountedPeople,
    this.discountPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF72777F);

    List<String> breakdown = [];

    if (type == 'Custom' &&
        discountedPeople != null &&
        discountPercentage != null &&
        discountedPeople! <= numberOfPeople) {
      double totalDiscount = totalAmount * (discountPercentage! / 100);
      double remainingAmount = totalAmount - totalDiscount;
      int nonDiscountedPeople = numberOfPeople - discountedPeople!;
      double regularShare = remainingAmount / nonDiscountedPeople;

      for (int i = 0; i < numberOfPeople; i++) {
        if (i < discountedPeople!) {
          breakdown.add('Person ${i + 1}: \$0.00 (Disc)');
        } else {
          breakdown.add(
              'Person ${i + 1}: \$${regularShare.toStringAsFixed(2)}');
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Center(
          child: Image.asset(
            'assets/images/logo/logo.png',
            height: 50,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(height: 50, color: Colors.white),
          Container(height: 25, color: backgroundColor),
          Expanded(
            child: Container(
              color: backgroundColor,
              width: double.infinity,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        _info('Transaction Type', type),
                        _info('Total Bill', '\$${totalAmount.toStringAsFixed(2)}'),
                        _info('Number of People', '$numberOfPeople'),
                        if (type == 'Even') ...[
                          const SizedBox(height: 10),
                          _info('Each Person Pays',
                              '\$${(totalAmount / numberOfPeople).toStringAsFixed(2)}'),
                        ],
                        if (type == 'Custom' &&
                            discountedPeople != null &&
                            discountPercentage != null) ...[
                          const SizedBox(height: 10),
                          _info('Number with Discount', '$discountedPeople'),
                          _info('Discount Percentage',
                              '${discountPercentage!.toStringAsFixed(0)}%'),
                          const Divider(height: 30),
                          const SizedBox(height: 10),
                          const Text(
                            'Breakdown',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          for (var line in breakdown)
                            Text(
                              line,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: backgroundColor,
        child: const SizedBox(height: 50),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}
