// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';



class Products {
    int id;
    String title;
    String description;
    int price;
    double discountPercentage;
    double rating;
    int stock;
    String brand;
    String category;
    String thumbnail;

    Products({
        required this.id,
        required this.title,
        required this.description,
        required this.price,
        required this.discountPercentage,
        required this.rating,
        required this.stock,
        required this.brand,
        required this.category,
        required this.thumbnail,
      
    });

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        discountPercentage: json["discountPercentage"]?.toDouble(),
        rating: json["rating"]?.toDouble(),
        stock: json["stock"],
        brand: json["brand"],
        category: json["category"],
        thumbnail: json["thumbnail"],
       
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "stock": stock,
        "brand": brand,
        "category": category,
        "thumbnail": thumbnail,
    };
}
