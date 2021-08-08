import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BlocProvider<T> extends InheritedWidget {
  final T create;

  final bool Function(T, T) _updateShouldNotify;

  const BlocProvider({
    Key key,
    Widget child,
    @required this.create,
    bool updateShouldNotify(T previous, T current),
  })  : assert(create != null),
        _updateShouldNotify = updateShouldNotify ?? _notEquals,
        super(key: key, child: child);

  static T of<T>(BuildContext context, {bool listen = true}) {
    final BlocProvider<T> provider = listen ? context.dependOnInheritedWidgetOfExactType<BlocProvider<T>>() : context.getElementForInheritedWidgetOfExactType<BlocProvider<T>>()?.widget;
    if (provider == null) {
      throw BlocProviderError(_typeOf<BlocProvider<T>>());
    }
    return provider.create;
  }

  @override
  bool updateShouldNotify(BlocProvider<T> old) => _updateShouldNotify(old.create, create);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('create', create));
  }

  static bool _notEquals(previous, current) => previous != current;

  static Type _typeOf<T>() => T;

  BlocProvider<T> copyWith(Widget child) => BlocProvider<T>(child: child, create: create, key: key, updateShouldNotify: _updateShouldNotify);
}

class BlocProviderError extends Error {
  final Type type;

  BlocProviderError(this.type);

  @override
  String toString() {
    return '''Error: No $type found.''';
  }
}

class MultiBlocProvider extends StatelessWidget {
  final List<BlocProvider<dynamic>> providers;

  final Widget child;

  const MultiBlocProvider({Key key, @required this.providers, @required this.child})
      : assert(providers != null),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => providers.reversed.fold(child, (Widget widget, BlocProvider<dynamic> provider) => provider.copyWith(widget));
}

class Consumer<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T t) builder;

  const Consumer({
    Key key,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => builder(context, BlocProvider.of<T>(context));
}