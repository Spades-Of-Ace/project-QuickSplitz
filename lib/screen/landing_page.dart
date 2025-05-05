// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart'; // Import Home Page

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  TextEditingController _controller = TextEditingController();
  bool _isLoginEnabled = false;
  bool _isSignUpEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
    _controller.addListener(_validateInput);
  }

  // ✅ Check if user is already logged in
  Future<void> _checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("logged_in_user");
    if (username != null) {
      _navigateToHome();
    }
  }

  // ✅ Validate input (Enable/Disable buttons)
  void _validateInput() {
    String input = _controller.text.trim();
    SharedPreferences.getInstance().then((prefs) {
      bool userExists = prefs.getString(input) != null;
      setState(() {
        _isLoginEnabled = userExists; // Enable login if user exists
        _isSignUpEnabled = !userExists; // Enable sign-up if user does not exist
      });
    });
  }

  // ✅ Check if email is valid
  bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email);
  }

  // ✅ Check if phone number is a valid Cambodian number
  bool _isValidCambodianPhone(String phone) {
    return RegExp(r"^(\+855|0)[1-9]\d{7,8}$").hasMatch(phone);
  }

  // ✅ Save user on sign-up
  Future<void> _signUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String input = _controller.text.trim();
    await prefs.setString(input, "registered");
    await prefs.setString("logged_in_user", input); // Keep user logged in
    _navigateToHome();
  }

  // ✅ Check user login
  Future<void> _logIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String input = _controller.text.trim();
    bool userExists = prefs.getString(input) != null;
    if (userExists) {
      await prefs.setString("logged_in_user", input);
      _navigateToHome();
    } else {
      _showError("Account does not exist. Please sign up.");
    }
  }

  // ✅ Navigate to Home Page
  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  // ✅ Show error message
  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // ✅ Show login/signup modal
  void _showLoginModal() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) { // This ensures UI updates inside AlertDialog
            return AlertDialog(
              title: const Text("Login / Sign Up"),
              content: TextField(
                controller: _controller, // Keeps input between modal openings
                decoration: const InputDecoration(
                    hintText: "Enter email or Cambodian phone number"
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setStateDialog(() {}); // Updates UI within the modal
                },
              ),
              actions: [
                TextButton(
                  onPressed: _isLoginEnabled ? _logIn : null,
                  child: const Text("Login"),
                ),
                TextButton(
                  onPressed: _isSignUpEnabled ? _signUp : null,
                  child: const Text("Sign Up"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF72777F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo/logo.png',
              height: 150,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Welcome to QuickSplit',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    TextSpan(
                      text: 'z',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF05FF26)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 175),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                onPressed: _showLoginModal,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadowColor: Colors.transparent,
                  elevation: 0,
                ),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Get ',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      TextSpan(
                        text: 'Splitzzing',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF05FF26)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
