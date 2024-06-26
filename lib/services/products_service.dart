import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/products.dart';
import 'package:http/http.dart' as http;
class ProductsService extends ChangeNotifier{

  final String _baseUrl = "flutter-app-productes-6e1ff-default-rtdb.europe-west1.firebasedatabase.app";
  final List<Product> products = [];
  late Product selectedProduct;

  bool isLoading = true;

  ProductsService(){
    this.loadProducts();
  }

  Future loadProducts() async{
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id=key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();
  }
}