import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core.dart';

class SupabaseService {
  static late final SupabaseClient _client;
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: Environment.urlBase,
      anonKey: Environment.anonKey,
    );
    _client = Supabase.instance.client;
  }

  static SupabaseClient get client => _client;
}
