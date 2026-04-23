import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seedBlue = Color(0XFF60c9f8);
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedBlue,
      brightness: Brightness.light,
    );
    final textTheme = GoogleFonts.nunitoSansTextTheme().copyWith(
      headlineLarge: GoogleFonts.nunitoSans(
        fontSize: 34,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.2,
      ),
      titleLarge: GoogleFonts.nunitoSans(
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: GoogleFonts.nunitoSans(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),
      bodyLarge: GoogleFonts.nunitoSans(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.45,
      ),
      bodyMedium: GoogleFonts.nunitoSans(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1.45,
      ),
      labelMedium: GoogleFonts.nunitoSans(
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
      labelLarge: GoogleFonts.nunitoSans(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );

    return MaterialApp(
      title: 'Restaurant Menu',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.surface,
        textTheme: textTheme,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          titleTextStyle: textTheme.titleLarge?.copyWith(
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 1.5,
          color: colorScheme.surfaceContainerLow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            textStyle: textTheme.labelLarge,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
