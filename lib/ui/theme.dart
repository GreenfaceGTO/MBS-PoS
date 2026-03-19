import 'package:flutter/material.dart';

class AppTema {
  static ThemeData tema = ThemeData(
    visualDensity: const VisualDensity(vertical: -4),
    colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo, brightness: Brightness.light)
        .copyWith(
            primary: Colors.indigo,
            secondary: Colors.indigoAccent,
            surface: Colors.white),
    textTheme: ThemeData.light().textTheme.copyWith(
          bodySmall: const TextStyle(fontSize: 10),
          bodyMedium: const TextStyle(fontSize: 12),
          bodyLarge: const TextStyle(fontSize: 13),
          titleSmall:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          titleMedium:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          titleLarge:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
    useMaterial3: true,
  );
}
