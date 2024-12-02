import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core.dart';

final keyValueStorageProvider = Provider<KeyValueStorageService>((ref) {
  return KeyValueStorageImpl();
});
