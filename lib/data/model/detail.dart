class DetailResult {
  DetailResult({
    required this.error,
    required this.detail,
    required this.message,
  });

  bool error;
  Detail detail;
  String message;

  factory DetailResult.fromJson(Map<String, dynamic> json) => DetailResult(
        error: json["error"],
        message: json["message"],
        detail: Detail.fromJson(json["restaurant"]),
      );
}

class Detail {
  Detail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Item> categories;
  Menus menus;
  double rating;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Item>.from(
            json["categories"].map((x) => Item.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
      );
}

class Item {
  Item({
    required this.name,
  });

  String name;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
      );
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  List<Item> foods;
  List<Item> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
    foods:
    List<Item>.from(json["foods"].map((x) => Item.fromJson(x))),
    drinks: List<Item>.from(
        json["drinks"].map((x) => Item.fromJson(x))),
  );
}