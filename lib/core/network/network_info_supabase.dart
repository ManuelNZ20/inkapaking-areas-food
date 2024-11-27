import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;

  /// Verifica si la conexión a Supabase es válida
  Future<bool> get isSupabaseConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImpl(this.internetConnectionChecker);

  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;

  @override
  Future<bool> get isSupabaseConnected =>
      internetConnectionChecker.hasConnection;
}
