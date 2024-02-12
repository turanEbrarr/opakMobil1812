import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:opak_mobil_v2/controllers/dekontController.dart';
import 'package:opak_mobil_v2/webservis/kurModel.dart';
import 'package:opak_mobil_v2/widget/appbar.dart';
import 'package:opak_mobil_v2/widget/cari.dart';
import 'package:opak_mobil_v2/widget/cariAltHesap.dart';
import 'package:opak_mobil_v2/widget/ctanim.dart';
import 'package:opak_mobil_v2/widget/veriler/listeler.dart';
import 'package:intl/intl.dart';

class DekontKayitHareketGiris extends StatefulWidget {
  const DekontKayitHareketGiris({super.key, required this.secilenCari});

  final Cari secilenCari;

  @override
  State<DekontKayitHareketGiris> createState() =>
      _DekontKayitHareketGirisState();
}

class _DekontKayitHareketGirisState extends State<DekontKayitHareketGiris> {
  final DekontController dekontEx = Get.find();
  Future<DateTime?> pickDate() => showDatePicker(
      locale: const Locale('tr', 'TR'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));
  List<KurModel> doviz = [];
  DateTime dateTime = DateTime.now();
  KurModel? s_doviz;
  int deger = 1;
  List<CariAltHesap> althesaplar = [];
  CariAltHesap? seciliAltHesap;
  CariAltHesap? varsayilanAltHesap;

  TextEditingController kurController = new TextEditingController();
  DateTime? vadeTarihi = DateTime.now();
  TextEditingController contBelge = TextEditingController();

  TextEditingController contBorc = TextEditingController();
  TextEditingController contDovizBorc = TextEditingController();
  TextEditingController contAlacak = TextEditingController();
  TextEditingController contDovizAlacak = TextEditingController();
  TextEditingController contAcik1 = TextEditingController();
  TextEditingController contAcik2 = TextEditingController();
  TextEditingController contAcik3 = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    althesaplar.clear();
    List<String> altListe = widget.secilenCari.ALTHESAPLAR!.split(",");
    for (var elemnt in listeler.listCariAltHesap) {
      if (altListe.contains(elemnt.ALTHESAPID.toString())) {
        althesaplar.add(elemnt);
      }
      if (elemnt.VARSAYILAN == "E") {
        varsayilanAltHesap = elemnt;
      }
    }
    if (varsayilanAltHesap != null) {
      seciliAltHesap = varsayilanAltHesap;
    } else {
      seciliAltHesap = CariAltHesap(
          KOD: "-1", ALTHESAP: "HATA", DOVIZID: 1, VARSAYILAN: "H");
      kurController.text = "VARSAYILAN ALTHESAP BULUNAMADI İŞLEM YAPILAMAZ";
    }
    if (althesaplar.isEmpty) {
      varsayilanAltHesap =
          CariAltHesap(KOD: "0", ALTHESAP: "HATA", DOVIZID: 1, VARSAYILAN: "H");
      s_doviz = listeler.listKur.first;
      kurController.text = s_doviz!.KUR.toString();
    } else {
      for (var element in listeler.listKur) {
        doviz.add(element);
        if (element.ID == varsayilanAltHesap!.DOVIZID) {
          s_doviz = element;
          kurController.text = s_doviz!.KUR.toString();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Dekont Kayıt",
        height: 50,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Alt Hesap ve Döviz :",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 17, 100, 168)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .3,
                      child: Text("Althesap :",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .6,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<CariAltHesap>(
                          value: seciliAltHesap,
                          items: althesaplar.map((CariAltHesap banka) {
                            return DropdownMenuItem<CariAltHesap>(
                              value: banka,
                              child: Text(
                                banka.ALTHESAP ?? "-",
                                style: TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (CariAltHesap? selected) {
                            setState(() {
                              seciliAltHesap = selected;
                              for (var element in listeler.listKur) {
                                if (element.ID == seciliAltHesap!.DOVIZID) {
                                  s_doviz = element;
                                  kurController.text = s_doviz!.KUR.toString();
                                }
                              }
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .1,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .3,
                      child: Text("Döviz:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .2,
                      child: Text("${s_doviz!.ACIKLAMA}"),
                      /*DropdownButtonHideUnderline(
                              child: DropdownButton<KurModel>(
                                value: s_doviz,
                                items: doviz.map((KurModel banka) {
                                  return DropdownMenuItem<KurModel>(
                                    value: banka,
                                    child: Text(
                                      banka.ACIKLAMA ?? "",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (KurModel? selected) {
                                  setState(() {
                                    s_doviz = selected;
                                  });
                                },
                              ),
                            ),
                            */
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .2,
                      child: Text("KUR :",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .2,
                      height: MediaQuery.of(context).size.height * .05,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 247, 245, 245),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          controller: kurController,
                          cursorColor: Color.fromARGB(255, 60, 59, 59),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*'))
                          ],
                          decoration: InputDecoration(
                              label: Text(
                                "",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 60, 59, 59),
                                    fontSize: 15),
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Genel Bilgiler :",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 17, 100, 168)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .1,
                child: Row(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .25,
                        child: Text("Belge No:",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: TextFormField(
                        cursorColor: Color.fromARGB(255, 30, 38, 45),
                       controller: contBelge,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 30, 38, 45))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .1,
                child: Row(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .25,
                        child: Text("Vade Tarihi:",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: ElevatedButton(
                          child: Text(
                              "${DateFormat("yyyy-MM-dd").format(DateTime.now())}"),
                          onPressed: () async {
                            DateTime? date = await pickDate();
                            if (date == null) {
                              return;
                            }
                            setState(() {
                              vadeTarihi = date;
                            });
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Borç & Alacak :",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 17, 100, 168)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .1,
                child: Row(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .25,
                        child: Text("Borç:",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: TextFormField(
                        cursorColor: Color.fromARGB(255, 30, 38, 45),
                       controller: contBorc,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 30, 38, 45))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .1,
                child: Row(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .25,
                        child: Text("Döviz Borç:",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: TextFormField(
                        cursorColor: Color.fromARGB(255, 30, 38, 45),
                        controller: contDovizBorc,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 30, 38, 45))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .1,
                child: Row(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .25,
                        child: Text("Alacak:",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: TextFormField(
                        cursorColor: Color.fromARGB(255, 30, 38, 45),
                        controller: contAlacak,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 30, 38, 45))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .1,
                child: Row(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .25,
                        child: Text("Döviz Alacak:",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: TextFormField(
                        cursorColor: Color.fromARGB(255, 30, 38, 45),
                        controller: contDovizAlacak,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 30, 38, 45))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Açıklamalar :",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 17, 100, 168)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text("Açıklama 1 :",
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  cursorColor: Color.fromARGB(255, 30, 38, 45),
                  maxLines: 5,
              controller: contAcik1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 30, 38, 45))),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text("Açıklama 2 :",
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  cursorColor: Color.fromARGB(255, 30, 38, 45),
                  maxLines: 5,
                 controller: contAcik2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 30, 38, 45))),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text("Açıklama 3 :",
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  cursorColor: Color.fromARGB(255, 30, 38, 45),
                  maxLines: 5,
             controller: contAcik3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 30, 38, 45))),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * .8,
              child: ElevatedButton.icon(
                onPressed: () async {
                  dekontEx.dekontaHaraketEkle(
                      UUID: dekontEx.dekont!.value.UUID!,
                      BELGENO: contBelge.text,
                      TARIH: dekontEx.dekont!.value.TARIH!,
                      CARIID: widget.secilenCari.ID!,
                      PERSONELID: int.tryParse(Ctanim.kullanici!.KOD!) ?? 1,
                      ACIKLAMA1: contAcik1.text,
                      ACIKLAMA2: contAcik2.text,
                      ACIKLAMA3: contAcik3.text,
                      DOVIZID: s_doviz!.ID!,
                      KUR: double.tryParse(kurController.text) ?? 1,
                      BORC: double.tryParse(contBorc.text) ?? 1,
                      ALACAK: double.tryParse(contAlacak.text) ?? 1,
                      DOVIZBORC: double.tryParse(contDovizBorc.text) ?? 1,
                      DOVIZALACAK:double.tryParse(contDovizAlacak.text) ?? 1,
                      ALTHESAPID: seciliAltHesap!.ALTHESAPID!,
                      VADETARIHI: DateFormat('yyyy-MM-dd').format(vadeTarihi!));
                },
                icon: Icon(Icons.navigate_next),
                label: Text(
                  "Ekle",
                  style: TextStyle(fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
    ;
  }
}
