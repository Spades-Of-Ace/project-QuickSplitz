import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quicksplitz/providers/theme_provider.dart';
import 'package:quicksplitz/screen/home_page.dart';
import 'package:quicksplitz/screen/history_page.dart';
import 'package:quicksplitz/screen/new_splitz_page.dart';
import 'package:quicksplitz/screen/landing_page.dart'; // Import Landing Page
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ThemeData theme = await ThemeProvider.loadTheme();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? loggedInUser = prefs.getString("logged_in_user");

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(theme),
      child: MyApp(isLoggedIn: loggedInUser != null),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'QuickSplitz',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData,
          home: isLoggedIn ? const HomePage() : const LandingPage(),
          routes: {
            '/new_splitz': (context) => const NewSplitzPage(),
            '/history': (context) => const HistoryPage(),
          },
        );
      },
    );
  }
}
