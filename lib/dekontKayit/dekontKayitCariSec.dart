import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:opak_mobil_v2/cari_kart/yeni_cari_olustur.dart';
import 'package:opak_mobil_v2/controllers/cariController.dart';
import 'package:opak_mobil_v2/controllers/dekontController.dart';
import 'package:opak_mobil_v2/controllers/fisController.dart';
import 'package:opak_mobil_v2/dekontKayit/dekontKayitHareketGiris.dart';
import 'package:opak_mobil_v2/genel_belge.dart/genel_belge_tab_page.dart';
import 'package:opak_mobil_v2/webservis/base.dart';
import 'package:opak_mobil_v2/webservis/satisTipiModel.dart';
import 'package:opak_mobil_v2/webservis/stokFiyatListesiModel.dart';

import 'package:opak_mobil_v2/widget/appbar.dart';
import 'package:opak_mobil_v2/widget/veriler/listeler.dart';
import '../widget/cari.dart';
import '../widget/ctanim.dart';
import 'package:uuid/uuid.dart';

class DekontKayitCariSec extends StatefulWidget {
  const DekontKayitCariSec({
    super.key,
  });

  @override
  State<DekontKayitCariSec> createState() => _DekontKayitCariSecState();
}

class _DekontKayitCariSecState extends State<DekontKayitCariSec> {
  BaseService bs = BaseService();

  var uuid = Uuid();
  final CariController cariEx = Get.find();
  TextEditingController editController = TextEditingController();

  final DekontController dekontEx = Get.find();

  Color randomColor() {
    Random random = Random();
    int red = random.nextInt(128); // 0-127 arasında rastgele bir değer
    int green = random.nextInt(128);
    int blue = random.nextInt(128);
    return Color.fromARGB(255, red, green, blue);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (listeler.listSatisTipiModel.isNotEmpty) {
      Ctanim.seciliIslemTip = listeler.listSatisTipiModel.first;
    } else {
      Ctanim.seciliIslemTip =
          SatisTipiModel(ID: -1, TIP: "", FIYATTIP: "", ISK1: "", ISK2: "");
    }
    if (listeler.listStokFiyatListesi.isNotEmpty) {
      Ctanim.seciliStokFiyatListesi = listeler.listStokFiyatListesi.first;
    } else {
      Ctanim.seciliStokFiyatListesi = StokFiyatListesiModel(ADI: "", ID: -1);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cariEx.searchCari("");
  }

  @override
  Widget build(BuildContext context) {
    print("A" + Ctanim.seciliIslemTip!.TIP!);

    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_arrow,
        backgroundColor: Color.fromARGB(255, 30, 38, 45),
        buttonSize: Size(65, 65),
        children: [
          SpeedDialChild(
              backgroundColor: Color.fromARGB(255, 70, 89, 105),
              child: Icon(
                Icons.add,
                color: Colors.green,
                size: 32,
              ),
              label: "Yeni Cari Oluştur",
              onTap: () {
                Get.to(const yeni_cari_olustur());
              }),
          SpeedDialChild(
              backgroundColor: Color.fromARGB(255, 70, 89, 105),
              child: Icon(
                Icons.refresh,
                color: Colors.amber,
                size: 32,
              ),
              label: "Carilerimi Güncelle",
              onTap: () async {
                await cariEx.servisCariGetir();
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 247, 245, 245),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(),
                          ),
                          child: TextFormField(
                            onChanged: (value) => cariEx.searchCari(value),
                            cursorColor: Color.fromARGB(255, 60, 59, 59),
                            decoration: InputDecoration(
                                icon: Icon(Icons.search),
                                iconColor: Color.fromARGB(255, 60, 59, 59),
                                hintText: "Cari Adı / Cari Kodu / İl",
                                border: InputBorder.none),
                          )),
                    ),
                  ),
                  /*
                  Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: Image.asset("images/slider.png",
                            height: 60, width: 60),
                      )),
                      */
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .8,
              child: Obx(() => ListView.builder(
                    itemCount: cariEx.searchCariList.length,
                    itemBuilder: (context, index) {
                      Cari cariKart = cariEx.searchCariList[index];

                      String trim = cariKart.ADI!.trim();
                      String harf1 = "";
                      String harf2 = "";
                      if (trim.length > 0) {
                        harf1 = trim[0];
                        if (trim.length == 1) {
                          harf2 = "K";
                        } else {
                          harf2 = trim[1];
                        }
                      } else {
                        harf1 = "A";
                        harf2 = "B";
                      }

                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5, top: 1, bottom: 1),
                        child: Column(
                          children: [
                            Container(
                              // color: Colors.grey[100],
                              color: Colors.blue[70],
                              child: Column(
                                children: [
                                  ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: randomColor(),
                                        child: Text(
                                          harf1 + harf2,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      title: Text(
                                        cariKart.ADI!,
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(cariKart.IL.toString()),
                                      ),
                                      trailing: Text(Ctanim.donusturMusteri(
                                              cariKart.BAKIYE.toString()) +
                                          " ₺"),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    DekontKayitHareketGiris(secilenCari: cariKart,))));
                                      }),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            )
                          ],
                        ),
                      );
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
