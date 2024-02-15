import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:opak_mobil_v2/controllers/dekontController.dart';
import 'package:opak_mobil_v2/controllers/dekontController.dart';
import 'package:opak_mobil_v2/dekontKayit/dekontKayitCariSec.dart';
import 'package:opak_mobil_v2/dekontKayit/dekontKayitUstBilgiGiris.dart';
import 'package:opak_mobil_v2/dekontKayit/dekontTab.dart';
import 'package:opak_mobil_v2/dekontKayit/model/dekontKayitModel.dart';
import 'package:opak_mobil_v2/dekontKayit/pdf/dekontKayitPdfOnizleme.dart';
import 'package:opak_mobil_v2/genel_belge.dart/genel_belge_cari_page.dart';
import 'package:opak_mobil_v2/genel_belge.dart/genel_belge_tab_page.dart';
import 'package:opak_mobil_v2/webservis/base.dart';
import 'package:opak_mobil_v2/widget/appbar.dart';
import 'package:uuid/uuid.dart';
import '../localDB/veritabaniIslemleri.dart';
import '../stok_kart/Spinkit.dart';
import '../widget/ctanim.dart';
import '../widget/customAlertDialog.dart';
import '../widget/modeller/logModel.dart';
import '../widget/modeller/sharedPreferences.dart';
import '../widget/veriler/listeler.dart';
import '../widget/modeller/sHataModel.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

enum PopupMenuOption { duzenle, sil, kaydet }

//DENEME
class DekontKayitMain extends StatefulWidget {
  final int widgetListBelgeSira;
  const DekontKayitMain({super.key, required this.widgetListBelgeSira});

  @override
  State<DekontKayitMain> createState() => _DekontKayitMainState();
}

class _DekontKayitMainState extends State<DekontKayitMain> {
  BaseService b = BaseService();
  var uuid = Uuid();
  Color favIconColor = Colors.black;
  DekontController dekontEx = Get.find();
  TextStyle bold = const TextStyle(fontWeight: FontWeight.bold);

  @override
/*
  void dispose() {
    dekontEx.dekont!.value.DEPOID = int.parse(Ctanim.kullanici!.YERELDEPOID!);
    dekontEx.dekont!.value.SUBEID = int.parse(Ctanim.kullanici!.YERELSUBEID!);

    dekont.empty().dekontEkle(dekont: dekontEx.dekont!.value, belgeTipi: widget.belgeTipi);
    dekontEx.dekont!.value = dekont.empty();
    super.dispose();
    //listede güncelleme yaptı ve çıktı
  }
*/
  @override
  Widget build(BuildContext context) {
    if (listeler.sayfaDurum[widget.widgetListBelgeSira] == true) {
      setState(() {
        favIconColor = Colors.amber;
      });
    } else {
      setState(() {
        favIconColor = Colors.white;
      });
    }
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_arrow,
        backgroundColor: Color.fromARGB(255, 30, 38, 45),
        buttonSize: Size(65, 65),
        children: [
          SpeedDialChild(
            backgroundColor: Color.fromARGB(255, 70, 89, 105),
            child: IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () async {
                  await dekontEx.listDekontGetir();
                  setState(() {});
                }),
            label: "Listeyi Yenile",
          ),
          SpeedDialChild(
              backgroundColor: Color.fromARGB(255, 70, 89, 105),
              child: Icon(
                Icons.star,
                color: favIconColor,
                size: 32,
              ),
              label: favIconColor == Colors.amber
                  ? "Favorilerimden Kaldır"
                  : "Favorilerime Ekle",
              onTap: () async {
                listeler.sayfaDurum[widget.widgetListBelgeSira] =
                    !listeler.sayfaDurum[widget.widgetListBelgeSira]!;
                if (listeler.sayfaDurum[widget.widgetListBelgeSira] == true) {
                  setState(() {
                    favIconColor = Colors.amber;
                  });
                } else {
                  setState(() {
                    favIconColor = Colors.white;
                  });
                }
                await SharedPrefsHelper.saveList(listeler.sayfaDurum);
              }),
          SpeedDialChild(
              backgroundColor: Color.fromARGB(255, 70, 89, 105),
              child: Icon(
                Icons.add,
                color: Colors.green,
                size: 32,
              ),
              label: "Yeni Belge Oluştur",
              onTap: () {
                dekontEx.dekont!.value = DekontKayitModel.empty();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DekontKayitUstBilgi()));
              })
        ],
      ),
      appBar: MyAppBar(height: 50, title: "Dekont Kayıt"),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: dekontEx.list_dekont.length > 0
                  ? Obx(() => ListView.builder(
                        itemCount: dekontEx.list_dekont.length,
                        itemBuilder: (context, index) {
                          DekontKayitModel dekont = dekontEx.list_dekont[index];
                          /*
                          List<String> toplamList = akbankStyle(
                              Ctanim.donusturMusteri(
                                  dekont.GENELTOPLAM.toString()));
                          print("list1" + toplamList[0]);
                          print("list2" + toplamList[1]);
*/
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        bottomRight: Radius.circular(10))),
                                elevation: 10,
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 20,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .1),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .7,
                                              child: Text(
                                                dekont.BELGE_NO.toString(),
                                                maxLines: 3,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Spacer(),
                                            IconButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            16.0),
                                                      ),
                                                    ),
                                                    builder:
                                                        (BuildContext context) {
                                                      return Container(
                                                        padding: EdgeInsets.all(
                                                            16.0),
                                                        /* height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.35,
                                                            */
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Divider(
                                                              thickness: 3,
                                                              indent: 150,
                                                              endIndent: 150,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                dekontEx.dekont
                                                                        ?.value =
                                                                    dekontEx.list_dekont[
                                                                        index];
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                DekontKayitTab()));
                                                              },
                                                              child: ListTile(
                                                                title: Text(
                                                                    "Düzenle"),
                                                                leading: Icon(
                                                                  Icons.edit,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                print("Sil");
                                                                showAlertDialog(
                                                                    context,
                                                                    index);
                                                              },
                                                              child: ListTile(
                                                                title:
                                                                    Text("Sil"),
                                                                leading: Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                
                                                                
                                                                Navigator.of(
                                                                        context)
                                                                    .push(
                                                                  MaterialPageRoute(
                                                                      builder: (context) => DekontPDfOnizleme(
                                                                        fastReporttanMiGelsin: false,
                                                                          m: dekontEx
                                                                              .list_dekont[index])),
                                                                );
                                                                
                                                              
                                                              },
                                                              child: ListTile(
                                                                title:
                                                                    Text("PDF"),
                                                                leading: Icon(
                                                                  Icons
                                                                      .picture_as_pdf,
                                                                  color: Colors
                                                                      .amber,
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                if (dekontEx
                                                                        .list_dekont[
                                                                            index]
                                                                        .dekontKayitList!
                                                                        .length !=
                                                                    0) {
                                                                  if (dekontEx
                                                                      .dekontKontrol(
                                                                          dekontEx
                                                                              .list_dekont[index])) {
                                                                    DekontKayitModel
                                                                        dekontTemp =
                                                                        dekontEx
                                                                            .list_dekont[index];
                                                                    // e-fatura kontrolu ve fatura no ekleme işlemi

                                                                    if (Ctanim
                                                                            .kullanici!
                                                                            .ISLEMAKTARILSIN ==
                                                                        "H") {
                                                                      dekontEx
                                                                          .list_dekont[
                                                                              index]
                                                                          .DURUM = true;

                                                                      DekontKayitModel
                                                                              .empty()
                                                                          .dekontEkle(
                                                                        dekont:
                                                                            dekontEx.list_dekont[index],
                                                                      );
                                                                      dekontEx.dekont!
                                                                              .value =
                                                                          DekontKayitModel
                                                                              .empty();
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return CustomAlertDialog(
                                                                              secondButtonText: "Tamam",
                                                                              onSecondPress: () {
                                                                                Navigator.pop(context);
                                                                                Navigator.pop(context);
                                                                              },
                                                                              pdfSimgesi: true,
                                                                              align: TextAlign.center,
                                                                              title: 'Kayıt Başarılı',
                                                                              message: 'Dekont Kaydedildi. PDF Dosyasını Görüntülemek İster misiniz?',
                                                                              onPres: () async {
                                                                                
                                                                              Navigator.pop(context);
                                                                              Navigator.of(context).push(
                                                                                MaterialPageRoute(
                                                                                    builder: (context) => DekontPDfOnizleme(
                                                                                          m: dekontTemp,
                                                                                          fastReporttanMiGelsin: false,
                                                                                        )),
                                                                                        
                                                                              );
                                                                              
                                                                              },
                                                                              buttonText: 'Pdf\'i\ Gör',
                                                                            );
                                                                          });
                                                                      await dekontEx
                                                                          .listDekontGetir();
                                                                      setState(
                                                                          () {});
                                                                    } else {
                                                                      dekontEx
                                                                          .list_dekont[
                                                                              index]
                                                                          .DURUM = true;
                                                                      dekontEx
                                                                          .list_dekont[
                                                                              index]
                                                                          .AKTARILDIMI = true;

                                                                      await DekontKayitModel
                                                                              .empty()
                                                                          .dekontEkle(
                                                                        dekont:
                                                                            dekontEx.list_dekont[index],
                                                                      );
                                                                      int tempID = dekontEx
                                                                          .list_dekont[
                                                                              index]
                                                                          .ID!;

                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        barrierDismissible:
                                                                            false,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return LoadingSpinner(
                                                                            color:
                                                                                Colors.black,
                                                                            message:
                                                                                "Online Aktarım Aktif. Dekont Merkeze Gönderiliyor..",
                                                                          );
                                                                        },
                                                                      );
                                                                      await dekontEx.listGidecekTekDekontGetir(
                                                                          fisID:
                                                                              tempID);

                                                                      Map<String,
                                                                              dynamic>
                                                                          jsonListesi =
                                                                          dekontEx
                                                                              .list_dekont_gidecek[0]
                                                                              .toJson2();
                                                                      setState(
                                                                          () {});

                                                                      SHataModel
                                                                          gelenHata =
                                                                          await b.ekleDekont(
                                                                              jsonDataList: jsonListesi,
                                                                              sirket: Ctanim.sirket!);
                                                                      if (gelenHata
                                                                              .Hata ==
                                                                          "true") {
                                                                        dekontEx
                                                                            .list_dekont[index]
                                                                            .DURUM = false;
                                                                        dekontEx
                                                                            .list_dekont[index]
                                                                            .AKTARILDIMI = false;
                                                                        await DekontKayitModel.empty()
                                                                            .dekontEkle(
                                                                          dekont:
                                                                              dekontEx.list_dekont[index],
                                                                        );
                                                                        LogModel
                                                                            logModel =
                                                                            LogModel(
                                                                          TABLOADI:
                                                                              "TBLdekontTempB",
                                                                          FISID: dekontEx
                                                                              .list_dekont_gidecek[0]
                                                                              .ID,
                                                                          HATAACIKLAMA:
                                                                              gelenHata.HataMesaj,
                                                                          UUID: dekontEx
                                                                              .list_dekont_gidecek[0]
                                                                              .UUID,
                                                                          CARIADI: dekontEx
                                                                              .list_dekont_gidecek[0]
                                                                              .BELGE_NO,
                                                                        );

                                                                        await VeriIslemleri()
                                                                            .logKayitEkle(logModel);
                                                                        print(
                                                                            "GÖNDERİM HATASI");

                                                                        await Ctanim.showHataDialog(
                                                                            context,
                                                                            gelenHata.HataMesaj
                                                                                .toString(),
                                                                            ikinciGeriOlsunMu:
                                                                                true);
                                                                      } else {
                                                                        Navigator.pop(
                                                                            context);
                                                                        Navigator.pop(
                                                                            context);
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return CustomAlertDialog(
                                                                                pdfSimgesi: true,
                                                                                secondButtonText: "Geri",
                                                                                onSecondPress: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                align: TextAlign.left,
                                                                                title: 'Başarılı',
                                                                                message: 'Belge merkeze başarıyla gönderildi. PDF dosyasını görmek ister misiniz ?',
                                                                                onPres: () async {
                                                                                  Navigator.pop(context);
                                                                                  
                                                                                  Navigator.of(context).push(
                                                                                    MaterialPageRoute(
                                                                                        builder: (context) => DekontPDfOnizleme(
                                                                                              m: dekontTemp,
                                                                                              fastReporttanMiGelsin: true,
                                                                                            )),
                                                                                  );
                                                                                  
                                                                                },
                                                                                buttonText: 'Pdf\'i\ Gör',
                                                                              );
                                                                            });
                                                                        await dekontEx
                                                                            .listDekontGetir();
                                                                        setState(
                                                                            () {});
                                                                        dekontEx
                                                                            .list_dekont_gidecek
                                                                            .clear();

                                                                        print(
                                                                            "ONLİNE AKRARIM AKTİF EDİLECEK");
                                                                      }
                                                                    }
                                                                  } else {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return CustomAlertDialog(
                                                                            align:
                                                                                TextAlign.left,
                                                                            title:
                                                                                'Hata',
                                                                            message:
                                                                                'Dekonta ait borç ve alacak toplamları eşit olmalıdır.',
                                                                            onPres:
                                                                                () async {
                                                                              Navigator.pop(context);
                                                                              setState(() {});
                                                                            },
                                                                            buttonText:
                                                                                'Geri',
                                                                          );
                                                                        });
                                                                  }
                                                                } else {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return CustomAlertDialog(
                                                                          align:
                                                                              TextAlign.center,
                                                                          title:
                                                                              'Hata',
                                                                          message:
                                                                              'Dekontun Kalem Listesi Boş Olamaz',
                                                                          onPres:
                                                                              () async {
                                                                            Navigator.pop(context);

                                                                            setState(() {});
                                                                          },
                                                                          buttonText:
                                                                              'Geri',
                                                                        );
                                                                      });
                                                                }
                                                              },
                                                              child: ListTile(
                                                                title: Text(
                                                                    " Belgeyi Kaydet"),
                                                                leading: Icon(
                                                                  Icons.save,
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: Icon(Icons.more_vert))
                                            /*
                                        PopupMenuButton<PopupMenuOption>(
                                          itemBuilder: (BuildContext context) =>
                                              [
                                            PopupMenuItem<PopupMenuOption>(
                                              value: PopupMenuOption.duzenle,
                                              child: Text('Düzenle'),
                                            ),
                                            PopupMenuItem<PopupMenuOption>(
                                              value: PopupMenuOption.sil,
                                              child: Text('Sil'),
                                            ),
                                            PopupMenuItem<PopupMenuOption>(
                                              value: PopupMenuOption.kaydet,
                                              child: Text('Kaydet'),
                                            ),
                                          ],
                                          onSelected: (PopupMenuOption option) {
                                            if (option ==
                                                PopupMenuOption.duzenle) {
                                              dekontEx.dekont?.value =
                                                  dekontEx.list_dekont[index];
                                              Get.to(() => genel_belge_tab_page(
                                                    belgeTipi: widget.belgeTipi,
                                                    cariKod: dekont.CARIKOD,
                                                    cariKart: dekont.cariKart,
                                                  ));
                                            } else if (option ==
                                                PopupMenuOption.sil) {
                                              print("Sil");
                                              showAlertDialog(context, index);
                                            } else if (option ==
                                                PopupMenuOption.kaydet) {
                                              dekontEx.list_dekont[index].DURUM =
                                                  true;
                                              dekont.empty().dekontEkle(
                                                  dekont: dekontEx.list_dekont[index],
                                                  belgeTipi: widget.belgeTipi);
                                              dekontEx.dekont!.value = dekont.empty();

                                              dekontEx.listdekontGetir(
                                                  belgeTip: widget.belgeTipi);

                                              super.dispose();
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return CustomAlertDialog(
                                                      title: 'Kayıt Başarılı',
                                                      message:
                                                          'Fatura Kaydedildi',
                                                      onPres: () {
                                                        Get.back();
                                                        setState(() {});
                                                      },
                                                      buttonText: 'Tamam',
                                                    );
                                                  });

                                              ////////

                                              /*ONLİNE AKRARIM AKTİF EDİLECEK*/

                                              //////////
                                              if (true) {
                                                print(
                                                    "ONLİNE AKRARIM AKTİF EDİLECEK");
                                              }
                                            }
                                          },
                                        ),
                                        */
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .1),
                                        child: Row(
                                          children: [
                                            Text(
                                              dekont.PLASIYERID.toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 81, 81, 81)),
                                            )
                                          ],
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 40,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .1),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Fatura toplamı",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Color.fromARGB(
                                                    255, 81, 81, 81)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 10,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: [
                                                TextSpan(
                                                    text: "Tutar : ",
                                                    style: bold),
                                              ],
                                            ),
                                          ),
                                          Text(dekont.DOVIZID.toString())
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Divider(
                                        thickness: 10,
                                        color: Colors.green,
                                      ),
                                    )
                                  ],
                                )),
                          );
                        },
                      ))
                  : SizedBox(
                      height: 50,
                      width: 50,
                      child: Center(
                          child: IconButton(
                              icon: Center(
                                  child: Icon(
                                Icons.refresh,
                                size: 50,
                              )),
                              onPressed: () async {
                                await dekontEx.listDekontGetir();
                                setState(() {});
                              })),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> akbankStyle(String text) {
    List<String> don = text.split(",");
    return don;
  }

  showAlertDialog(BuildContext context, int index) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("İptal"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Devam"),
      onPressed: () {
        try {
          dekontEx.dekont?.value = dekontEx.list_dekont[index];
          print(dekontEx.dekont?.value.ID);

          DekontKayitModel.empty()
              .dekontVeHareketSil(dekontEx.dekont!.value.ID!);
          dekontEx.list_dekont
              .removeWhere((item) => item.ID == dekontEx.dekont!.value.ID!);
          const snackBar = SnackBar(
            duration: Duration(microseconds: 500),
            content: Text(
              'Fiş silindi..',
              style: TextStyle(fontSize: 16),
            ),
            showCloseIcon: true,
            backgroundColor: Colors.blue,
            closeIconColor: Colors.white,
          );
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
        } on PlatformException catch (e) {
          print(e);
        }
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("İşlem Onayı"),
      content: Text(
          "Belge Silindiğinde Geri Döndürürelemez. Devam Etmek İstiyor musunuz?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
