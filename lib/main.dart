import 'dart:io';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
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
          onPressed: () async {
            // List<ReportModel> items=List<ReportModel>();
            // ReportModel l1=ReportModel();
            // l1.year=2020;
            // l1.name="San";

            //  ReportModel l2=ReportModel();
            // l2.year=2021;
            // l2.name="Sat";
            // items.add(l1);
            // items.add(l2);
            //   List<List<dynamic>> mylist = [
            //                 <String>[
            //                   'Year',
            //                   'Name',

            //                 ],
            //                 ...items.map((item) => [
            //                       item.year,
            //                       item.name,
            //                     ]),
            //               ];

            //               String csv =
            //                   const ListToCsvConverter().convert(mylist);
            //               print('csv=$csv');

            //               final String dir =
            //                   (await getApplicationDocumentsDirectory()).path;
            //               final String path =
            //                   '/storage/emulated/0/Download/location_record.csv';
            //               print(path);

            //               final File file = File(path);
            //               var status = await Permission.storage.status;
            //               if (status.isUndetermined) {
            //                 await Permission.storage.request();
            //               }

            //               if (status.isGranted)
            //                 file.writeAsString(csv).then((value) {
            //                   print('write file result $value');
            //                 }).catchError((error) {
            //                   print('write file error $error');
            //                 });

            // final stream = new Stream.fromIterable([
            //   ['a', 'b'],
            //   [1, 2]
            // ]);
            // final csvRowStream = stream.transform(new ListToCsvConverter());
            // File f = new File("filename.csv");
            // f.writeAsString(csvRowStream.toString());
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

  Future<Uint8List> buildPdf(PdfPageFormat format) async {
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

    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '/storage/emulated/0/Download/location_record.csv';

    final File file = File(path);
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      await Permission.storage.request();
    }

    if (status.isGranted)
      file.writeAsBytes(doc.save()).then((value) {
        print('write file result $value');
      }).catchError((error) {
        print('write file error $error');
      });
  }
}

class ReportModel {
  double year;
  String name;
}
