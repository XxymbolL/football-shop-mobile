import 'package:flutter/material.dart';
import 'package:football_shop_mobile/menu.dart';

void main() {
  runApp(const FootballShopApp());
}

class FootballShopApp extends StatelessWidget {
  const FootballShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alpha Shoes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.blueAccent[400]),
        useMaterial3: true,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
