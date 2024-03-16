import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:opak_mobil_v2/localDB/veritabaniIslemleri.dart';
import 'package:opak_mobil_v2/widget/ctanim.dart';
import 'package:http/http.dart' as http;

import 'package:printing/printing.dart';

import '../../widget/cari.dart';
import 'kapatilmamis_faturalar_make_pdf.dart';

class kapatilmamisFaturalarPdfOnizleme extends StatefulWidget {
 final String uuid;
 final int tip;

  kapatilmamisFaturalarPdfOnizleme({
    required this.uuid,
    required this.tip,
    
  });

  @override
  State<kapatilmamisFaturalarPdfOnizleme> createState() =>
      _kapatilmamisFaturalarPdfOnizlemeState();
}

class _kapatilmamisFaturalarPdfOnizlemeState
    extends State<kapatilmamisFaturalarPdfOnizleme> {
  Uint8List? _imageData;

  Future<void> _loadImage() async {
    // Veritabanından resmin yolunu alın
    String? imagePath = await VeriIslemleri().getFirstImage();
    if (imagePath != "") {
      // Resim yolu varsa, bu yolu Uint8List'e dönüştürün ve _imageData değişkenine atayın
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
    Future<Uint8List> pdfGetirFastReport() async {
      Ctanim.kullanici!.KOD;
    var donecek;
    // https://apkwebservis.nativeb4b.com/DIZAYNLAR/099e42b0-83b5-11ee-82a7-23141fef2870.pdf
    String url = Ctanim.IP.replaceAll("/MobilService.asmx", "") + "/DIZAYNLAR/" + widget.uuid + ".pdf";
    Uri uri = Uri.parse(url);
    try{http.Response response = await http.get(uri);
    var pdfData = response.bodyBytes;
    donecek = pdfData;
    if(response.statusCode != 200){
      await _loadImage();
         Navigator.pop(context);
          Navigator.pop(context);
    
    }

    return donecek;

    }catch(e){
      Navigator.pop(context);
       Navigator.pop(context);

     return donecek;
    }

  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Temayı karanlık (siyah) yapar
        primaryColor:
            const Color.fromARGB(255, 80, 79, 79), // Ana rengi siyah yapar
        // Vurgu rengini gri yapar (isteğe bağlı)
        // Diğer tema özelliklerini istediğiniz gibi ayarlayabilirsiniz
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('PDF Önizleme'),
          backgroundColor: const Color.fromARGB(255, 80, 79, 79),
        ),
        body: PdfPreview(
          build: (context) async {
  
            return pdfGetirFastReport();
          },
        ),
      ),
    );
  }
}
