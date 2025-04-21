import 'package:flutter/material.dart';

class LoginModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.black,
      title: Center(
        child: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Enter email or phone number",
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white10,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle login logic
              Navigator.pop(context); // Close modal after login
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: Text("Login"),
          ),
        ],
      ),
    );
  }
}
