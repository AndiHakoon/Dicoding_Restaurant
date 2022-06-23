import 'package:equatable/equatable.dart';

class DetailResult extends Equatable {
  const DetailResult({
    required this.error,
    required this.detail,
    required this.message,
  });

  final bool error;
  final Detail detail;
  final String message;

  factory DetailResult.fromJson(Map<String, dynamic> json) => DetailResult(
        error: json["error"],
        message: json["message"],
        detail: Detail.fromJson(json["restaurant"]),
      );

  @override
  List<Object?> get props => [error, detail, message];
}

class Detail extends Equatable {
  const Detail({
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

  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Item> categories;
  final Menus menus;
  final double rating;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories:
            List<Item>.from(json["categories"].map((x) => Item.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
      );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        city,
        address,
        pictureId,
        categories,
        menus,
        rating
      ];
}

class Item extends Equatable {
  const Item({
    required this.name,
  });

  final String name;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
      );

  @override
  List<Object?> get props => [name];
}

class Menus extends Equatable {
  const Menus({
    required this.foods,
    required this.drinks,
  });

  final List<Item> foods;
  final List<Item> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Item>.from(json["foods"].map((x) => Item.fromJson(x))),
        drinks: List<Item>.from(json["drinks"].map((x) => Item.fromJson(x))),
      );

  @override
  List<Object?> get props => [foods, drinks];
}
