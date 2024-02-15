import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:opak_mobil_v2/dekontKayit/model/dekontKayitModel.dart';
import 'package:opak_mobil_v2/widget/cari.dart';
import 'package:opak_mobil_v2/widget/ctanim.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../controllers/cariController.dart';
import '../../controllers/dekontController.dart';

final DekontController dekontEx = Get.find();
CariController cariEx = Get.find(); // PUT DEĞİŞTİ

Future<Uint8List> makePdf(DekontKayitModel m, Uint8List imagePath) async {
  final image = pw.MemoryImage(imagePath);
  final fontData = await rootBundle.load("images/fonts/Roboto-Regular.ttf");
  final ttfFont = pw.Font.ttf(fontData);

  final boldfontData = await rootBundle.load("images/fonts/Roboto-Bold.ttf");
  final boldttfFont = pw.Font.ttf(boldfontData);

  final pdf = pw.Document();
  // İlk sayfada üst bilgiler ve tablo başlıkları

  List<Widget> glen = [];
  int i = 0;
  while (i < m.dekontKayitList!.length) {
    glen.add(
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          i == 0
              ? Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: pw.Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: pw.Column(
                            children: [
                             
                               SizedBox(
                                height: 20,
                                child: Text(
                                  "Dekont:",
                                  style: pw.TextStyle(
                                      fontSize: 17,
                                      fontWeight: pw.FontWeight.bold,
                                      font: boldttfFont),
                                ),
                              ),
                               Padding(padding: EdgeInsets.only(bottom: 20)),
                              
                              SizedBox(
                                height: 20,
                                child: Text(
                                  "İşlem Tarihi:",
                                  style: pw.TextStyle(
                                      fontSize: 15,
                                      fontWeight: pw.FontWeight.bold,
                                      font: boldttfFont),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Text(
                                  "Belge No:",
                                  style: pw.TextStyle(
                                      fontSize: 15,
                                      fontWeight: pw.FontWeight.bold,
                                      font: boldttfFont),
                                ),
                              ),
                                SizedBox(
                                height: 20,
                                child: Text(
                                  "Seri No:",
                                  style: pw.TextStyle(
                                      fontSize: 15,
                                      fontWeight: pw.FontWeight.bold,
                                      font: boldttfFont),
                                ),
                              ),
                            ],
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                          ),
                        ),
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                                Padding(padding: EdgeInsets.only(bottom: 40)),
                              SizedBox(
                                height: 20,
                                child: Text(
                                  m.TARIH.toString(),
                                  style: pw.TextStyle(
                                      fontSize: 15,
                                      fontWeight: pw.FontWeight.bold,
                                      font: boldttfFont),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Text(
                                  m.BELGE_NO.toString(),
                                  style: pw.TextStyle(
                                      fontSize: 15,
                                      fontWeight: pw.FontWeight.bold,
                                      font: boldttfFont),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Text(
                                  m.SERI.toString(),
                                  style: pw.TextStyle(
                                      fontSize: 15,
                                      fontWeight: pw.FontWeight.bold,
                                      font: boldttfFont),
                                ),
                              ),
                            ]),
                        Spacer(),
                        pw.Image(image, width: 150, height: 100),
                        Container(height: 40),
                      ]))
              : Container(),
          i == 0
              ? pw.Table.fromTextArray(
                  headers: [
                    'Cari Adı',
                    'Alacak',
                    'Borç',
                    'D. Alacak',
                    'D. Borç',
                    'Kur',
                  ],
                  data: buildTableRows(m, start: i, end: i + 1),
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerRight,
                    2: pw.Alignment.centerRight,
                    3: pw.Alignment.centerRight,
                    4: pw.Alignment.centerRight,
                    5: pw.Alignment.centerRight,
                  },
                  cellStyle: pw.TextStyle(
                    font: ttfFont,
                    fontSize: 10,
                  ),
                  headerStyle: pw.TextStyle(
                    font: boldttfFont,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 10,
                  ),
                  border: pw.TableBorder.all(color: PdfColors.black),
                  headerDecoration: pw.BoxDecoration(
                    color: PdfColors.grey300,
                  ),
                  columnWidths: {
                    0: pw.FractionColumnWidth(0.4),
                    1: pw.FractionColumnWidth(0.1),
                    2: pw.FractionColumnWidth(0.1),
                    3: pw.FractionColumnWidth(0.1),
                    4: pw.FractionColumnWidth(0.1),
                    5: pw.FractionColumnWidth(0.1),
                  },
                  headerHeight: 40)

              : pw.Table.fromTextArray(
                 
                  headerStyle: TextStyle(fontSize: 10),
                  data: buildTableRows(m, start: i, end: i + 1),
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerRight,
                    2: pw.Alignment.centerRight,
                    3: pw.Alignment.centerRight,
                    4: pw.Alignment.centerRight,
                    5: pw.Alignment.centerRight,
                  },
                  border: pw.TableBorder.all(color: PdfColors.black),
                  columnWidths: {
                    0: pw.FractionColumnWidth(0.4),
                    1: pw.FractionColumnWidth(0.1),
                    2: pw.FractionColumnWidth(0.1),
                    3: pw.FractionColumnWidth(0.1),
                    4: pw.FractionColumnWidth(0.1),
                    5: pw.FractionColumnWidth(0.1),
                  },
                ),
        ],
      ),
    );
    i++;
  }

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      theme: pw.ThemeData(defaultTextStyle: pw.TextStyle(font: ttfFont)),
      build: (context) {
        return glen;
      },
    ),
  );

  return pdf.save();
}

List<List<String>> buildTableRows(DekontKayitModel m,
    {int start = 0, int end = 0}) {
  List<List<String>> rows = [];

  for (var j = start; j < end; j++) {
    Cari a = cariEx.searchCariList
        .where((p0) => p0.ID == m.dekontKayitList![j].CARIID)
        .first;
    List<String> row = [
      "${a.ADI}",
      "${Ctanim.donusturMusteri(m.dekontKayitList![j].ALACAK.toString())}",
      "${Ctanim.donusturMusteri(m.dekontKayitList![j].BORC.toString())}",
   "${Ctanim.donusturMusteri(m.dekontKayitList![j].DOVIZALACAK.toString())}",
   "${Ctanim.donusturMusteri(m.dekontKayitList![j].DOVIZBORC.toString())}",
    "${Ctanim.donusturMusteri(m.dekontKayitList![j].KUR.toString())}",
    ];
    rows.add(row);
  }

  return rows;
}

List<List<String>> buildTableRowsUst(DekontKayitModel m,
    {int start = 0, int end = 0}) {
  List<List<String>> rows = [];

  List<String> row = [
    "İşlem Tarihi",
    m.TARIH.toString(),
  ];
  rows.add(row);

  return rows;
}
