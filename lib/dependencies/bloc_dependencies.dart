import 'package:get_it/get_it.dart';

import '../blocs/bloc.dart';

class BlocDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<ProductDetailBloc>(() => ProductDetailBloc(injector()));
  }
}
