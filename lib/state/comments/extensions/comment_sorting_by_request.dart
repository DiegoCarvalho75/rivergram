import '../../../enums/date_sorting.dart';
import '../model/comment.dart';
import '../model/post_comments_request.dart';

extension Sorting on Iterable<Comment> {
  Iterable<Comment> apllySortingFrom(PostCommentsRequest request) {
    if (request.sortByCreatedAt) {
      final sortedDocs = toList()
        ..sort(
          (a, b) {
            switch (request.dateSorting) {
              case DateSorting.newstOnTop:
                return b.createdAt.compareTo(a.createdAt);
                break;
              case DateSorting.oldesttOnTop:
                return a.createdAt.compareTo(b.createdAt);
                break;
            }
          },
        );
      return sortedDocs;
    } else {
      return this;
    }
  }
}
