import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:opak_mobil_v2/controllers/dekontController.dart';
import 'package:opak_mobil_v2/controllers/fisController.dart';
import 'package:opak_mobil_v2/controllers/stokKartController.dart';
import 'package:opak_mobil_v2/dekontKayit/model/dekontKatirHarModel.dart';
import 'package:opak_mobil_v2/dekontKayit/model/dekontKayitModel.dart';
import 'package:opak_mobil_v2/faturaFis/fisHareket.dart';
import 'package:opak_mobil_v2/genel_belge.dart/genel_belge_stok_kart_guncelleme.dart';
import 'package:opak_mobil_v2/stok_kart/stok_tanim.dart';
import 'package:opak_mobil_v2/widget/veriler/listeler.dart';
import '../faturaFis/fis.dart';
import '../localDB/veritabaniIslemleri.dart';
import '../widget/ctanim.dart';

class DekontKayitListe extends StatefulWidget {
  const DekontKayitListe({
    super.key,
  });

  @override
  State<DekontKayitListe> createState() =>
      _DekontKayitListeState();
}

class _DekontKayitListeState
    extends State<DekontKayitListe> {
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
  fisEx.toplam_iskonto.value =0.0;
    fisEx.fis!.value.fisStokListesi.forEach((element) {
     fisEx.toplam_iskonto = (fisEx.toplam_iskonto + ( element.ISK!.toDouble())) as RxDouble;
    });
}*/

/*void araToplamHesapla () {
  fisEx.toplam
}*/

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    double y = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0, top: 4.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .95,
             // height: MediaQuery.of(context).size.height * .07,
              child: TextField(
                controller: editingController,
                decoration: const InputDecoration(
                  // labelText: "Listeyi ara",
                  hintText: "Sepette ara (Ad/Kod/Barkod)",
                  prefixIcon: Icon(Icons.search, color: Colors.black),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onChanged: ((value) => setState(() {})),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Obx(
                () => ListView.builder(
                    itemCount: dekontEx.dekont?.value.dekontKayitList!.length,
                    itemBuilder: (context, index) {
                      DekontKayitHarModel? fishareket =
                          dekontEx.dekont!.value.dekontKayitList![index];
         
                        return urunListeWidget(
                            y, x, fishareket, context, index);
                      
                    }),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .05,
            color: Color.fromARGB(255, 66, 82, 97),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 60),
                  child: Text(
                    "TOPLAM : ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                    "top",
                    style: const TextStyle(color: Colors.white)),
                Spacer(),
                const Text(
                  "SATIR-ADET : ",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 60),
                    child: Text(
                      "sata",
                      style: const TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding urunListeWidget(double y, double x, DekontKayitHarModel? fishareket,
      BuildContext context, int index) {
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
                          child: Text("Ürün Kodu:",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700))),
                      Padding(
                        padding: EdgeInsets.only(left: x * .05),
                        child: SizedBox(
                            width: x * .4,
                            child: Text(
                              maxLines: 2,
                              fishareket!.BELGENO.toString(),
                              style: TextStyle(fontWeight: FontWeight.w700),
                            )),
                      ),
                      IconButton(
                          onPressed: () {
                            bottomSheetUrunListe(
                                context, fishareket,index);
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
                          child: Text("Ürün Adı",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700))),
                      Padding(
                        padding: EdgeInsets.only(left: x * .1),
                        child: SizedBox(
                            width: x * .5,
                            child: Text(
                              fishareket.BELGENO.toString(),
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
                                  "Miktar :",
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
                                  child: Text("Fiyat    :",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500))),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: x * .05),
                              child: SizedBox(
                                  width: x * .15,
                                  child: Text("İSK       :",
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
                                   fishareket.MIKTAR!.toString(
                                                ),
                                  )),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: x * .05),
                              child: SizedBox(
                                  width: x * .15,
                                  child: Text(
                                   fishareket.MIKTAR!.toString(
                                                ),
                                  )),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: x * .05),
                              child: SizedBox(
                                width: x * .15,
                                child: 
                                     Text(
                                   fishareket.MIKTAR!.toString(
                                                ),
                                  )
                               
                              ),
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
                                  "Net Fiyat :",
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
                                  child: Text("T.Fiyat     :",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500))),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: x * .05),
                              child: SizedBox(
                                  width: x * .2,
                                  child: Text("KDV         :",
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
                                   fishareket.MIKTAR!.toString(
                                                ),
                                  )),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: x * .05),
                              child: SizedBox(
                                  width: x * .15,
                                  child: Text(
                                   fishareket.MIKTAR!.toString(
                                                ),
                                  )),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: x * .05),
                              child: SizedBox(
                                width: x * .15,
                                child: Text(
                                   fishareket.MIKTAR!.toString(
                                                ),
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

  void bottomSheetUrunListe(BuildContext context, DekontKayitHarModel fishareket,
        int index) {
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
                  dekontEx.dekont?.value.dekontKayitList!.removeWhere(
                      (item) => item.UUID == fishareket.UUID!);
                  await DekontKayitModel.empty().dekontHarSil(
                      dekontEx.dekont!.value!.ID!,);

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
