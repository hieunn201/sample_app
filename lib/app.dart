import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localizations/app_localizations.dart';
import 'enums.dart';
import 'blocs/bloc.dart';
import 'router/router.dart';
import 'theme/theme.dart';

final navigationKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final appBloc = AppBloc();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    appBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(create: appBloc..init()),
      ],
      child: Consumer<AppBloc>(
        builder: (_, bloc) => StreamBuilder<AppState>(
          stream: bloc.stateStream,
          builder: (context, snapshot) => _buildApp(snapshot?.data),
        ),
      ),
    );
  }

  Widget _buildApp(AppState state) {
    return MaterialApp(
      navigatorKey: navigationKey,
      title: 'Sample App',
      debugShowCheckedModeBanner: false,
      theme: ThemeBuilder.build(context, AppTheme.light.value, fontFamily: state?.fontFamily),
      darkTheme: ThemeBuilder.build(context, AppTheme.dark.value, fontFamily: state?.fontFamily),
      themeMode: ThemeBuilder.themeMode(state?.appTheme),
      initialRoute: Routes.productDetail,
      onGenerateRoute: (settings) => Routes.getRoute(settings),
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: state?.locale,
      localeResolutionCallback: AppLocalizations.delegate.resolution(
        fallback: AppLocalizations.delegate.supportedLocales.first,
      ),
    );
  }

}
