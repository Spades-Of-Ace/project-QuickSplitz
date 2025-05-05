import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'payment_page.dart';

class EvenSplitzPage extends StatefulWidget {
  final String imagePath;
  final String name;

  const EvenSplitzPage({
    Key? key,
    required this.imagePath,
    required this.name,
  }) : super(key: key);

  @override
  _EvenSplitzPageState createState() => _EvenSplitzPageState();
}

class _EvenSplitzPageState extends State<EvenSplitzPage> {
  final TextEditingController _amountCtl = TextEditingController();
  final TextEditingController _peopleCtl = TextEditingController();
  String _displayTotal = '';

  void _calculate() {
    final amount = double.tryParse(_amountCtl.text) ?? 0;
    final people = int.tryParse(_peopleCtl.text) ?? 1;
    if (amount > 0 && people > 0) {
      final split = amount / people;
      setState(() {
        _displayTotal = '\$${split.toStringAsFixed(2)}';
      });
      _save(amount, people);
    } else {
      _showError('Invalid input');
    }
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

  Future<void> _save(double totalAmount, int people) async {
    final prefs = await SharedPreferences.getInstance();
    final tx = prefs.getStringList('transactions') ?? [];
    final formatted = 'Even|${widget.name}|${totalAmount.toStringAsFixed(2)}|$people';
    tx.add(formatted);
    await prefs.setStringList('transactions', tx);
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
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Text('Hi, ${widget.name}!', style: const TextStyle(color: Colors.white, fontSize: 18)),
                  const SizedBox(height: 10),
                  _buildInput('Total Bill Amount', _amountCtl),
                  const SizedBox(height: 10),
                  _buildInput('Number of People', _peopleCtl),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _calculate,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text('Splitz', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 20),
                  Text(_displayTotal, style: const TextStyle(fontSize: 24, color: Colors.white)),
                ],
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
                    total: _displayTotal,
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
