abstract class NetworkInfo {
  Future<bool> get isConnected;

  /// Verifica si la conexión a Supabase es válida
  Future<bool> get isSupabaseConnected;
}
