import 'dart:io';

import 'package:pdf/widgets.dart';

abstract class SaveAndOpenDocumentService {
  Future<File> savePdf({
    required String fileName,
    required Document pdf,
  });

  Future<void> openPdf({
    required File file,
  });
}
