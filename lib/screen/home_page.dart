import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quicksplitz/providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'qr_scan_page.dart';
import 'qr_setup_page.dart';
import 'history_page.dart';
import 'new_splitz_page.dart';
import 'landing_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _showThemeSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 250,
          color: Colors.grey[900],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Select Theme",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              ListTile(
                title: Text("Dark Theme", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false).setTheme(ThemeData.dark());
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Elegant Gold", style: TextStyle(color: Colors.orange[600])),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false).setTheme(elegantGoldTheme);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Pixel Retro", style: TextStyle(color: Colors.lightGreenAccent)),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false).setTheme(pixelRetroTheme);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove("logged_in_user"); // ✅ Clear login session

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LandingPage()),
                      (route) => false, // ✅ Clear all previous pages
                );
              },
              child: const Text("Logout", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => _showThemeSelector(context), // Only open theme selector on double tap
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF72777F), // ✅ Top bar color same as bottom bar
          title: Center(
            child: GestureDetector(
              onTap: () => _confirmLogout(context), // Tap logo to log out
              child: Image.asset('assets/images/logo/logo.png', height: 50),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QRScanPage()),
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.qr_code, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QRSetupPage()),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Container(
            color: Colors.white, // White background for the main content
            width: double.infinity,
            height: double.infinity,
            child: const Center(
              child: Text(
                'Welcome to QuickSplitz!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xFF72777F), // ✅ Bottom bar color
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NewSplitzPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  'New Splitz',
                  style: TextStyle(color: Color(0xFF05FF26), fontSize: 16), // "z" in green
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HistoryPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  'History',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
