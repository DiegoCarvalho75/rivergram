import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rivergram/state/comments/providers/delete_comment_provider.dart';
import 'package:rivergram/state/user_info/providers/user_info_model_provider.dart';
import 'package:rivergram/views/components/dialogs/alert_dialog_model.dart';

import '../../../state/auth/providers/user_id_provider.dart';
import '../../../state/comments/model/comment.dart';
import '../animations/small_error_animation_view.dart';
import '../constants/components_strings.dart';
import '../dialogs/delete_dialog.dart';

class CommentTile extends ConsumerWidget {
  const CommentTile({
    super.key,
    required this.comment,
  });

  final Comment comment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      userInfoModelProvider(comment.userId),
    );
    return userInfo.when(data: (
      userInfo,
    ) {
      final currentUserId = ref.read(userIdProvider);
      return ListTile(
        // is loged user == comment author?
        trailing: (currentUserId == comment.userId)
            ? IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  final shouldDelete = await displayDeleteDialog(context);
                  if (shouldDelete) {
                    await ref
                        .read(deleteCommentProvider.notifier)
                        .deleteComment(commentId: comment.id);
                  }
                },
              )
            : null,
        title: Text(
          userInfo.displayName,
          style: const TextStyle(),
        ),
        subtitle: Text(
          comment.comment,
          style: const TextStyle(),
        ),
      );
    }, error: (e, st) {
      return const SmallErrorAnimationView();
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  Future<bool> displayDeleteDialog(BuildContext context) {
    return const DeleteDialog(
      titleOfObjectToDelete: ComponentsStrings.comment,
    ).present(context).then(
          (value) => value ?? false,
        );
  }
}
