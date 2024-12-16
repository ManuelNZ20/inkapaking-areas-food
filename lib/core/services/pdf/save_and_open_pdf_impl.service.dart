import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'save_and_open_document.service.dart';

class SaveAndOpenDocument implements SaveAndOpenDocumentService {
  @override
  Future<File> savePdf({
    required String fileName,
    required Document pdf,
  }) async {
    final root = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    final file = File('${root!.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    debugPrint('File saved at ${file.path}'); // Impresión de depuración
    return file;
  }

  @override
  Future<void> openPdf({
    required File file,
  }) async {
    final path = file.path;
    debugPrint('Opening file at $path');
    try {
      final result = await OpenFile.open(path);
      debugPrint('Result: $result');
    } catch (e) {
      debugPrint('Error opening file: $e');
    }
  }
}
