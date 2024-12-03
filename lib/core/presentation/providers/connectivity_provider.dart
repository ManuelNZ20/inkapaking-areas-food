import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final connectivityProvider = StreamProvider<ConnectivityResult>(
  (ref) async* {
    final connectivity = Connectivity();
    await for (final result in connectivity.onConnectivityChanged) {
      yield result.single;
    }
  },
);
