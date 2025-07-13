import 'package:flutter/material.dart';
import 'package:gal2/providers/selection_provider.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';

void main() {
runApp(
    ChangeNotifierProvider(
      create: (context) => SelectionProvider(),
      child: const MyApp(),
    ),
  );}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      title: 'Gallery App',
      home: const HomeScreen(),
    );
  }
}