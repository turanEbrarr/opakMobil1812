import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:opak_mobil_v2/dekontKayit/model/dekontKayitModel.dart';
import 'package:opak_mobil_v2/localDB/veritabaniIslemleri.dart';
import 'package:opak_mobil_v2/widget/ctanim.dart';
import 'package:printing/printing.dart';

import 'dekontKayitMakePdf.dart';

class DekontPDfOnizleme extends StatefulWidget {
  final DekontKayitModel m;
  final bool fastReporttanMiGelsin;
  const DekontPDfOnizleme(
      {Key? key, required this.m, required this.fastReporttanMiGelsin})
      : super(key: key);

  @override
  State<DekontPDfOnizleme> createState() => _PdfOnizlemeState();
}

class _PdfOnizlemeState extends State<DekontPDfOnizleme> {
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


/*
  Future<Uint8List> pdfGetirFastReport() async {
    var donecek;
    // https://apkwebservis.nativeb4b.com/DIZAYNLAR/099e42b0-83b5-11ee-82a7-23141fef2870.pdf
    String url = Ctanim.IP.replaceAll("/MobilService.asmx", "") + "/DIZAYNLAR/" + widget.m.UUID! + ".pdf";
    print(url);
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    var pdfData = response.bodyBytes;
    donecek = pdfData;
    if(response.statusCode != 200){
      await _loadImage();
      donecek = await makePdf(widget.m, _imageData!);
    }
    return donecek;
  }
  */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData( 
        primaryColor: const Color.fromARGB(255, 80, 79, 79),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('PDF Önizleme'),
          backgroundColor: const Color.fromARGB(255, 80, 79, 79),
        ),
        backgroundColor: const Color.fromARGB(255, 80, 79, 79),
        body: PdfPreview(
          build: (context) async {
           // if (widget.fastReporttanMiGelsin == false) {
             await _loadImage();
              return makePdf(widget.m, _imageData!);
           // }
            /* 
            else {
              return pdfGetirFastReport();
            }*/
          },
        ),
      ),
    );
  }
}