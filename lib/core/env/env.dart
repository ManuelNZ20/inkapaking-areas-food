import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static Future<void> initEnv() async {
    await dotenv.load(
      fileName: fileName,
    );
  }

  static String get fileName {
    if (kReleaseMode) return '.env.prod';
    return '.env.dev';
  }

  static String get urlBase =>
      dotenv.env['SUPABASE_URL'] ?? 'Not SUPABASE_URL especified';

  static String get anonKey =>
      dotenv.env['SUPABASE_ANON_KEY'] ?? 'Not SUPABASE_ANON_KEY especified';
}
