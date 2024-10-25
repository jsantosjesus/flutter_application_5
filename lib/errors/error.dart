abstract class Error implements Exception {}

class RepositoryError implements Error {
  final String message;

  RepositoryError({required this.message});
}
