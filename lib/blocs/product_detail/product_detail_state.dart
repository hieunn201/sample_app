import 'package:equatable/equatable.dart';
import 'package:data/data.dart';

class ProductDetailState extends Equatable {
  final ProductModel productModel;
  final int quantity;
  final int totalPrice;

  ProductDetailState({
    ProductDetailState state,
    ProductModel productModel,
    int quantity,
    int totalPrice,
  })  : productModel = productModel ?? state?.productModel,
        quantity = quantity ?? state?.quantity,
        totalPrice = totalPrice ?? state?.totalPrice;

  @override
  List<Object> get props => [
        productModel,
        quantity,
        totalPrice,
      ];
}
