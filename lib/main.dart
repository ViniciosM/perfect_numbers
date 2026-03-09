import 'package:flutter/material.dart';
import 'package:perfect_numbers/core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfect Numbers',
      home: Scaffold(body: Center(child: Text('Perfect Numbers'))),
    );
  }
}
