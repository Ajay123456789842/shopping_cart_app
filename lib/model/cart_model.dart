import 'package:flutter/material.dart';

class Cart {
  late final int? id;
  final String? productId;
  final String? productName;
  final int? productPrice;
  final ValueNotifier<int>? quantity;
  final String? image;
  final String? rating;
  final String? discountPercentage;

  Cart(
      {required this.id,
      required this.productId,
      required this.productName,
      required this.productPrice,
      required this.quantity,
      required this.image,
      required this.rating,
      required this.discountPercentage});

  Cart.fromMap(Map<dynamic, dynamic> data)
      : id = data['id'],
      productId=data['productId'],
        productName = data['productName'],
        productPrice = data['productPrice'],
        quantity = ValueNotifier(data['quantity']),
        image = data['image'],
        rating = data['rating'],
        discountPercentage=data['discountPercentage'];
        

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId':productId,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity?.value,
      'image': image,
      'rating':rating,
      'discountPercentage':discountPercentage,
    };
  }

  Map<String, dynamic> quantityMap() {
    return {
      'productId': productId,
      'quantity': quantity!.value,
    };
  }
}
