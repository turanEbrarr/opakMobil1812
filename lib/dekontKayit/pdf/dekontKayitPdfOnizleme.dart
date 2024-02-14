import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:opak_mobil_v2/dekontKayit/model/dekontKayitModel.dart';
import 'package:opak_mobil_v2/dekontKayit/pdf/dekontKayitMakePdf.dart';
import 'package:opak_mobil_v2/localDB/veritabaniIslemleri.dart';
import 'package:printing/printing.dart';

class DekontPDfOnizleme extends StatefulWidget {
  List<List<String>>? satirlar;
  List<String>? kolonlar;
  final DekontKayitModel? dekont;
  final String? faturaID;
  final String? baslik;

  DekontPDfOnizleme({
    required this.satirlar,
    required this.kolonlar,
    required this.dekont,
    required this.faturaID,
    required this.baslik,
  });

  @override
  State<DekontPDfOnizleme> createState() => _CariEkstreRaporPDfOnizlemeState();
}

class _CariEkstreRaporPDfOnizlemeState extends State<DekontPDfOnizleme> {
  Uint8List? _imageData;

  Future<void> _loadImage() async {
    String? imagePath = await VeriIslemleri().getFirstImage();
    if (imagePath != "") {
      final File imageFile = File(imagePath!);
      final Uint8List imageData = await imageFile.readAsBytes();
      setState(() {
        _imageData = imageData;
      });
    } else {
      final ByteData assetData = await rootBundle.load('images/beyaz.jpg');
      _imageData = assetData.buffer.asUint8List();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:
            const Color.fromARGB(255, 80, 79, 79), // Ana rengi siyah yapar
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('PDF Önizleme'),
          backgroundColor: const Color.fromARGB(255, 80, 79, 79),
        ),
        body: PdfPreview(
          build: (context) async {
            await _loadImage();
            return makePdf(widget.dekont!, _imageData!);
          },
        ),
      ),
    );
  }
}