import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:opak_mobil_v2/controllers/dekontController.dart';
import 'package:opak_mobil_v2/controllers/dekontController.dart';
import 'package:opak_mobil_v2/controllers/stokKartController.dart';
import 'package:opak_mobil_v2/dekontKayit/dekontKayitHareketGiris.dart';
import 'package:opak_mobil_v2/dekontKayit/model/dekontKatirHarModel.dart';
import 'package:opak_mobil_v2/dekontKayit/model/dekontKayitModel.dart';
import 'package:opak_mobil_v2/dekontKayit/pdf/dekontKayitPdfOnizleme.dart';
import 'package:opak_mobil_v2/genel_belge.dart/genel_belge_stok_kart_guncelleme.dart';
import 'package:opak_mobil_v2/stok_kart/Spinkit.dart';
import 'package:opak_mobil_v2/stok_kart/stok_tanim.dart';
import 'package:opak_mobil_v2/webservis/base.dart';
import 'package:opak_mobil_v2/widget/cari.dart';
import 'package:opak_mobil_v2/widget/customAlertDialog.dart';
import 'package:opak_mobil_v2/widget/main_page.dart';
import 'package:opak_mobil_v2/widget/modeller/logModel.dart';
import 'package:opak_mobil_v2/widget/modeller/sHataModel.dart';
import 'package:opak_mobil_v2/widget/veriler/listeler.dart';
import 'package:path/path.dart';
import '../localDB/veritabaniIslemleri.dart';
import '../widget/ctanim.dart';

class DekontKayitListe extends StatefulWidget {
  const DekontKayitListe({
    super.key,
  });

  @override
  State<DekontKayitListe> createState() => _DekontKayitListeState();
}

class _DekontKayitListeState extends State<DekontKayitListe> {
  BaseService bs = BaseService();
  TextEditingController editingController = TextEditingController();
  final StokKartController StokKartEx = Get.find();
  final DekontController dekontEx = Get.find();
  TextStyle boldBlack =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
  }

/*void toplamIskontoHesapla () {
  dekontEx.toplam_iskonto.value =0.0;
    dekontEx.dekont!.value.dekontStokListesi.forEach((element) {
     dekontEx.toplam_iskonto = (dekontEx.toplam_iskonto + ( element.ISK!.toDouble())) as RxDouble;
    });
}*/

/*void araToplamHesapla () {
  dekontEx.toplam
}*/

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    double y = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton:  
      dekontEx.dekont!.value.dekontKayitList!.isNotEmpty?
      Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .05),
        child: FloatingActionButton.extended(
          onPressed: () async {
            DekontKayitModel fiss = dekontEx.dekont!.value;
            if(dekontEx.dekontKontrol(fiss)){
            if (Ctanim.kullanici!.ISLEMAKTARILSIN == "E") {
              dekontEx.dekont!.value.DURUM = true;
              await DekontKayitModel.empty()
                  .dekontEkle(dekont: dekontEx.dekont!.value);
              dekontEx.dekont!.value = DekontKayitModel.empty();
            Navigator.pop(context);
            Navigator.pop(context);

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
                          'Dekont Kaydedildi. PDF Dosyasını Görüntülemek İster misiniz?',
                      onPres: () async {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => DekontPDfOnizleme(
                                      m: fiss,
                                      fastReporttanMiGelsin: false,
                                    )),
                          );
                          
                      },
                      buttonText: 'Pdf\'i\ Gör',
                    );
                  });
            } else {
              dekontEx.dekont!.value.DURUM = true;
              dekontEx.dekont!.value.AKTARILDIMI = true;

              await DekontKayitModel.empty().dekontEkle(
                dekont: dekontEx.dekont!.value,
              );

              int tempID = dekontEx.dekont!.value.ID!;

              // await dekontEx.listdekontGetir(belgeTip: widget.belgeTipi);
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return LoadingSpinner(
                      color: Colors.black,
                      message:
                          "Online Aktarım Aktif. Dekont Merkeze Gönderiliyor..");
                },
              );
              await dekontEx.listGidecekTekDekontGetir(fisID: tempID);

              Map<String, dynamic> jsonListesi =
                  dekontEx.list_dekont_gidecek[0].toJson2();

              setState(() {});
              SHataModel gelenHata = await bs.ekleDekont(
                  jsonDataList: jsonListesi, sirket: Ctanim.sirket!);
              if (gelenHata.Hata == "true") {
                dekontEx.dekont!.value.DURUM = false;
                dekontEx.dekont!.value.AKTARILDIMI = false;
                LogModel logModel = LogModel(
                  TABLOADI: "TBLdekontSB",
                  FISID: dekontEx.list_dekont_gidecek[0].ID,
                  HATAACIKLAMA: gelenHata.HataMesaj,
                  UUID: dekontEx.list_dekont_gidecek[0].UUID,
                  CARIADI: dekontEx.list_dekont_gidecek[0].BELGE_NO,
                );

                await VeriIslemleri().logKayitEkle(logModel);
                print("GÖNDERİM HATASI");
                await Ctanim.showHataDialog(
                    context, gelenHata.HataMesaj.toString(),
                    ikinciGeriOlsunMu: true);
              } else {
                dekontEx.dekont!.value = DekontKayitModel.empty();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(),
                  ),
                  (Route<dynamic> route) => false,
                );

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
                        message:
                            'Dekont merkeze başarıyla gönderildi. PDF dosyasını görmek ister misiniz ?',
                        onPres: () async {
                
                              Navigator.pop(context);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => DekontPDfOnizleme(
                                          m: fiss,
                                          fastReporttanMiGelsin: true,
                                        )),
                              );
                              
                        },
                        buttonText: 'Pdf\'i\ Gör',
                      );
                    });
                setState(() {});
                dekontEx.list_dekont_gidecek.clear();

                print("ONLİNE AKRARIM AKTİF EDİLECEK");
              }
            }
          
            }else{
                 showDialog(
                    context: context,
                    builder: (context) {
                      return CustomAlertDialog(
                        align: TextAlign.left,
                        title: 'Hata',
                        message: 'Dekonta ait borç ve alacak toplamları eşit olmalıdır.',
                        onPres: () async {
                          Navigator.pop(context);
                          setState(() {});
                        },
                        buttonText: 'Geri',
                      );
                    });

            }


          },
          label: Text("Belgeyi Kaydet"),
          icon: Icon(Icons.data_saver_off),
        ),
      ):Container(),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Obx(
                () => ListView.builder(
                    itemCount: dekontEx.dekont?.value.dekontKayitList!.length,
                    itemBuilder: (context, index) {
                      DekontKayitHarModel? dekonthareket =
                          dekontEx.dekont!.value.dekontKayitList![index];
                      List<Cari> tt = cariEx.searchCariList
                          .where((p0) => p0.ID == dekonthareket.CARIID)
                          .toList();
                      Cari cari = tt.first;

                      return urunListeWidget(
                          y, x, dekonthareket, context, index, cari);
                    }),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .05,
            color: Color.fromARGB(255, 66, 82, 97),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  "SATIR-ADET : ",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Text(
                      dekontEx.dekont!.value.dekontKayitList!.length!
                          .toString(),
                      style: const TextStyle(color: Colors.white),
                    )),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding urunListeWidget(
      double y,
      double x,
      DekontKayitHarModel? dekonthareket,
      BuildContext context,
      int index,
      Cari cari) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: y * .01,
                    left: x * .07,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: x * .22,
                          child: Text("Cari Kodu:",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700))),
                      Padding(
                        padding: EdgeInsets.only(left: x * .05),
                        child: SizedBox(
                            width: x * .4,
                            child: Text(
                              maxLines: 2,
                              cari.KOD.toString(),
                              style: TextStyle(fontWeight: FontWeight.w700),
                            )),
                      ),
                      IconButton(
                          onPressed: () {
                            bottomSheetUrunListe(
                                context, dekonthareket!, index);
                          },
                          icon: Icon(Icons.more_vert))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: y * .01,
                    left: x * .07,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: x * .22,
                          child: Text("Cari Adı",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700))),
                      Padding(
                        padding: EdgeInsets.only(left: x * .1),
                        child: SizedBox(
                            width: x * .5,
                            child: Text(
                              cari.ADI.toString(),
                              style: TextStyle(fontWeight: FontWeight.w700),
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: x * .1,
                    //left: x * .07,
                  ),
                  child: Container(
                    height: y * .15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: x * .05),
                              child: SizedBox(
                                width: x * .15,
                                child: Text(
                                  "Alacak :",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: x * .05),
                              child: SizedBox(
                                  width: x * .15,
                                  child: Text("D.Alacak:",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500))),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: x * .05),
                              child: SizedBox(
                                  width: x * .15,
                                  child: Text("İ.Tipi:",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500))),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: x * .05),
                              child: SizedBox(
                                  width: x * .15,
                                  child: Text(
                                    dekonthareket!.ALACAK!.toString(),
                                  )),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: x * .05),
                              child: SizedBox(
                                  width: x * .15,
                                  child: Text(
                                    dekonthareket.DOVIZALACAK!.toString(),
                                  )),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: x * .05),
                              child: SizedBox(
                                  width: x * .15,
                                  child: Text(
                                    dekonthareket.ISLEMTIPI!.toString(),
                                  )),
                            ),
                          ],
                        ),
                        VerticalDivider(
                          thickness: 2,
                          color: Colors.green,
                        ),
                        //turan
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: x * .05),
                              child: SizedBox(
                                width: x * .2,
                                child: Text(
                                  "Borç :",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: x * .05),
                              child: SizedBox(
                                  width: x * .2,
                                  child: Text("D.Borç     :",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500))),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: x * .05),
                              child: SizedBox(
                                  width: x * .2,
                                  child: Text("Personel :",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500))),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: x * .05),
                              child: SizedBox(
                                  width: x * .15,
                                  child: Text(
                                    dekonthareket.BORC!.toString(),
                                  )),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: x * .05),
                              child: SizedBox(
                                  width: x * .15,
                                  child: Text(
                                    dekonthareket.DOVIZBORC!.toString(),
                                  )),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: x * .05),
                              child: SizedBox(
                                width: x * .15,
                                child: Text(
                                  dekonthareket.PERSONELID!.toString(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  void bottomSheetUrunListe(
      BuildContext context, DekontKayitHarModel dekonthareket, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                thickness: 3,
                indent: 150,
                endIndent: 150,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () async {
                  dekontEx.dekont?.value.dekontKayitList!.removeWhere((item) {
                    return item.CARIID == dekonthareket.CARIID! &&
                        item.BELGE_NO == dekonthareket.BELGE_NO!;
                  });
                  await DekontKayitModel.empty()
                      .dekontHarSil(dekonthareket.UUID!);

                  setState(() {});
                  const snackBar = SnackBar(
                    content: Text(
                      'Stok silindi..',
                      style: TextStyle(fontSize: 16),
                    ),
                    showCloseIcon: true,
                    backgroundColor: Colors.blue,
                    closeIconColor: Colors.white,
                  );
                  ScaffoldMessenger.of(context as BuildContext)
                      .showSnackBar(snackBar);
                  Navigator.pop(context);
                  setState(() {});
                },
                child: ListTile(
                  title: Text("Sil"),
                  leading: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => DekontKayitHareketGiris(
                                secilenCari: cariEx.searchCariList
                                    .where(
                                        (p0) => p0.ID == dekonthareket.CARIID)
                                    .first,
                                index: index,
                                duzenleme: true,
                              ))));
                },
                child: ListTile(
                  title: Text("Düzenle"),
                  leading: Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
