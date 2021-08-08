import '../../models/models.dart';

abstract class IProductService {
  Future<ProductModel> fetchProduct();
}