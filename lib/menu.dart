import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String nama  = "Rifqy Pradipta Kurniawan";
  final String npm   = "2406422922";
  final String kelas = "B";


  final List<ItemHomepage> items = [
    ItemHomepage(
      name: "All Products",
      icon: Icons.store_mall_directory,
      color: Colors.blue,
      snackMessage: "Kamu telah menekan tombol All Products",
    ),
    ItemHomepage(
      name: "My Products",
      icon: Icons.inventory_2,
      color: Colors.green,
      snackMessage: "Kamu telah menekan tombol My Products",
    ),
    ItemHomepage(
      name: "Create Product",
      icon: Icons.add_circle_outline,
      color: Colors.red,
      snackMessage: "Kamu telah menekan tombol Create Product",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Alpha Shoes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoChip(label: 'NPM', value: npm),
                InfoChip(label: 'Name', value: nama),
                InfoChip(label: 'Class', value: kelas),
              ],
            ),
            const SizedBox(height: 24),

            const Text(
              'Selamat datang di Alpha Shoes',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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

class InfoChip extends StatelessWidget {
  final String label;
  final String value;

  const InfoChip({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value),
        ],
      ),
      elevation: 2,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
    );
  }
}
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;
  final String snackMessage;

  ItemHomepage({
    required this.name,
    required this.icon,
    required this.color,
    required this.snackMessage,
  });
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(item.snackMessage)));
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30),
                const SizedBox(height: 6),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
