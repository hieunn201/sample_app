import '../../enums.dart';
import '../../theme/theme.dart';
import '../bloc.dart';
import 'app_state.dart';

/// Using this for change light/dark theme, language, font family,..
class AppBloc extends BaseBloc<AppState> {
  void init() {
    emit(AppState(
      state: state,
      locale: LocaleBuilder.getLocale(Language.en.value),
      appTheme: AppTheme.light.value,
    ));
  }
}
