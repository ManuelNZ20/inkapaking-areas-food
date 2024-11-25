class ServerException implements Exception {
  final String message;
  ServerException([this.message = "Internal server error."]);
}

class SupabaseException implements Exception {
  final String message;
  SupabaseException([this.message = "An error occurred with Supabase."]);
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = "An error occurred with the cache."]);
}
