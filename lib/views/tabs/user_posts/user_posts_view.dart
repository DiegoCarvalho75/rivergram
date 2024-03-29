import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../components/animations/empty_contents_with_text_animation_view.dart';
import '../../components/animations/error_animation_view.dart';
import '../../components/animations/loading_animation_view.dart';
import '../../components/post/posts_grid_view.dart';
import '../../constants/views_strings.dart';

import '../../../state/posts/providers/user_posts_provider.dart';

class UserPostView extends ConsumerWidget {
  const UserPostView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostsProvider);
    return RefreshIndicator(
        onRefresh: () {
          // ignore: unused_result
          ref.refresh(userPostsProvider);
          return Future.delayed(
            const Duration(seconds: 1),
          );
        },
        child: posts.when(
          data: (posts) {
            if (posts.isEmpty) {
              return const EmptyContentsWithTextAnimationView(
                text: ViewsStrings.youHaveNoPosts,
              );
            }
            return PostsGridView(posts: posts);
          },
          error: (error, stackTrace) {
            return const ErrorAnimationView();
          },
          loading: () {
            return const LoadingAnimationView();
          },
        ));
  }
}
