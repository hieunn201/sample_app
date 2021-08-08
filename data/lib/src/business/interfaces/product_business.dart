import '../../models/models.dart';

abstract class IProductBusiness {
  Future<ProductModel> fetchProduct();
}