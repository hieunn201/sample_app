import 'package:flutter/services.dart';
import 'dart:convert';

class AppConfig {
  Map<String, dynamic> _config = Map<String, dynamic>();

  static AppConfig _instance = AppConfig._internal();

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal();

  AppConfig loadMap(Map<String, dynamic> map) {
    _config.addAll(map);
    return _instance;
  }

  Future<AppConfig> loadAsset(String name) async {
    if (!name.endsWith(".json")) {
      name = "$name.json";
    }
    String content = await rootBundle.loadString("assets/cfg/$name");
    Map<String, dynamic> configAsMap = json.decode(content);
    _config.addAll(configAsMap);
    return _instance;
  }

  Future<AppConfig> loadFromPath(String path) async {
    String content = await rootBundle.loadString(path);
    Map<String, dynamic> configAsMap = json.decode(content);
    _config.addAll(configAsMap);
    return _instance;
  }

  dynamic get(String key) => _config[key];

  T getValue<T>(String key) => _config[key] as T;

  void clear() => _config.clear();
}