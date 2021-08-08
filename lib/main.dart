import 'package:flutter/cupertino.dart';
import 'app.dart';
import 'dependencies/app_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDependencies.init();
  runApp(App());
}