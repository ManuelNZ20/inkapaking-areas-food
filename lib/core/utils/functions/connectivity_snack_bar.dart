import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

showConnectivitySnackBar(context, ConnectivityResult connectivityResult) {
  final message = connectivityResult == ConnectivityResult.none
      ? "Sin conexión a internet"
      : "Conectado a internet";
  final backgroundColor = connectivityResult == ConnectivityResult.none
      ? Colors.red[400]
      : Colors.green[400];

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ),
  );
}
