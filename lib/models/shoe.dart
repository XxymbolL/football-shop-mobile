import 'dart:convert';

List<Shoe> shoeListFromJson(String str) =>
    List<Shoe>.from(json.decode(str).map((x) => Shoe.fromJson(x)));

String shoeListToJson(List<Shoe> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Shoe {
  Shoe({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.totalStock,
    required this.sizes,
    required this.userId,
    required this.username,
    required this.isOwner,
  });

  String id;
  String name;
  int price;
  String description;
  String thumbnail;
  int totalStock;
  List<ShoeSize> sizes;
  int? userId;
  String? username;
  bool isOwner;

  factory Shoe.fromJson(Map<String, dynamic> json) => Shoe(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"] ?? "",
        thumbnail: json["thumbnail"] ?? "",
        totalStock: json["total_stock"] ?? 0,
        sizes: (json["sizes"] as List<dynamic>? ?? [])
            .map((e) => ShoeSize.fromJson(e))
            .toList(),
        userId: json["user_id"],
        username: json["username"],
        isOwner: json["is_owner"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "total_stock": totalStock,
        "sizes": sizes.map((x) => x.toJson()).toList(),
        "user_id": userId,
        "username": username,
        "is_owner": isOwner,
      };
}

class ShoeSize {
  ShoeSize({
    required this.size,
    required this.stock,
  });

  String size;
  int stock;

  factory ShoeSize.fromJson(Map<String, dynamic> json) => ShoeSize(
        size: json["size"],
        stock: json["stock"],
      );

  Map<String, dynamic> toJson() => {
        "size": size,
        "stock": stock,
      };
}
