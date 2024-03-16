import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:opak_mobil_v2/webservis/base.dart';
import 'package:opak_mobil_v2/widget/ctanim.dart';
import 'package:opak_mobil_v2/widget/modeller/gecmisSatisModel.dart';
import 'package:opak_mobil_v2/widget/veriler/listeler.dart';
import '../controllers/fisController.dart';
import '../faturaFis/fis.dart';

class genel_belge_gecmis_satis_bilgileri extends StatefulWidget {
  genel_belge_gecmis_satis_bilgileri({
    super.key,
  });

  @override
  State<genel_belge_gecmis_satis_bilgileri> createState() =>
      siparis_fatura_expanded_widgetState();
}

FisController fisEx = Get.find();
String hataKontrol = "";

class siparis_fatura_expanded_widgetState
    extends State<genel_belge_gecmis_satis_bilgileri> {
  List<GecmisSatisModel> tempList = [];
  TextEditingController _controller = TextEditingController();
  var tipList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tempList.addAll(listeler.listGecmisSatisModel);
    // gecmisSatisGetir().then((value) => hataKontrol = value);
    tipList = Ctanim().MapFisTip.keys.toList();
  }

  void search(String value) {
    for(var el in listeler.listGecmisSatisModel){
      el.isExpanded = false;
    }
    if (value.isEmpty) {
      setState(() {
        tempList = listeler.listGecmisSatisModel;
      });
      return;
    }
    setState(() {
      tempList = listeler.listGecmisSatisModel
          .where((element) =>
              element.CARIADI!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AlertDialog(
          insetPadding: EdgeInsets.all(10),
          title: SizedBox(
            width: x * .8,
            child: Row(
              children: [
                const Text(
                  "Ürün Geçmiş Satış Bilgileri",
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  iconSize: x * .1,
                )
              ],
            ),
          ),
          content: hataKontrol != ""
              ? Center(child: Text(hataKontrol))
              : GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .9,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              // labelText: "Listeyi ara",
                              hintText: "Cari ismi ile arama yapabilirsiniz.",
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.amber),
                              iconColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            onChanged: (value) {
                              search(value);
                            },
                          ),
                          Ctanim.gecmisSatisHataKontrol != ""
                              ? Center(
                                  child: Text(Ctanim.gecmisSatisHataKontrol))
                              : tempList.isEmpty
                                  ? Center(
                                      child: Text('Stok Geçmişi Bulunamadı.'))
                                  : ExpansionPanelList(
                                    dividerColor: Colors.blue,
                                      expansionCallback:
                                          (panelIndex, isExpanded) {
                                        setState(() {
                                          print("panelIndex: $panelIndex");
                                          print("isExpanded: $isExpanded");
                                          print(listeler
                                              .listGecmisSatisModel.length);
                                          tempList[panelIndex].isExpanded =
                                              isExpanded;
                                        });
                                      },
                                      children: tempList.map<ExpansionPanel>(
                                          (GecmisSatisModel fis) {
                                        return ExpansionPanel(

                                            //SELAM
                                            headerBuilder:
                                                ((context, isExpanded) {
                                              return Container(
                                                // decoration: BoxDecoration( border: Border(top: BorderSide(color: Colors.pink))),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,

                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                         fis.isExpanded == true? Divider(color: Colors.red,indent: 80,thickness: 1,):Container(),
                                                 
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2.0,
                                                              bottom: 2),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                              width:
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .16,
                                                              child: const Text(
                                                                  "Tarih:",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          8,
                                                                          60,
                                                                          102),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold))),
                                                          const SizedBox(
                                                              width: 5),
                                                          SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .35,
                                                              child: Text(
                                                                  fis.TARIH
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                  ))),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2.0,
                                                              bottom: 2),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                              width:
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .16,
                                                              child: const Text(
                                                                  "Cari Adı:",
                                                                  style: TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          8,
                                                                          60,
                                                                          102),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold))),
                                                          const SizedBox(
                                                              width: 5),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .35,
                                                            child: Text(
                                                              fis.CARIADI!,
                                                              maxLines: 6,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2.0,
                                                              bottom: 2),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                              width:
                                                                  MediaQuery.of(context)
                                                                          .size
                                                                          .width *
                                                                      .16,
                                                              child: const Text(
                                                                  "Belge Tipi:",
                                                                  style: TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          8,
                                                                          60,
                                                                          102),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold))),
                                                          const SizedBox(
                                                              width: 5),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .35,
                                                            child: Text(
                                                              fis.TIPACIKLAMA!,
                                                              maxLines: 6,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2.0,
                                                              bottom: 2),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                              width:
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .16,
                                                              child: const Text(
                                                                  "Belge No:",
                                                                  style: TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          8,
                                                                          60,
                                                                          102),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold))),
                                                          const SizedBox(
                                                              width: 5),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .35,
                                                            child: Text(
                                                              fis.BELGENO!,
                                                              maxLines: 6,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2.0,
                                                              bottom: 10),
                                                      child: Row(children: [
                                                        SizedBox(
                                                            width:
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .16,
                                                            child: const Text(
                                                                "Plasiyer:",
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            8,
                                                                            60,
                                                                            102),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                        const SizedBox(
                                                            width: 5),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .35,
                                                          child: Text(
                                                            fis.PLASIYERADI!,
                                                            maxLines: 6,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                            body: Container(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                /*
                                                Divider(
                                                  color: Colors.blue,
                                                ),
                                               
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 2.0, bottom: 2),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .16,
                                                          child: const Text(
                                                              "Tarih:",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color:Color.fromARGB(255, 4, 86, 154)))),
                                                      const SizedBox(width: 5),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .35,
                                                          child: Text(
                                                              fis.TARIH
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12))),
                                                    ],
                                                  ),
                                                ),
                                                */
                                                /*
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 2.0, bottom: 2),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .16,
                                                          child: const Text(
                                                              "Cari Adı:",
                                                              style: TextStyle(
                                                                  color:
                                                                      Color.fromARGB(255, 4, 86, 154),
                                                                  fontSize: 12))),
                                                      const SizedBox(width: 5),
                                                      SizedBox(
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                .35,
                                                        child: Text(
                                                          fis.CARIADI!,
                                                          maxLines: 6,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                */
                                                /*
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 2.0, bottom: 2),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .16,
                                                          child: const Text(
                                                              "Belge Tipi:",
                                                              style: TextStyle(
                                                                  color:
                                                                     Color.fromARGB(255, 4, 86, 154),
                                                                  fontSize: 12))),
                                                      const SizedBox(width: 5),
                                                      SizedBox(
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                .35,
                                                        child: Text(
                                                          tipList[fis.TIP! - 1]
                                                              .toString(),
                                                          maxLines: 6,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
*/ /*
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 2.0, bottom: 2),
                                                  child: Row(children: [
                                                    SizedBox(
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                .16,
                                                        child: const Text(
                                                            "Belge No:",
                                                            style: TextStyle(
                                                                color:
                                                                   Color.fromARGB(255, 4, 86, 154),
                                                                fontSize: 12))),
                                                    const SizedBox(width: 5),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .35,
                                                      child:  Text(
                                                       fis.BELGENO!,
                                                        maxLines: 6,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                                */
                                                /*
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 2.0, bottom: 2),
                                                  child: Row(children: [
                                                    SizedBox(
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                .16,
                                                        child: const Text(
                                                            "Stok Kodu:",
                                                            style: TextStyle(
                                                                color:
                                                                  Color.fromARGB(255, 4, 86, 154),
                                                                fontSize: 12))),
                                                    const SizedBox(width: 5),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .35,
                                                      child: Text(
                                                        Ctanim.seciliStokKodu,
                                                        maxLines: 6,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                                */
                                                /*   Padding(
                                    padding: const EdgeInsets.only(top:2.0, bottom: 2),
                                    child: Row(
                                      children: [
                                        SizedBox(width: MediaQuery.of(context).size.width*.16,
                                          child: const  Text("Plasiyer:" ,
                                          style: TextStyle(color: Colors.blue, fontSize: 12))),
                                           const SizedBox(width: 5),
                                     SizedBox(width: MediaQuery.of(context).size.width*.35,
                                     child: const Text("", maxLines: 6,
                                                  overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12),),
                                     )
                                     ]),
                                    )*/
                                                
                                                SizedBox(
                                                  child: Row(
                                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .35,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              rowTasarim(
                                                                  "Giriş",
                                                                  fis.STOKGIRIS
                                                                      .toString(),
                                                                  textSize:
                                                                      x * .15,
                                                                  karsiTextSize:
                                                                      x * .17),
                                                              rowTasarim(
                                                                  "Çıkış",
                                                                  fis.STOKCIKIS
                                                                      .toString(),
                                                                  textSize:
                                                                      x * .15,
                                                                  karsiTextSize:
                                                                      x * .18),
                                                              rowTasarim(
                                                                  "Bakiye",
                                                                  Ctanim
                                                                      .noktadanSonraAlinacakParametreli(
                                                                    KUSURAT
                                                                        .MIKTAR,
                                                                    fis.BAKIYE!,
                                                                  ),
                                                                  textSize:
                                                                      x * .15,
                                                                  karsiTextSize:
                                                                      x * .18),
                                                              rowTasarim(
                                                                  "Birim",
                                                                  fis.BIRIM
                                                                      .toString(),
                                                                  textSize:
                                                                      x * .15,
                                                                  karsiTextSize:
                                                                      x * .18),
                                                              rowTasarim("KDV",
                                                                  "KDV" /*Ctanim. donusturMusteri(fis.fisStokListesi[0].KDVORANI.toString())*/,
                                                                  textSize:
                                                                      x * .15,
                                                                  karsiTextSize:
                                                                      x * .18),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                       VerticalDivider(
                                                        indent: 15,
                                                        endIndent: 15,
                                                        thickness: 2,
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .35,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              rowTasarim(
                                                                  "İsk. Düş. Fiyat",
                                                                  Ctanim.donusturMusteri(fis
                                                                      .KDVDAHILFIYAT
                                                                      .toString()),
                                                                  textSize:
                                                                      x * .2,
                                                                  karsiTextSize:
                                                                      x * .14),
                                                              
                                                              rowTasarim(
                                                                  "Toplam",
                                                                  Ctanim.donusturMusteri(fis
                                                                      .TOPLAM
                                                                      .toString()),
                                                                  textSize:
                                                                      x * .2,
                                                                  karsiTextSize:
                                                                      x * .14),
                                                              rowTasarim(
                                                                  "Brüt Toplam",
                                                                  Ctanim.donusturMusteri(fis
                                                                      .BRUTTOPLAM
                                                                      .toString()),
                                                                  textSize:
                                                                      x * .2,
                                                                  karsiTextSize:
                                                                      x * .14,
                                                                  maxLines: 3),
                                                              rowTasarim(
                                                                  "Net Fiyat",
                                                                  Ctanim.donusturMusteri(fis
                                                                      .NETFIYAT
                                                                      .toString()),
                                                                  textSize:
                                                                      x * .2,
                                                                  karsiTextSize:
                                                                      x * .14),
                                                              rowTasarim(
                                                                  "Brüt Fiyat",
                                                                  Ctanim.donusturMusteri(fis
                                                                      .BRUTFIYAT
                                                                      .toString()),
                                                                  textSize:
                                                                      x * .2,
                                                                  karsiTextSize:
                                                                      x * .14),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                Divider(color: Colors.red,thickness: 1,)
                                              ],
                                            )),
                                            isExpanded: fis.isExpanded!);
                                      }).toList(),
                                    ),
                        ],
                      ),
                    ),
                  ),
                )),
    );
  }

  Widget rowTasarim(String text, String karsiText,
      {@required double? karsiTextSize,
      @required double? textSize,
      int? maxLines}) {
    return Row(
      children: [
        SizedBox(
            width: textSize,
            child: Text(
              text + ":",
              style: TextStyle(
                  color: Color.fromARGB(255, 4, 86, 154), fontSize: 12),
            )),
        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
        SizedBox(
            width: karsiTextSize,
            child: Text(karsiText,
                maxLines: maxLines, style: TextStyle(fontSize: 12))),
      ],
    );
  }
}
