import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screen/Homescreen.dart';
import 'package:weather_app/screen/stateman.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context)=>Stateman(),
  child: const MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homescreen()
    );
  }
}
