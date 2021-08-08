import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../app_localizations/localizations.dart';
import '../resources/resources.dart';

class Routes {
  static String get productDetail => '/productDetail';

  static getRoute(RouteSettings settings) {
    Widget widget;
    try {
      widget = GetIt.I.get<Widget>(instanceName: settings.name);
    } catch (e) {
      widget = Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
                child: Text(
                  '${AppLocalizations.of(context).text(ErrorMessage.page_not_found)}',
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      );
    }
    return MaterialPageRoute(builder: (_) => widget, settings: settings);
  }
}
