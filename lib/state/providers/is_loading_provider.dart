import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rivergram/state/image_upload/providers/image_uploader_provider.dart';

import '../auth/providers/auth_state_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploading = ref.watch(imageUploaderProvider);

  return (authState.isLoading || isUploading);
});
