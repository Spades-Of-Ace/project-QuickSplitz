import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'payment_page.dart';

class CustomSplitzPage extends StatefulWidget {
  final String imagePath;
  final String name;

  const CustomSplitzPage({
    Key? key,
    required this.imagePath,
    required this.name,
  }) : super(key: key);

  @override
  _CustomSplitzPageState createState() => _CustomSplitzPageState();
}

class _CustomSplitzPageState extends State<CustomSplitzPage> {
  final TextEditingController _amountCtl = TextEditingController();
  final TextEditingController _discPctCtl = TextEditingController();
  final TextEditingController _peopleCtl = TextEditingController();
  final TextEditingController _discPeopleCtl = TextEditingController();

  List<String> _results = [];
  String _total = '';

  void _calculate() {
    final a = double.tryParse(_amountCtl.text) ?? 0;
    final pct = double.tryParse(_discPctCtl.text) ?? 0;
    final n = int.tryParse(_peopleCtl.text) ?? 0;
    final d = int.tryParse(_discPeopleCtl.text) ?? 0;

    if (a <= 0 || n <= 0 || d > n) {
      _showError('Invalid input');
      return;
    }

    final equalShare = a / n;
    final discountedPay = equalShare * (1 - pct / 100);
    final discountedTotal = discountedPay * d;

    final remaining = a - discountedTotal;
    final payingPeople = n - d;

    if (payingPeople <= 0) {
      _showError('No one left to cover the rest.');
      return;
    }

    final undiscShare = remaining / payingPeople;

    final r = <String>[];
    for (var i = 0; i < n; i++) {
      if (i < d) {
        r.add('Person ${i + 1}: \$${discountedPay.toStringAsFixed(2)} (Disc)');
      } else {
        r.add('Person ${i + 1}: \$${undiscShare.toStringAsFixed(2)}');
      }
    }

    setState(() {
      _results = r;
      _total = '\$${a.toStringAsFixed(2)}';
    });

    _saveTransaction(a, n, d, pct, r);
  }

  Future<void> _saveTransaction(double amount, int totalPeople, int discPeople, double pct, List<String> breakdown) async {
    final prefs = await SharedPreferences.getInstance();
    final tx = prefs.getStringList('transactions') ?? [];
    final breakdownStr = breakdown.join(';');
    final formatted = 'Custom|${widget.name}|${amount.toStringAsFixed(2)}|$totalPeople|$discPeople|${pct.toStringAsFixed(2)}|$breakdownStr';
    tx.add(formatted);
    await prefs.setStringList('transactions', tx);
  }

  void _showError(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(msg),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Image.asset('assets/images/logo/logo.png', height: 50)),
        backgroundColor: const Color(0xFF72777F),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        children: [
          Container(height: 50, color: Colors.white),
          Expanded(
            child: Container(
              color: const Color(0xFF72777F),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text('Hi, ${widget.name}!', style: const TextStyle(color: Colors.white, fontSize: 18)),
                    const SizedBox(height: 20),
                    _buildInput('Total Bill Amount', _amountCtl),
                    const SizedBox(height: 10),
                    _buildInput('Discount Percentage', _discPctCtl),
                    const SizedBox(height: 10),
                    _buildInput('Number of People', _peopleCtl),
                    const SizedBox(height: 10),
                    _buildInput('People with Discount', _discPeopleCtl),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _calculate,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                      child: const Text('Splitz', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 20),
                    ..._results.map((r) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(r, style: const TextStyle(color: Colors.white, fontSize: 16)),
                    )),
                  ],
                ),
              ),
            ),
          ),
          Container(height: 50, color: Colors.white),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF72777F),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentPage(
                    imagePath: widget.imagePath,
                    total: _total,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text('Payment', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController ctl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: TextField(
          controller: ctl,
          decoration: InputDecoration(labelText: label, border: InputBorder.none, contentPadding: const EdgeInsets.all(16)),
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}
