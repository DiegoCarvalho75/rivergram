import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/post_settings.dart';

class PostSettingsNotifier extends StateNotifier<Map<PostSetting, bool>> {
  PostSettingsNotifier()
      : super({
          for (final setting in PostSetting.values) setting: true,
        });

  void setSetting(
    PostSetting setting,
    bool value,
  ) {
    final existingValue = state[setting];
    if (existingValue == null || existingValue == value) {
      return;
    }
    state = state..[setting] = value;
  }
}
