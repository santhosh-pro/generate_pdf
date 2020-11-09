import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Printing Demo'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.print),
          tooltip: 'Print Document',
          onPressed: () {
            Printing.layoutPdf(
              onLayout: (PdfPageFormat format) {
                return buildPdf(format);
              },
            );
          },
        ),
        body: Center(
          child: Text('Generate Pdf'),
        ),
      ),
    );
  }

  Future<Uint8List> buildPdf(PdfPageFormat format) async{
    final pw.Document doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: format,
        build: (pw.Context context) {
          return pw.ConstrainedBox(
            constraints: pw.BoxConstraints.expand(),
            child: pw.FittedBox(
              child: pw.Text('Hello World'),
            ),
          );
        },
      ),
    );
    return doc.save();
  }
}