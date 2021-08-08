import 'package:data/data.dart';
import '../../constants.dart';
import '../bloc.dart';
import '../../extensions/extension.dart';

class ProductDetailBloc extends BaseBloc<ProductDetailState> {
  final IProductBusiness _business;
  ProductDetailBloc(this._business);
  Map<int, List<ExtraItem>> _selectedTopping = {};
  Map<int, Extra> _extraMap = {};
  Map<int, bool> _validExtraMap = {};

  Future<void> onAppearing() async {
    // response if using api/ return directly item from mock service
    final product = await _business.fetchProduct();
    final quantity = ProductConstants.defaultQuantity;
    final totalPrice = quantity * product.price;
    product.extras.forEach((element) {
      _selectedTopping.putIfAbsent(element.id, () => []);
      _extraMap.putIfAbsent(element.id, () => element);
      _validExtraMap.putIfAbsent(element.id, () => element.min == 0);
    });
    emit(ProductDetailState(
      state: state,
      productModel: product,
      quantity: quantity,
      totalPrice: totalPrice,
    ));
  }

  Future<void> addToCart() async {
    final isValid = !_validExtraMap.values.any((isValid) => !isValid);
    _validExtraMap.values.forEach((element) => print(element));
    emitListener(isValid);
  }

  Future<void> onQuantityChanged(int quantity) async {
    emit(ProductDetailState(
      state: state,
      quantity: quantity,
    ));
    _calculationPrice();
  }

  Future<void> onToppingChanged(Extra model, List<ExtraItem> items) async {
    _validExtraMap[model.id] = items.length >= model.min;
    _selectedTopping[model.id] = items;
    _calculationPrice();
  }

  void _calculationPrice() {
    final extraItems = _selectedTopping.values?.foldLeft(<ExtraItem>[], (List<ExtraItem> list, List<ExtraItem> items) => [...list, ...items]) as List<ExtraItem>;
    final toppingPrice = extraItems?.foldLeft(0, (sum, item) => sum + item.price) ?? 0.0;
    final totalPrice = state.productModel.price * state.quantity + toppingPrice * state.quantity;
    emit(ProductDetailState(state: state, totalPrice: totalPrice));
  }
}
