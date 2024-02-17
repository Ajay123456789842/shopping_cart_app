


import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart_app/model/products_model.dart';
 


class ProductService{
 static Future<List<Products>> getProducts() async{
  final dio = Dio();
    final List<Products> l=[];
    final response=await dio.get('https://dummyjson.com/products');
if(response.statusCode==200){
    List li=response.data['products'];
    for(int i=0;i<li.length;i++){
    l.add(Products.fromJson(li[i]));
    }
    return l;
}
else{
  debugPrintStack(stackTrace: StackTrace.current,label: 'Error');
  log('Cant able to process the request');
  return l;
}
  }
}