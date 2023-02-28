import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rivergram/state/post_settings/providers/post_settings_provider.dart';
import 'package:rivergram/views/create_new_post/create_new_post_view.dart';

import '../../state/image_upload/models/file_type.dart';
import '/state/image_upload/helpers/image_picker_helper.dart';
import '../../state/auth/providers/auth_state_provider.dart';
import '../components/dialogs/alert_dialog_model.dart';
import '../components/dialogs/logout_dialog.dart';
import '../constants/views_strings.dart';
import '../tabs/user_posts/user_posts_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(ViewsStrings.appName),
          actions: [
            IconButton(
              onPressed: () async {
                final videoFile =
                    await ImagePickerHelper.pickVideoFromGallery();
                if (videoFile == null) {
                  return;
                }
                ref.refresh(postSettingsProvider);
                if (!mounted) {
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CreateNewPostView(
                        fileToPost: videoFile,
                        fileType: FileType.video,
                      );
                    },
                  ),
                );
              },
              icon: const FaIcon(FontAwesomeIcons.film),
            ),
            IconButton(
              onPressed: () async {
                final imageFile =
                    await ImagePickerHelper.pickImageFromGallery();
                if (imageFile == null) {
                  return;
                }

                ref.refresh(postSettingsProvider);
                if (!mounted) {
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CreateNewPostView(
                        fileToPost: imageFile,
                        fileType: FileType.image,
                      );
                    },
                  ),
                );
              },
              icon: const Icon(Icons.add_photo_alternate_outlined),
            ),
            IconButton(
              onPressed: () async {
                final shouldLogOut = await const LogoutDialog()
                    .present(context)
                    .then((value) => value ?? false);
                if (shouldLogOut) {
                  ref.read(authStateProvider.notifier).logout();
                }
              },
              icon: const Icon(Icons.logout),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.search)),
              Tab(icon: Icon(Icons.home)),
            ],
          ),
        ),
        body: const TabBarView(children: [
          UserPostView(),
          UserPostView(),
          UserPostView(),
        ]),
      ),
    );
  }
}
