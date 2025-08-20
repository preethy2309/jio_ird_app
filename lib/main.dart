import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/ui/screens/cart_screen.dart';
import 'package:jio_ird/ui/screens/menu_screen.dart';
import 'package:jio_ird/ui/theme/app_colors.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          secondary: Colors.amber,
          primary: AppColors.primary,
          brightness: Brightness.dark,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/menu',
      routes: {
        '/menu': (context) => const MenuScreen(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}

// Environment configuration
enum Environment { dev, prod }

const currentEnv = Environment.prod;
