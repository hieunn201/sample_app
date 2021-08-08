import '../services/services.dart';
import '../models/models.dart';
import 'interfaces/interfaces.dart';

class ProductBusiness extends IProductBusiness {
  final IProductService _service;

  ProductBusiness(this._service);

  @override
  Future<ProductModel> fetchProduct() async {
    return await _service.fetchProduct();
  }
}