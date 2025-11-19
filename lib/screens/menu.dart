import 'package:flutter/material.dart';
import 'package:football_shop_mobile/widgets/left_drawer.dart';
import 'package:football_shop_mobile/widgets/menu_card.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final List<ItemHomepage> items = [
    ItemHomepage(
      name: "All Products",
      icon: Icons.store_mall_directory,
      color: Colors.black87,
      snackMessage: "Kamu telah menekan tombol All Products",
    ),
    ItemHomepage(
      name: "My Products",
      icon: Icons.inventory_2,
      color: Colors.grey.shade800,
      snackMessage: "Kamu telah menekan tombol My Products",
    ),
    ItemHomepage(
      name: "Add Product",
      icon: Icons.post_add,
      color: Colors.black54,
      snackMessage: "Kamu telah menekan tombol Add Product",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Alpha Shoes',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Selamat datang di Alpha Shoes',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              children: items.map((e) => ItemCard(e)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;
  final String snackMessage;

  const ItemHomepage({
    required this.name,
    required this.icon,
    required this.color,
    required this.snackMessage,
  });
}
