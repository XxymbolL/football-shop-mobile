import 'package:flutter/material.dart';
import 'package:football_shop_mobile/models/shoe.dart';

class ShoeDetailPage extends StatelessWidget {
  final Shoe shoe;

  const ShoeDetailPage({super.key, required this.shoe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (shoe.thumbnail.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  shoe.thumbnail,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 220,
                    color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Text(
              shoe.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text('Harga: Rp${shoe.price}'),
            const SizedBox(height: 6),
            Text('Stok total: ${shoe.totalStock}'),
            const SizedBox(height: 6),
            Text('Pemilik: ${shoe.username ?? "-"}'),
            const SizedBox(height: 12),
            const Text(
              'Deskripsi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(shoe.description.isEmpty ? '-' : shoe.description),
            const SizedBox(height: 12),
            const Text(
              'Ukuran & Stok',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: shoe.sizes.map((s) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text('EU ${s.size}: ${s.stock} pasang'),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Kembali'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
