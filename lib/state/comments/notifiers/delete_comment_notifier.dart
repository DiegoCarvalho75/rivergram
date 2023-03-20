import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rivergram/state/constants/firebase_collection_names.dart';
import 'package:rivergram/state/image_upload/typedefs/is_loading.dart';

class DeleteCommentStateNotifier extends StateNotifier<IsLoading> {
  DeleteCommentStateNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> deleteComment({
    required commentId,
  }) async {
    try {
      isLoading = true;
      final query = FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.comments)
          .where(
            FieldPath.documentId,
            isEqualTo: commentId,
          )
          .limit(1)
          .get();

      await query.then((query) async {
        for (var doc in query.docs) {
          await doc.reference.delete();
        }
      });
      return true;
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
    return false;
  }
}
