import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'transaction_detail_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF72777F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Center(
          child: Image.asset('assets/images/logo/logo.png', height: 50),
        ),
      ),
      body: _transactions.isEmpty
          ? const Center(child: Text('No transactions available.'))
          : Column(
        children: [
          Container(height: 50, color: Colors.white),
          Container(height: 25, color: const Color(0xFF72777F)),
          Expanded(
            child: Container(
              color: const Color(0xFF72777F),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 5),
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final tx = _transactions[index];
                  final parts = tx.split('|');
                  final type = parts[0];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    child: GestureDetector(
                      onTap: () {
                        if (type == 'Even' && parts.length == 4) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TransactionDetailPage(
                                type: 'Even',
                                name: parts[1],
                                totalAmount:
                                double.tryParse(parts[2]) ?? 0.0,
                                numberOfPeople:
                                int.tryParse(parts[3]) ?? 0,
                              ),
                            ),
                          );
                        } else if (type == 'Custom' && parts.length == 6) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TransactionDetailPage(
                                type: 'Custom',
                                name: parts[1],
                                totalAmount:
                                double.tryParse(parts[2]) ?? 0.0,
                                numberOfPeople:
                                int.tryParse(parts[3]) ?? 0,
                                discountedPeople:
                                int.tryParse(parts[4]) ?? 0,
                                discountPercentage:
                                double.tryParse(parts[5]) ?? 0.0,
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${parts[0]} - ${parts[1]}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF72777F),
        child: const SizedBox(height: 50),
      ),
    );
  }
}
