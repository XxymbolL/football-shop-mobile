import 'package:flutter/material.dart';
import 'package:football_shop_mobile/config.dart';
import 'package:football_shop_mobile/models/shoe.dart';
import 'package:football_shop_mobile/screens/shoe_detail.dart';
import 'package:football_shop_mobile/widgets/left_drawer.dart';
import 'package:football_shop_mobile/widgets/shoe_card.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ShoeListPage extends StatefulWidget {
  final bool onlyMine;

  const ShoeListPage({super.key, this.onlyMine = true});

  @override
  State<ShoeListPage> createState() => _ShoeListPageState();
}

class _ShoeListPageState extends State<ShoeListPage> {
  Future<List<Shoe>> fetchShoes(CookieRequest request) async {
    // TODO: update base URL to your deployed Alpha Shoes URL (or 10.0.2.2/localhost)
    final filter = widget.onlyMine ? "my" : "all";
    final response = await request.get('$baseUrl/api/shoes/?filter=$filter');
    var data = response;
    List<Shoe> shoes = [];
    for (var d in data) {
      if (d != null) {
        shoes.add(Shoe.fromJson(d));
      }
    }
    return shoes;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.onlyMine ? 'My Products' : 'All Products'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchShoes(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada produk untuk akun ini.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) => ShoeCard(
              shoe: snapshot.data![index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoeDetailPage(shoe: snapshot.data![index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
