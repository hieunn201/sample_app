import 'package:get_it/get_it.dart';
import 'dependencies.dart';
import '../utility/utility.dart';
import '../enums.dart';

class AppDependencies {
  static GetIt get injector => GetIt.I;

  static Future<void> init() async {
    Log.init();
    await loadConfig();
    await ServiceDependencies.setup(injector);
    await BusinessDependencies.setup(injector);
    await BlocDependencies.setup(injector);
    await PageDependencies.setup(injector);
  }

  static Future<void> loadConfig({Environment env = Environment.dev}) async {
    var appEnv = env.value;
    try {
      await AppConfig().loadAsset('app_config_$appEnv.json');
    } catch (e) {
      Log.e(e.toString());
    }
  }
}
