import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/post_settings.dart';
import '../notifiers/post_settings_notifier.dart';

final postSettingsProvider =
    StateNotifierProvider<PostSettingsNotifier, Map<PostSetting, bool>>((ref) {
  return PostSettingsNotifier();
});
