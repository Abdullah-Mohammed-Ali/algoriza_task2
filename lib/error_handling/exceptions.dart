class AppException implements Exception {}

class DataSourceException extends AppException {
  final String msg;

  DataSourceException(this.msg);
}
