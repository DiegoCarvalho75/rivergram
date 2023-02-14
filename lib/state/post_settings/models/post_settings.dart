import '../constants/post_settings_strings.dart';

enum PostSetting {
  allowLikes(
    title: PostSettingsStrings.allowLikesTitle,
    description: PostSettingsStrings.allowLikesDescription,
    storageKey: PostSettingsStrings.allowLikesStorageKey,
  ),
  allowComments(
    title: PostSettingsStrings.allowCommentsTitle,
    description: PostSettingsStrings.allowCommentsDescription,
    storageKey: PostSettingsStrings.allowCommentsStorageKey,
  );

  final String title;
  final String description;
  final String storageKey;

  const PostSetting({
    required this.title,
    required this.description,
    required this.storageKey,
  });
}
