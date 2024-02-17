import 'dart:developer';

import 'package:badges/badges.dart' as b;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/model/products_model.dart';
import 'package:shopping_cart_app/provider/cart_provider.dart';
import 'package:shopping_cart_app/database/db_helper.dart';
import 'package:shopping_cart_app/model/cart_model.dart';
import 'package:shopping_cart_app/screens/cart_screen.dart';
import 'package:shopping_cart_app/service.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    void saveData(Products p) {
      dbHelper
          .insert(
        Cart(
          id: p.id,
          productId: p.id.toString(),
          productName:p.title,
          productPrice: p.price,
          quantity: ValueNotifier(1),
          image: p.thumbnail,
          rating: p.rating.toString(),
          discountPercentage: p.discountPercentage.toString(),
        ),
      )
          .then((value) {
        cart.addTotalPrice(p.price.toDouble());
        cart.addCounter();
        log('Product Added to cart');
      }).onError((error, stackTrace) {
        log(error.toString());
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar
      (
        SnackBar(content: Text('${p.title} successfully added to the cart'))
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product List'),
        actions: [
          b.Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  value.getCounter().toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            position:  b.BadgePosition.topEnd(),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: FutureBuilder(
        future: ProductService.getProducts(),
        builder: (context,AsyncSnapshot s){
          if(s.hasData){
          return  ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            shrinkWrap: true,
            itemCount:s.data!.length,
            itemBuilder: (context, i) {
              Products p=s.data![i];
              return Card(
                color: Colors.blueGrey.shade200,
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                     Image.network(p.thumbnail,height: 100,width: 100,),
                      SizedBox(
                        width: 170,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5.0,
                            ),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              text: TextSpan(
                                  text: 'Name: ',
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade800,
                                      fontSize: 16.0),
                                  children: [
                                    TextSpan(
                                        text:
                                            '${p.title.toString()}\n',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ]),
                            ),
                            RichText(
                              maxLines: 1,
                              text: TextSpan(
                                  text: 'Description: ',
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade800,
                                      fontSize: 16.0),
                                  children: [
                                    TextSpan(
                                        text:
                                            '${p.description.toString()}\n',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ]),
                            ),
                            RichText(
                              maxLines: 1,
                              text: TextSpan(
                                  text: 'Price: ' r"$",
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade800,
                                      fontSize: 16.0),
                                  children: [
                                    TextSpan(
                                        text:
                                            '${p.price.toString()}\n',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ]),
                            ),

                             ElevatedButton(
                          onPressed: () {
                            saveData(p);
                          },
                          child: const Text('Add to Cart')),
                          ],
                        ),
                      ),
                      Text(
                            '${p.rating.toString()}*\n',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold)),
                     
                    ],
                  ),
                ),
              );
            });
          }
             if(s.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
             }
             else{
              return const Center(child: Text('Error while loading...'));
             }
          }
        
      ),
    );
  }
}
