import 'package:flutter/material.dart';
import 'package:glowup_app/screens/onboarding_screen.dart';
import 'package:glowup_app/screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grit & Glow',
      theme: ThemeData(
        primaryColor: Color(0xFF2C3E50),

        // accentColor: Color(0xFFE74C3C),
        // backgroundColor: Color(0xFFF8F9FA),
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      initialRoute: '/onboarding',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
      },
    );
  }
}
