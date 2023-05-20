import 'package:custom_search_page/page/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'shadow search',
      theme: ThemeData(fontFamily: null,),
      home: const HomePage(),
    );
  }
}
