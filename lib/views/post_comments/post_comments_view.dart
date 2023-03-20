import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rivergram/views/components/animations/loading_animation_view.dart';
import 'package:rivergram/views/components/animations/small_error_animation_view.dart';

import '../../state/auth/providers/user_id_provider.dart';
import '../../state/comments/model/post_comments_request.dart';
import '../../state/comments/providers/post_comments_provider.dart';
import '../../state/comments/providers/send_comment_provider.dart';
import '../../state/posts/typedefs/post_id.dart';
import '../../views/extensions/dismiss_keyboard.dart';
import '../components/comment/comment_tile.dart';
import '../constants/views_strings.dart';

class PostCommentsView extends StatefulHookConsumerWidget {
  const PostCommentsView({
    super.key,
    required this.postId,
  });

  final PostId postId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostCommentsViewState();
}

class _PostCommentsViewState extends ConsumerState<PostCommentsView> {
  @override
  Widget build(BuildContext context) {
    final commentController = useTextEditingController();
    final hasText = useState(false);
    final request = useState(
      PostCommentsRequest(
        postId: widget.postId,
      ),
    );

    final comments = ref.watch(
      postCommentsProvider(
        request.value,
      ),
    );

    useEffect(
      () {
        commentController.addListener(() {
          hasText.value = commentController.text.isNotEmpty;
        });
        return () {};
      },
      [commentController],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(ViewsStrings.comments),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: hasText.value
                ? () {
                    _submitCommentWithController(
                      commentController,
                      ref,
                    );
                  }
                : null,
          ),
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
                child: comments.when(
                    data: (comments) {
                      if (comments.isEmpty) {
                        return const Center(
                          child: Text(
                            ViewsStrings.noCommentsYet,
                            style: TextStyle(),
                          ),
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: () {
                          ref.refresh(
                            postCommentsProvider(
                              request.value,
                            ),
                          );
                          return Future.delayed(
                            const Duration(seconds: 1),
                          );
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            return CommentTile(
                              comment: comments.elementAt(index),
                            );
                          },
                        ),
                      );
                    },
                    error: (e, st) => const SmallErrorAnimationView(),
                    loading: () => const LoadingAnimationView())),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    textInputAction: TextInputAction.send,
                    controller: commentController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ViewsStrings.pleaseWriteYourMessageHere,
                    ),
                    onSubmitted: (comment) {
                      if (comment.isNotEmpty) {
                        _submitCommentWithController(
                          commentController,
                          ref,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitCommentWithController(
    TextEditingController controller,
    WidgetRef ref,
  ) async {
    final userId = ref.watch(userIdProvider);
    if (userId == null) {
      return;
    }
    final isSent = await ref.read(sendCommentProvider.notifier).sendComment(
          userId: userId,
          postId: widget.postId,
          comment: controller.text,
        );
    if (isSent) {
      controller.clear();
      widget.dismissKeyboard();
    }
  }
}
