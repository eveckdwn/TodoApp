import 'package:fast_app_base/common/data/preference/item/nullable_preference_item.dart';
import 'package:fast_app_base/common/theme/custom_theme.dart';
import 'item/preference_item.dart';

class Prefs {
  static final appTheme = NullablePreferenceItem<CustomTheme>('appTheme');
  static final launchCount = PreferenceItem<int>('launchCount', 0);
  static final count = NullablePreferenceItem<int>('count');
}

/*
main() async {
  final result = Prefs.launchCount.set(200);
  final launchCount = Prefs.launchCount.get();
  final success = await Prefs.launchCount.delete();
}
*/
