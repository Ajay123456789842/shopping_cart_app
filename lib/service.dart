

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shopping_cart_app/model/products_model.dart';
 


class ProductService{
 static Future<List<Products>> getProducts() async{
  final dio = Dio();
    final List<Products> l=[];
    final response=await dio.get('https://dummyjson.com/products');
   List li=response.data['products'];
   for(int i=0;i<li.length;i++){
    l.add(Products.fromJson(li[i]));
   }
   return l;
}
}