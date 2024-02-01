import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:opak_mobil_v2/controllers/fisController.dart';
import 'package:opak_mobil_v2/faturaFis/fisEkParam.dart';
import 'package:opak_mobil_v2/genel_belge.dart/genel_belge_tab_page.dart';
import 'package:opak_mobil_v2/localDB/veritabaniIslemleri.dart';
import 'package:opak_mobil_v2/stok_kart/Spinkit.dart';
import 'package:opak_mobil_v2/webservis/base.dart';
import 'package:opak_mobil_v2/widget/customAlertDialog.dart';
import 'package:opak_mobil_v2/widget/modeller/logModel.dart';
import 'package:opak_mobil_v2/widget/modeller/sHataModel.dart';
import '../../faturaFis/fisHareket.dart';
import '../../faturaFis/fis.dart';
import '../appbar.dart';
import '../ctanim.dart';
import '../../genel_belge.dart/genel_belge_pdf_onizleme.dart';
import '../../Depo Transfer/depo_transfer_pdf_onizleme.dart';
import 'package:intl/intl.dart';

class gonderilmisBelgelerDetay extends StatelessWidget {
  gonderilmisBelgelerDetay({required this.fis});
    FisController fisEx = Get.find();
  final Fis fis;

  @override
  Widget build(BuildContext context) {
    BaseService bs = BaseService();
    return Scaffold(
      appBar: MyAppBar(height: 50, title: "Detay"),
   
            floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_arrow,
          backgroundColor: Color.fromARGB(255, 30, 38, 45),
          buttonSize: Size(65, 65),
          children: [
            SpeedDialChild(
                backgroundColor: Color.fromARGB(255, 70, 89, 105),
                child: Icon(
                  Icons.refresh,
                  color: Colors.blue,
                  size: 32,
                ),
                label: "Tekrar Gönder",
                onTap: () async {
                fisEx.fis?.value = fis;
                fisEx.fis?.value.AKTARILDIMI = false;
                String belgeTip = Ctanim().MapFisTipTersENG[fisEx.fis!.value.TIP].toString();
                if (fisEx.fis!.value.fisStokListesi.length != 0) {
                Fis fiss = fisEx.fis!.value;
                if (Ctanim.kullanici!.ISLEMAKTARILSIN == "H") {
                fisEx.fis!.value.DURUM = true;
                fisEx.fis!.value.AKTARILDIMI = false;
              final now = DateTime.now();
              final formatter = DateFormat('HH:mm');
              String saat = formatter.format(now);
              fisEx.fis!.value.SAAT = saat;
              
                await Fis.empty()
                    .fisEkle(fis: fisEx.fis!.value, belgeTipi: belgeTip);
        

              fisEx.fis!.value = Fis.empty();
              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog(
                      secondButtonText: "Tamam",
                      onSecondPress: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      pdfSimgesi: true,
                      align: TextAlign.center,
                      title: 'Kayıt Başarılı',
                      message:
                          'Fatura Kaydedildi. PDF Dosyasını Görüntülemek İster misiniz?',
                      onPres: () async {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => PdfOnizleme(
                                    m: fiss,
                                    fastReporttanMiGelsin: false,
                                  )),
                        );
                      },
                      buttonText: 'Pdf\'i\ Gör',
                    );
                  });
            } else {
              final now = DateTime.now();
              final formatter = DateFormat('HH:mm');
              String saat = formatter.format(now);
              fisEx.fis!.value.SAAT = saat;
              fisEx.fis!.value.DURUM = true;
              fisEx.fis!.value.AKTARILDIMI = true;
                await Fis.empty()
                    .fisEkle(fis: fisEx.fis!.value, belgeTipi: belgeTip);
              int tempID = fisEx.fis!.value.ID!;// await fisEx.listFisGetir(belgeTip: widget.belgeTipi);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return LoadingSpinner(
                      color: Colors.black,
                      message: belgeTip != "Perakende_Satis"
                          ? "Online Aktarım Aktif. Belge Merkeze Gönderiliyor.."
                          : "Online Aktarım Aktif. Fiş Merkeze Gönderiliyor..",
                    );
                  },
                );
                await fisEx.listGidecekTekFisGetir(
                    belgeTip: belgeTip, fisID: tempID);

                Map<String, dynamic> jsonListesi =
                    fisEx.list_fis_gidecek[0].toJson2();

                SHataModel gelenHata = await bs.ekleFatura(
                    jsonDataList: jsonListesi, sirket: Ctanim.sirket!);
                if (gelenHata.Hata == "true") {
                  LogModel logModel = LogModel(
                    TABLOADI: "TBLFISSB",
                    FISID: fisEx.list_fis_gidecek[0].ID,
                    HATAACIKLAMA: gelenHata.HataMesaj,
                    UUID: fisEx.list_fis_gidecek[0].UUID,
                    CARIADI: fisEx.list_fis_gidecek[0].CARIADI,
                  );

                  await VeriIslemleri().logKayitEkle(logModel);
                  print("GÖNDERİM HATASI");
                  await Ctanim.showHataDialog(
                      context, gelenHata.HataMesaj.toString(),
                      ikinciGeriOlsunMu: true);
                } else {
                  fisEx.fis!.value = Fis.empty();
                  /*
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                  */
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomAlertDialog(
                          pdfSimgesi: true,
                          secondButtonText: "Geri",
                          onSecondPress: () {
                            Navigator.pop(context);
                          },
                          align: TextAlign.left,
                          title: 'Başarılı',
                          message: belgeTip != "Perakende_Satis"
                              ? 'Belge merkeze başarıyla gönderildi. PDF dosyasını görmek ister misiniz ?'
                              : 'Fiş merkeze başarıyla gönderildi. PDF dosyasını görmek ister misiniz ?',
                          onPres: () async {
                            /*
                           Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          pdfForFasr())));
                                          */

                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => PdfOnizleme(
                                        m: fiss,
                                        fastReporttanMiGelsin: true,
                                      )),
                            );
                          },
                          buttonText: 'Pdf\'i\ Gör',
                        );
                      });
            
                  fisEx.list_fis_gidecek.clear();

                  print("ONLİNE AKRARIM AKTİF EDİLECEK");
                }
             
            }
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return CustomAlertDialog(
                    align: TextAlign.center,
                    title: 'Hata',
                    message: 'Faturanın Kalem Listesi Boş Olamaz',
                    onPres: () async {
                      Navigator.pop(context);
                    },
                    buttonText: 'Geri',
                  );
                });
          }
                  
                }),
            SpeedDialChild(
                backgroundColor: Color.fromARGB(255, 70, 89, 105),
                child: Icon(
                  Icons.picture_as_pdf,
                  color: Colors.red,
                  size: 32,
                ),
                label: "PDF Görüntüle",
                onTap: () async {
                   if (Ctanim().MapFisTipTers[fis.TIP].toString() != "Depo Transfer") {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PdfOnizleme(m: fis,fastReporttanMiGelsin: false,)));
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      DepoTransferPdfOnizleme(m: fis)),
            );
          }
                
                }),
            
          ],
        ),
     
     /*
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.picture_as_pdf),
        onPressed: () {
          if (Ctanim().MapFisTipTers[fis.TIP].toString() != "Depo Transfer") {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PdfOnizleme(m: fis,fastReporttanMiGelsin: true,)));
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      DepoTransferPdfOnizleme(m: fis)),
            );
          }
        },
      ),
      */
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
  final Fis fis;

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
                    Ctanim().MapFisTipTers[fis.TIP].toString() !=
                            "Depo Transfer"
                        ? SizedBox(
                            height: 20,
                            child: Text("Cari Kodu:",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                )))
                        : Container(),
                    Ctanim().MapFisTipTers[fis.TIP].toString() !=
                            "Depo Transfer"
                        ? SizedBox(
                            height: 60,
                            child: Text("Cari Adı:",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                )))
                        : Container(),
                          SizedBox(
                        height: 20,
                      
                        child: Text("Belge Numarası:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ))),
                    SizedBox(
                        height: 20,
                        child: Text("Belge Tipi:",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ))),
                    Ctanim().MapFisTipTers[fis.TIP].toString() !=
                            "Depo Transfer"
                        ? SizedBox(
                            height: 20,
                            child: Text("Cari Bakiye:",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                )))
                        : Container(),
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
                Ctanim().MapFisTipTers[fis.TIP].toString() != "Depo Transfer"
                    ? SizedBox(
                        height: 20,
                        child: Text(fis.CARIKOD.toString(),
                            style: TextStyle(
                              fontSize: 13,
                            )))
                    : Container(),
                Ctanim().MapFisTipTers[fis.TIP].toString() != "Depo Transfer"
                    ? SizedBox(
                        height: 60,
                        child: SizedBox(
                          width: 200,
                          child: Text(fis.CARIADI.toString(),
                              style: TextStyle(
                                fontSize: 13,
                              )),
                        ),
                      )
                    : Container(),
                     SizedBox(
                    height: 20,
                    child: Text(fis.FATURANO.toString(),
                        style: TextStyle(
                          fontSize: 13,
                        ))),

                SizedBox(
                    height: 20,
                    child: Text(Ctanim().MapFisTipTers[fis.TIP].toString(),
                        style: TextStyle(
                          fontSize: 13,
                        ))),
                Ctanim().MapFisTipTers[fis.TIP].toString() != "Depo Transfer"
                    ? SizedBox(
                        height: 20,
                        child: Text(
                            Ctanim.donusturMusteri(
                                fis.cariKart.BAKIYE.toString()),
                            style: TextStyle(
                              fontSize: 13,
                            )))
                    : Container(),
              ]),
            ]),
            SizedBox(
              height: 40,
            ),
            Ctanim().MapFisTipTers[fis.TIP].toString() != "Depo Transfer"
                ? SingleChildScrollView(
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
                          DataColumn(label: Text('Ürün Açıklaması')),
                          DataColumn(label: Text('Fiyat')),
                          DataColumn(label: Text('Isk')),
                          DataColumn(label: Text('N.Fiyat')),
                          DataColumn(label: Text('Miktar')),
                          DataColumn(label: Text('Toplam')),
                        ],
                        rows: fis.fisStokListesi
                            .map(
                              (fisHareket) => DataRow(
                                cells: [
                                  DataCell(Text("BARKOD :" +
                                      fisHareket.STOKKOD.toString() +
                                      "\n" +
                                      "ÜRÜN ADI :" +
                                      fisHareket.STOKADI.toString() +
                                      "\n" +
                                      "KDV :" +
                                      fisHareket.KDVORANI.toString())),
                                  DataCell(
                                      Text(fisHareket.NETFIYAT.toString())),
                                  DataCell(Text(fisHareket.ISK.toString())),
                                  DataCell(Text(
                                      fisHareket.ISKONTOTOPLAM.toString())),
                                  DataCell(Text(fisHareket.MIKTAR.toString())),
                                  DataCell(Text(
                                      fisHareket.KDVDAHILNETTOPLAM.toString())),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  )
                : SingleChildScrollView(
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
                          DataColumn(label: Text('Ürün Açıklaması')),
                          DataColumn(label: Text('Miktar')),
                          DataColumn(label: Text('Birim')),
                        ],
                        rows: fis.fisStokListesi
                            .map(
                              (fisHareket) => DataRow(
                                cells: [
                                  DataCell(Text("BARKOD :" +
                                      fisHareket.STOKKOD.toString() +
                                      "\n" +
                                      "ÜRÜN ADI :" +
                                      fisHareket.STOKADI.toString())),
                                  DataCell(Text(fisHareket.MIKTAR.toString())),
                                  DataCell(Text(fisHareket.BIRIM.toString())),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
            Ctanim().MapFisTipTers[fis.TIP].toString() != "Depo Transfer"
                ? Padding(
                    padding: const EdgeInsets.only(
                        top: 40, left: 8, right: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ürün Toplamı:",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "İndirim Toplamı:",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Ara Toplam:",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "KDV Tutarı:",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Genel Toplam:",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]),
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    Ctanim.donusturMusteri(
                                            fis.TOPLAM!.toString()) +
                                        " ₺",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    Ctanim.donusturMusteri(
                                            fis.INDIRIM_TOPLAMI!.toString()) +
                                        " ₺",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    Ctanim.donusturMusteri(
                                            fis.ARA_TOPLAM!.toString()) +
                                        " ₺",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    Ctanim.donusturMusteri(
                                            fis.KDVTUTARI!.toString()) +
                                        " ₺",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    Ctanim.donusturMusteri(
                                            fis.GENELTOPLAM!.toString()) +
                                        " ₺",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ])
                          ],
                        ),
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
