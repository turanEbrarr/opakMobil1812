import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opak_mobil_v2/controllers/dekontController.dart';
import 'package:opak_mobil_v2/dekontKayit/dekontKayitCariSec.dart';
import 'package:opak_mobil_v2/dekontKayit/dekontKayitHareketListe.dart';
import 'package:opak_mobil_v2/dekontKayit/model/dekontKayitModel.dart';
import 'package:opak_mobil_v2/genel_belge.dart/genel_belge_tab_urun_ara.dart';
import 'package:opak_mobil_v2/webservis/stokFiyatListesiModel.dart';
import 'package:opak_mobil_v2/widget/appbar.dart';
import 'package:opak_mobil_v2/widget/cari.dart';
import '../faturaFis/fis.dart';
import '../widget/ctanim.dart';
import '../webservis/satisTipiModel.dart';

class DekontKayitTab extends StatefulWidget {
  const DekontKayitTab({
    super.key,

  });

  @override
  State<DekontKayitTab> createState() => _DekontKayitTabState();
}

class _DekontKayitTabState extends State<DekontKayitTab> {
  final DekontController dekontEx = Get.find();

   void dispose() {
    print("DİSPOSE GELDİK");
    if(dekontEx.dekont!.value.BELGE_NO != ""){
       DekontKayitModel.empty().dekontEkle(dekont: dekontEx.dekont!.value,);
    dekontEx.dekont!.value = DekontKayitModel.empty();

    }
   
    super.dispose();
  }

  Color tab1 = Colors.amber;
  Color tab2 = Colors.white;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MyAppBar(
            height: 50, title: "Dekont Kayıt"),
        body: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height / 10),
              child: Material(
                color: Color.fromARGB(255, 66, 82, 97),
                child: TabBar(
                  labelColor: Colors.amber,
                  unselectedLabelColor: Colors.white,
                  onTap: (value) {
                    setState(() {
                      if (value == 0) {
                        tab1 = Colors.amber;
                        tab2 = Colors.white;
                      } else if (value == 1) {
                        tab2 = Colors.amber;
                        tab1 = Colors.white;
                        } 
          
                    });
                  },
                  tabs: [
                    Tab(
                      text: ("Cari Seç"),
                      icon: Icon(
                        Icons.search,
                        color: tab1,
                      ),
                    ),
                    Tab(
                      text: ("Liste"),
                      icon: Icon(
                        Icons.list,
                        color: tab2,
                      ),
                    ),
                 
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                 DekontKayitCariSec(),
                  DekontKayitListe(),
                 
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
