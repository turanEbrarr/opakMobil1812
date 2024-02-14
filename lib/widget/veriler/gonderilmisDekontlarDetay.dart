import 'package:flutter/material.dart';
import 'package:opak_mobil_v2/dekontKayit/model/dekontKayitModel.dart';
import '../../tahsilatOdemeModel/tahsilat.dart';
import '../../tahsilatOdemeModel/tahsilatHaraket.dart';
import '../../tahsilatOdemeModel/tahsilat_pdf_onizleme.dart';
import '../appbar.dart';
import '../ctanim.dart';
import '../../genel_belge.dart/genel_belge_pdf_onizleme.dart';

class gonderilmisDekontlarDetay extends StatelessWidget {
  gonderilmisDekontlarDetay({required this.fis});
  final DekontKayitModel fis;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(height: 50, title: "Detay"),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.picture_as_pdf),
        onPressed: () {
          /*
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => TahsilatPdfOnizleme(
                      m: fis,
                      belgeTipi: Ctanim().MapIlslemTipTers[fis.TIP].toString(),
                    )),
          );
          */
        },
      ),
      body: ListView(
        children: [FisHareketDataTable(fis: fis)],
      ),
    );
  }
}

List<Color> rowColors = [
  Color.fromARGB(255, 255, 255, 255),
  Color.fromARGB(255, 174, 179, 176),
];
int _currentColorIndex = 0;
Color getNextRowColor() {
  Color color = rowColors[_currentColorIndex];
  _currentColorIndex = (_currentColorIndex + 1) % rowColors.length;
  return color;
}

class FisHareketDataTable extends StatelessWidget {
  final DekontKayitModel fis;

  FisHareketDataTable({required this.fis});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Column(
          children: [
            Row(children: [
              SizedBox(
                width: 90,
                child: Column(
                  children: [
                    SizedBox(
                        height: 20,
                        child: Text("İşlem Tarihi:",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ))),
                         SizedBox(
                            height: 20,
                            child: Text("Belge No:",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ))),
                       
                     
                        
                   
                
                       
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                    height: 20,
                    child: Text(fis.TARIH.toString(),
                        style: TextStyle(
                          fontSize: 13,
                        ))),
             
               
                     SizedBox(
                        height: 20,
                        child: SizedBox(
                          width: 200,
                          child: Text(fis.BELGE_NO.toString(),
                              style: TextStyle(
                                fontSize: 13,
                              )),
                        ),
                      ),
           
               
                     
                   
              ]),
            ]),
            SizedBox(
              height: 40,
            ),
          
                 SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor:
                            MaterialStateColor.resolveWith((states) {
                          return Color.fromARGB(255, 224, 241, 255);
                        }),
                        dataRowColor: MaterialStateColor.resolveWith((states) {
                          return getNextRowColor();
                        }),
                        dataRowHeight: 80,
                        columns: [
                          DataColumn(label: Text('Belge No')),
                          DataColumn(label: Text('CariID')),
                          DataColumn(label: Text('PersonelID')),
                          DataColumn(label: Text('(D)Borç')),
                          DataColumn(label: Text('(D)Alacak')),
                          DataColumn(label: Text('Vade tarihi')),
                        ],
                        rows: fis.dekontKayitList!
                            .map(
                              (fisHareket) => DataRow(
                                cells: [
                                   DataCell(
                                      Text(fisHareket.BELGE_NO.toString())),
                                  
                                  DataCell(
                                      Text(fisHareket.CARIID.toString())),
                                  DataCell(Text(fisHareket.PERSONELID.toString())),
                                  DataCell(Text(
                                      fisHareket.BORC.toString())),
                                  DataCell(Text(fisHareket.ALACAK.toString())),
                                  DataCell(Text(
                                      fisHareket.VADETARIHI.toString())),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
    
           
          ],
        ),
      ),
    );
  }
}
