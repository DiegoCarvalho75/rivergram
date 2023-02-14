enum LottieAnimation {
  dataNotFound(fileName: 'data_not_found'),
  empty(fileName: 'empty'),
  loading(fileName: 'loading'),
  error(fileName: 'error'),
  smallError(fileName: 'small_error');

  final String fileName;

  const LottieAnimation({
    required this.fileName,
  });
}
