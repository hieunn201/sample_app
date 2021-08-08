import 'package:flutter/services.dart';
import 'dart:convert';
import '../../models/models.dart';
import '../interfaces/interfaces.dart';

class MockProductService extends IProductService {

  @override
  Future<ProductModel> fetchProduct() async {
    final jsonStr = await rootBundle.loadString('assets/data/products.json');
    final data = json.decode(jsonStr);
    final product = ProductModel.fromJson(data);
    final extras = product.extras ?? [];
    extras.forEach((element) {
      element.items ??= [];
      element.items.addAll(product.extraItems.where((item) => item.extraId == element.id));
    });
    return product.copyWith(extras: extras);
  }
}