import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:opak_mobil_v2/controllers/dekontController.dart';
import 'package:opak_mobil_v2/dekontKayit/dekontTab.dart';
import 'package:opak_mobil_v2/widget/appbar.dart';
import 'package:opak_mobil_v2/widget/customAlertDialog.dart';
import 'package:uuid/uuid.dart';

import '../widget/ctanim.dart';

class IslemTipi {
  int? ID;
  String? ADI;
  IslemTipi({required this.ADI, required this.ID});
}

class DekontKayitUstBilgi extends StatefulWidget {
  const DekontKayitUstBilgi({
    super.key,
  });

  @override
  State<DekontKayitUstBilgi> createState() => _DekontKayitUstBilgiState();
}

class _DekontKayitUstBilgiState extends State<DekontKayitUstBilgi> {
  final DekontController dekontEx = Get.find();
  DateTime? dekontTarihi = DateTime.now();
  TextEditingController contSeri = TextEditingController();
  TextEditingController contBelge = TextEditingController();
  TextEditingController contAcik1 = TextEditingController();
  TextEditingController contAcik2 = TextEditingController();
  TextEditingController contAcik3 = TextEditingController();

  List<IslemTipi> islemTipiList = [
    IslemTipi(ADI: "Normal", ID: 0),
    IslemTipi(ADI: "Açık", ID: 1)
  ];
  IslemTipi? seciliIslemTipi;
  var uuid = Uuid();

  Future<DateTime?> pickDate() => showDatePicker(
      locale: const Locale('tr', 'TR'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seciliIslemTipi = islemTipiList[0];
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
                        child: Text("İşlem Tipi:",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<IslemTipi>(
                          value: seciliIslemTipi,
                          items: islemTipiList.map((IslemTipi banka) {
                            return DropdownMenuItem<IslemTipi>(
                              value: banka,
                              child: Text(
                                banka.ADI ?? "",
                                style: TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (IslemTipi? selected) {
                            setState(() {
                              seciliIslemTipi = selected;
                            });
                          },
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
                        child: Text("Dekont Tarihi:",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: ElevatedButton(
                          child: Text(
                              "${DateFormat("yyyy-MM-dd").format(dekontTarihi!)}"),
                          onPressed: () async {
                            DateTime? date = await pickDate();
                            if (date == null) {
                              return;
                            }
                            setState(() {
                              dekontTarihi = date;
                            });
                          }),
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
                        child: Text("*Seri No:",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: TextFormField(
                        cursorColor: Color.fromARGB(255, 30, 38, 45),
                        controller: contSeri,
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
                        child: Text("*Belge No:",
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
                    "Açıklamalar:",
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
                  if (contSeri.text != "" && contBelge.text != "") {
                    dekontEx.dekont!.value!.ISLEMTIPI = seciliIslemTipi!.ID;
                    dekontEx.dekont!.value.TARIH =
                        DateFormat('yyyy-MM-dd').format(dekontTarihi!);
                    dekontEx.dekont!.value.SERI = contSeri.text;
                    dekontEx.dekont!.value.BELGE_NO = contBelge.text;
                    dekontEx.dekont!.value.ACIKLAMA1 = contAcik1.text;
                    dekontEx.dekont!.value.ACIKLAMA2 = contAcik2.text;
                    dekontEx.dekont!.value.ACIKLAMA3 = contAcik3.text;
                    dekontEx.dekont!.value.PLASIYERID = int.tryParse(Ctanim.kullanici!.KOD!) ?? 0; //  DEĞİŞ
                    dekontEx.dekont!.value.SUBEID =
                        int.parse(Ctanim.kullanici!.YERELSUBEID!.toString());
                    dekontEx.dekont!.value.UUID = uuid.v1();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DekontKayitTab()));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CustomAlertDialog(
                            align: TextAlign.left,
                            title: 'Uyarı!',
                            message:
                                'Dekont kayıtda seri numarası ve belge numarası boş bırakılamaz.',
                            onPres: () async {
                              Navigator.pop(context);
                            },
                            buttonText: 'Geri',
                          );
                        });
                  }
                },
                icon: Icon(Icons.navigate_next),
                label: Text(
                  "Devam Et",
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
  }
}
