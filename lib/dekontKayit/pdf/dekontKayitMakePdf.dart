import 'dart:typed_data';
import 'package:opak_mobil_v2/dekontKayit/model/dekontKayitModel.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<Uint8List> makePdf(DekontKayitModel m, Uint8List imagePath) async {
  final image = pw.MemoryImage(imagePath);
  final fontData = await rootBundle.load("images/fonts/Roboto-Regular.ttf");
  final ttfFont = pw.Font.ttf(fontData);

  final boldfontData = await rootBundle.load("images/fonts/Roboto-Bold.ttf");
  final boldttfFont = pw.Font.ttf(boldfontData);

  final pdf = pw.Document();

  // ignore: unused_local_variable
  int ilkSayfa = 0;
  // ignore: unused_local_variable
  bool ikinciGozuksun = false;

  if (m.dekontKayitList!.length <= 8) {
    ilkSayfa = m.dekontKayitList!.length;
    ikinciGozuksun = false;
  } else {
    ilkSayfa = 8;
    ikinciGozuksun = true;
  }

  // İlk sayfada üst bilgiler ve tablo başlıkları

  List<Widget> glen = [];
  int i = 0;
  while (i < m.dekontKayitList!.length) {
    glen.add(pw.Column(
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
                                child: Text("İşlem Tarihi:",
                                    style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.bold,
                                        font: boldttfFont))),
                            SizedBox(
                                height: 20,
                                child: Text("Cari Kodu:",
                                    style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.bold,
                                        font: boldttfFont))),
                            SizedBox(
                                height: 20,
                                width: 400,
                                child: Text("Belge Numarası:",
                                    style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.bold,
                                        font: boldttfFont))),
                          ],
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                        ),
                      ),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: 20,
                                child: Text(m.TARIH.toString(),
                                    style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.bold,
                                        font: boldttfFont))),
                            SizedBox(
                                height: 20,
                                child: Text(m.PLASIYERID.toString(),
                                    style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.bold,
                                        font: boldttfFont))),
                            SizedBox(
                                height: 20,
                                child: Text(m.BELGE_NO!,
                                    style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.bold,
                                        font: boldttfFont))),
                          ]),
                      Spacer(),
                      pw.Image(image, width: 150, height: 100),
                      Container(height: 40),
                    ]))
            : Container(),
        i == 0
            ? pw.Table.fromTextArray(
                headers: [
                  'Ürün Açıklaması',
                  'Fiyat',
                  'Isk',
                  'N.Fiyat',
                  'Miktar',
                  'Toplam',
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
                  0: pw.FractionColumnWidth(
                      0.4), // 1. sütun için tablonun genişliğinin yüzde 40'ı
                  1: pw.FractionColumnWidth(
                      0.15), // 2. sütun için tablonun genişliğinin yüzde 10'u
                  2: pw.FractionColumnWidth(
                      0.1), // 3. sütun için tablonun genişliğinin yüzde 10'u
                  3: pw.FractionColumnWidth(
                      0.15), // 4. sütun için tablonun genişliğinin yüzde 10'u
                  4: pw.FractionColumnWidth(
                      0.1), // 5. sütun için tablonun genişliğinin yüzde 10'u
                  5: pw.FractionColumnWidth(
                      0.2), // 6. sütun için tablonun genişliğinin yüzde 20'si
                },
                headerHeight: 40)
            : pw.Table.fromTextArray(
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
                  0: pw.FractionColumnWidth(
                      0.4), // 1. sütun için tablonun genişliğinin yüzde 40'ı
                  1: pw.FractionColumnWidth(
                      0.15), // 2. sütun için tablonun genişliğinin yüzde 10'u
                  2: pw.FractionColumnWidth(
                      0.1), // 3. sütun için tablonun genişliğinin yüzde 10'u
                  3: pw.FractionColumnWidth(
                      0.15), // 4. sütun için tablonun genişliğinin yüzde 10'u
                  4: pw.FractionColumnWidth(
                      0.1), // 5. sütun için tablonun genişliğinin yüzde 10'u
                  5: pw.FractionColumnWidth(
                      0.2), // 6. sütun için tablonun genişliğinin yüzde 20'si
                },
              ),
        i == m.dekontKayitList!.length - 1
            ? /* Padding(
                padding: EdgeInsets.only(top: 40),
                child: buildAdditionalInfo(m, boldttfFont),
              )*/
            Container()
            : Container(),
      ],
    ));
    i++;
  }

  // Diğer sayfalarda sadece tablo

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
    List<String> row = [
      "Belge No : ${m.dekontKayitList![j].BELGE_NO}\n"
          "Mahsup No: ${m.dekontKayitList![j].MAHSUPID}\n"
          "${m.dekontKayitList![j].MIKTAR}",
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
/*
pw.Widget buildAdditionalInfo(DekontKayitModel m, pw.Font boldttfFont) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.end,
    crossAxisAlignment: pw.CrossAxisAlignment.end,
    children: [
      pw.Row(
        children: [
          SizedBox(
            width: 150,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              pw.Text(
                "Ürün Toplamı:",
                style: pw.TextStyle(
                  fontSize: 15,
                  fontWeight: pw.FontWeight.bold,
                  font: boldttfFont,
                ),
              ),
              pw.Text(
                "İndirim Toplamı:",
                style: pw.TextStyle(
                  fontSize: 15,
                  fontWeight: pw.FontWeight.bold,
                  font: boldttfFont,
                ),
              ),
            ]),
          ),
          Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                Ctanim.donusturMusteri(m.TOPLAM!.toString()) + " " + m.DOVIZ!,
                style: pw.TextStyle(
                  fontSize: 15,
                  fontWeight: pw.FontWeight.bold,
                  font: boldttfFont,
                ),
              ),
              pw.Text(
                Ctanim.donusturMusteri(m.INDIRIM_TOPLAMI!.toString()) +
                    " " +
                    m.DOVIZ!,
                style: pw.TextStyle(
                  fontSize: 15,
                  fontWeight: pw.FontWeight.bold,
                  font: boldttfFont,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
*/


/*
  pw.Text(
            "Ürün Toplamı:\t${Ctanim.donusturMusteri(m.TOPLAM!.toString())}",
            style: pw.TextStyle(
              fontSize: 15,
              fontWeight: pw.FontWeight.bold,
              font: boldttfFont,
            ),
          ),
          pw.Text(
            "İndirim Toplamı:\t${Ctanim.donusturMusteri(m.INDIRIM_TOPLAMI!.toString())}",
            style: pw.TextStyle(
              fontSize: 15,
              fontWeight: pw.FontWeight.bold,
              font: boldttfFont,
            ),
          ),
          pw.Text(
            "Ara Toplam:\t${Ctanim.donusturMusteri(m.ARA_TOPLAM!.toString())}",
            style: pw.TextStyle(
              fontSize: 15,
              fontWeight: pw.FontWeight.bold,
              font: boldttfFont,
            ),
          ),
          pw.Text(
            "KDV Tutarı:\t${Ctanim.donusturMusteri(m.KDVTUTARI!.toString())}",
            style: pw.TextStyle(
              fontSize: 15,
              fontWeight: pw.FontWeight.bold,
              font: boldttfFont,
            ),
          ),
          pw.Text(
            "Genel Toplam:\t${Ctanim.donusturMusteri(m.GENELTOPLAM!.toString())}",
            style: pw.TextStyle(
              fontSize: 15,
              fontWeight: pw.FontWeight.bold,
              font: boldttfFont,
            ),
          ),
*/











/*
import 'dart:typed_data';
import 'package:opak_mobil_v2/dekontKayit/model/dekontKayitModel.dart';
import 'package:opak_mobil_v2/widget/ctanim.dart';
import 'package:opak_mobil_v2/widget/veriler/listeler.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

import '../../widget/cari.dart';

Future<Uint8List> DekontMakePdf(
    {required String baslik,
    required DekontKayitModel dekont,
    required Uint8List imagePath,
    required List<List<String>> satir,
    required List<String> kolon}) async {
  final image = pw.MemoryImage(imagePath);
  final fontData = await rootBundle.load("images/fonts/Roboto-Regular.ttf");
  final ttfFont = pw.Font.ttf(fontData);

  final boldfontData = await rootBundle.load("images/fonts/Roboto-Bold.ttf");
  final boldttfFont = pw.Font.ttf(boldfontData);

  final pdf = pw.Document();
  print(satir.length);
  List<Widget> glen = [];
  int i = 0;
  while (i < satir.length) {
    glen.add(pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        i == 0
            ? Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(baslik,
                            style: TextStyle(font: boldttfFont, fontSize: 16)),
                        pw.Image(image, width: 150, height: 100),
                      ]),
                  Column(children: [
                    Row(children: [
                      Text("Cari Kodu: ",
                          style: TextStyle(font: boldttfFont, fontSize: 16)),
                      Text(dekont.PLASIYERID.toString(),
                          style: TextStyle(font: boldttfFont, fontSize: 16))
                    ]),
                    Row(children: [
                      Text("Belge No: ",
                          style: TextStyle(font: boldttfFont, fontSize: 16)),
                      Text(dekont.BELGENO!,
                          style: TextStyle(font: boldttfFont, fontSize: 16))
                    ]),
                  ])
                ]))
            : Container(),
        i == 0
            ? pw.Table.fromTextArray(
                headers: kolon,
                data: buildTableRows(satir, start: i, end: i + 1),
                cellAlignments: {
                  0: pw.Alignment.center,
                  1: pw.Alignment.centerLeft,
                  2: pw.Alignment.centerLeft,
                  3: pw.Alignment.centerLeft,
                  4: pw.Alignment.centerRight,
                  5: pw.Alignment.centerRight,
                  6: pw.Alignment.centerRight,
                  7: pw.Alignment.centerLeft,
                  8: pw.Alignment.centerLeft,
                  9: pw.Alignment.center,
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
                  0: pw.FractionColumnWidth(0.2),
                  1: pw.FractionColumnWidth(0.15),
                  2: pw.FractionColumnWidth(0.17),
                  3: pw.FractionColumnWidth(0.2),
                  4: pw.FractionColumnWidth(0.1),
                  5: pw.FractionColumnWidth(0.1),
                  6: pw.FractionColumnWidth(0.1),
                  7: pw.FractionColumnWidth(0.15),
                  8: pw.FractionColumnWidth(0),
                  9: pw.FractionColumnWidth(0.1),
                },
                headerHeight: 40)
            : pw.Table.fromTextArray(
                data: buildTableRows(satir, start: i, end: i + 1),
                border: pw.TableBorder.all(color: PdfColors.black),
                columnWidths: {
                  0: pw.FractionColumnWidth(0.2),
                  1: pw.FractionColumnWidth(0.15),
                  2: pw.FractionColumnWidth(0.17),
                  3: pw.FractionColumnWidth(0.2),
                  4: pw.FractionColumnWidth(0.1),
                  5: pw.FractionColumnWidth(0.1),
                  6: pw.FractionColumnWidth(0.1),
                  7: pw.FractionColumnWidth(0.15),
                  8: pw.FractionColumnWidth(0),
                  9: pw.FractionColumnWidth(0.1),
                },
                cellAlignments: {
                  0: pw.Alignment.center,
                  1: pw.Alignment.centerLeft,
                  2: pw.Alignment.centerLeft,
                  3: pw.Alignment.centerLeft,
                  4: pw.Alignment.centerRight,
                  5: pw.Alignment.centerRight,
                  6: pw.Alignment.centerRight,
                  7: pw.Alignment.centerLeft,
                  8: pw.Alignment.centerLeft,
                  9: pw.Alignment.center,
                },
              ),
      ],
    ));
    i++;
  }

  // Diğer sayfalarda sadece tablo

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

List<List<String>> buildTableRows(List<List<String>> parca,
    {int start = 0, int end = 0}) {
  List<List<String>> rows = [];

  for (var j = start; j < end; j++) {
    rows.add(parca[start]);
  }

  return rows;
}
*/