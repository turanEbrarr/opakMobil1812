import 'dart:typed_data';
import 'package:opak_mobil_v2/tahsilatOdemeModel/tahsilat.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import '../faturaFis/fis.dart';
import '../widget/ctanim.dart';

Future<Uint8List> TahsilatMakePdf(
    Tahsilat m, Uint8List imagePath, String belgeTipi) async {
  final image = pw.MemoryImage(imagePath);
  final fontData = await rootBundle.load("images/fonts/Roboto-Regular.ttf");
  final ttfFont = pw.Font.ttf(fontData);

  final boldfontData = await rootBundle.load("images/fonts/Roboto-Bold.ttf");
  final boldttfFont = pw.Font.ttf(boldfontData);

  final pdf = pw.Document();

  int ilkSayfa = 0;
  bool ikinciGozuksun = false;

  if (m.tahsilatHareket.length <= 8) {
    ilkSayfa = m.tahsilatHareket.length;
    ikinciGozuksun = false;
  } else {
    ilkSayfa = 8;
    ikinciGozuksun = true;
  }

  // İlk sayfada üst bilgiler ve tablo başlıkları

  List<Widget> glen = [];
  int i = 0;
  while (i < m.tahsilatHareket.length) {
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
                                height: 60,
                                child: Text("Cari Adı:",
                                    style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.bold,
                                        font: boldttfFont))),
                            SizedBox(
                                height: 20,
                                child: Text("Belge Tipi:",
                                    style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.bold,
                                        font: boldttfFont))),
                            SizedBox(
                                height: 20,
                                child: Text("Cari Bakiye:",
                                    style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.bold,
                                        font: boldttfFont)))
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
                                child: Text(m.CARIKOD.toString(),
                                    style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.bold,
                                        font: boldttfFont))),
                            SizedBox(
                              height: 60,
                              child: SizedBox(
                                width: 200,
                                child: Text(m.CARIADI.toString(),
                                    style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.bold,
                                        font: boldttfFont)),
                              ),
                            ),
                            SizedBox(
                                height: 20,
                                child: Text(belgeTipi,
                                    style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.bold,
                                        font: boldttfFont))),
                            SizedBox(
                                height: 20,
                                child: Text(
                                    Ctanim.donusturMusteri(
                                        m.cariKart.BAKIYE.toString()),
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
                  'Tahsilat Tipi',
                  'Tutar',
                  'Döviz Tipi',
                  'Kur',
                  'Vade Tar.',
                  'Belge No'
                ],
                data: buildTableRows(m, start: i, end: i + 1),
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.centerRight,
                  2: pw.Alignment.center,
                  3: pw.Alignment.centerRight,
                  4: pw.Alignment.center,
                  5: pw.Alignment.center
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
                  1: pw.FractionColumnWidth(0.15),
                  2: pw.FractionColumnWidth(0.15),
                  3: pw.FractionColumnWidth(0.15),
                  4: pw.FractionColumnWidth(0.15),
                  5: pw.FractionColumnWidth(0.15),
                },
                headerHeight: 40)
            : pw.Table.fromTextArray(
                data: buildTableRows(m, start: i, end: i + 1),
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.centerRight,
                  2: pw.Alignment.center,
                  3: pw.Alignment.centerRight,
                  4: pw.Alignment.center,
                  5: pw.Alignment.center
                },
                border: pw.TableBorder.all(color: PdfColors.black),
                columnWidths: {
                  0: pw.FractionColumnWidth(0.4),
                  1: pw.FractionColumnWidth(0.15),
                  2: pw.FractionColumnWidth(0.15),
                  3: pw.FractionColumnWidth(0.15),
                  4: pw.FractionColumnWidth(0.15),
                  5: pw.FractionColumnWidth(0.15),
                },
              ),
/*
        i == m.tahsilatHareket.length - 1
            ? Padding(
                padding: EdgeInsets.only(top: 40),
                child: buildAdditionalInfo(m, boldttfFont))
            : Container(),
            */
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

List<List<String>> buildTableRows(Tahsilat m, {int start = 0, int end = 0}) {
  List<List<String>> rows = [];

  for (var j = start; j < end; j++) {
    List<String> row = [
      "${Ctanim().MapTahsilatOdemeTip[m.tahsilatHareket[j].TIP]}",
      "${Ctanim.donusturMusteri(m.tahsilatHareket[j].TUTAR.toString())}",
      "${m.tahsilatHareket[j].DOVIZ}",
      "${Ctanim.donusturMusteri(m.tahsilatHareket[j].KUR.toString())}",
      "${m.tahsilatHareket[j].VADETARIHI.toString() != "" ? m.tahsilatHareket[j].VADETARIHI.toString() : "-"}",
      "${m.tahsilatHareket[j].CEKSERINO.toString() == "" ? m.tahsilatHareket[j].BELGENO : m.tahsilatHareket[j].CEKSERINO.toString()}",
    ];
    rows.add(row);
  }

  return rows;
}

List<List<String>> buildTableRowsUst(Fis m, {int start = 0, int end = 0}) {
  List<List<String>> rows = [];

  List<String> row = [
    "İşlem Tarihi",
    m.TARIH.toString(),
  ];
  rows.add(row);

  return rows;
}

pw.Widget buildAdditionalInfo(Tahsilat m, pw.Font boldttfFont) {
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
                "Genel Toplam:",
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
                  Ctanim.donusturMusteri(m.GENELTOPLAM!.toString()) + " ₺",
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                    font: boldttfFont,
                  ),
                ),
              ])
        ],
      ),
    ],
  );
}
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