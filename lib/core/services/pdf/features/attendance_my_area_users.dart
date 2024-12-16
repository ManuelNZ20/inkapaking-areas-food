import 'dart:io';

import 'package:inkapaking/core/core.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../features/all_areas/domain/domain.dart';

class AttendanceMyAreaUsers {
  final pdf = pw.Document();
  final formattedDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(
    DateTime.now().toUtc().toLocal(),
  );
  final formattedDatePdf = DateFormat('dd-MM-yyyy_HH-mm-ss').format(
    DateTime.now().toUtc().toLocal(),
  );
  final headers = [
    'ID',
    'Nombre Completo',
    'Desayuno',
    'Almuerzo',
    'Cena',
  ];
  Future<File> generatePdf({
    required List<User> users,
    required String nameArea,
  }) async {
    final data = users
        .asMap()
        .entries
        .map(
          (e) => [
            '${e.value.userId}',
            '${e.value.name} ${e.value.lastName}',
            '',
            '',
            '',
          ],
        )
        .toList();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Título del reporte
              pw.Container(
                color: PdfColors.black,
                padding: const pw.EdgeInsets.all(8),
                child: pw.Center(
                  child: pw.Text(
                    'Relación de personal $nameArea',
                    style: const pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              pw.SizedBox(height: 10),
              // Fecha
              pw.Text(
                formattedDate,
                style: const pw.TextStyle(fontSize: 12),
              ),
              pw.SizedBox(height: 10),

              // Tabla de datos
              pw.TableHelper.fromTextArray(
                border: pw.TableBorder.all(
                  color: PdfColors.black,
                ),
                cellStyle: const pw.TextStyle(
                  fontSize: 10,
                ),
                headerStyle: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                ),
                headerDecoration: const pw.BoxDecoration(
                  color: PdfColors.black,
                ),
                headerAlignment: pw.Alignment.center,
                headers: headers,
                data: data,
              ),
            ],
          );
        },
      ),
    );

    return SaveAndOpenDocument().savePdf(
      fileName: 'attendance_${nameArea}_$formattedDatePdf.pdf',
      pdf: pdf,
    );
  }
}
