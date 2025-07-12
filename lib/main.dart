import 'package:flutter/material.dart';
import 'package:glowup_app/poviders/fitness_provider.dart';
import 'package:glowup_app/poviders/habit_provider.dart';
import 'package:glowup_app/poviders/mind_provider.dart';
import 'package:glowup_app/poviders/progress_provider.dart';
import 'package:glowup_app/poviders/style_provider.dart';
import 'package:glowup_app/poviders/user_provdier.dart';
import 'package:glowup_app/screens/home_screen.dart';
import 'package:glowup_app/screens/onboarding_screen.dart';
import 'package:glowup_app/screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => HabitProvider()),
      ChangeNotifierProvider(create: (_) => FitnessProvider()),
      ChangeNotifierProvider(create: (_) => StyleProvider()),
      ChangeNotifierProvider(create: (_) => MindProvider()),
      ChangeNotifierProvider(create: (_) => ProgressProvider()),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grit & Glow',
        theme: ThemeData(
          primaryColor: Color(0xFF2C3E50),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.amber
          ),

          // accentColor: Color(0xFFE74C3C),
          // backgroundColor: Color(0xFFF8F9FA),
          textTheme: GoogleFonts.montserratTextTheme(),
        ),
        initialRoute: '/home',
        routes: {
          '/splash': (context) => SplashScreen(),
          '/onboarding': (context) => OnboardingScreen(),
          '/home': (context) => HomeScreen(),
          // '/glow-up': (context) => GlowUpScreen(),
          // '/fitness': (context) => FitnessScreen(),
          // '/style': (context) => StyleScreen(),
          // '/mind': (context) => MindScreen(),
          // '/progress': (context) => ProgressScreen(),
          // '/profile': (context) => ProfileScreen(),
        },
      ),);
  }
}
