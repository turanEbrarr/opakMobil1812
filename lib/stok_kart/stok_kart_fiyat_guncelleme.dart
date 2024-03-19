import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:opak_mobil_v2/controllers/fisController.dart';
import 'package:opak_mobil_v2/controllers/stokKartController.dart';
import 'package:opak_mobil_v2/faturaFis/fisHareket.dart';
import 'package:opak_mobil_v2/stok_kart/stokDepoMode.dart';
import 'package:opak_mobil_v2/stok_kart/stok_tanim.dart';
import 'package:opak_mobil_v2/webservis/base.dart';
import 'package:opak_mobil_v2/widget/veriler/listeler.dart';
import 'package:path/path.dart';
import 'package:quantity_input/quantity_input.dart';

import '../controllers/cariController.dart';
import '../faturaFis/fis.dart';
import '../widget/ctanim.dart';

class stok_kart_fiyat_guncelle extends StatefulWidget {
  final StokKart stokKart;

  stok_kart_fiyat_guncelle({
    super.key,
    required this.stokKart,
  });

  @override
  State<stok_kart_fiyat_guncelle> createState() =>
      _stok_kart_fiyat_guncelleState();
}

class _stok_kart_fiyat_guncelleState extends State<stok_kart_fiyat_guncelle> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool readOnly = true;
  Color enableDisableColor = Colors.grey;
  String hintText = "Fiyat Seçiniz";
  String seciliFiyat = "SFIYAT1";
  List<String> fiyatlar = [
    "SFIYAT1",
    "SFIYAT2",
    "SFIYAT3",
    "SFIYAT4",
    "SFIYAT5",
  ];
  int fiyatSira = 0;
  TextEditingController fiyatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;

    double fontSize = 15.0 + (widget.stokKart.ADI!.length / 10);
    double textLenght = widget.stokKart.ADI!.length.toDouble() * 1.5;

    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      title: Row(
        children: [
          SizedBox(width: x * 0.64, child: const Text("Fiyat Güncelleme")),
          Spacer(),
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.cancel,
              color: Colors.red,
            ),
            iconSize: x * .1,
          )
        ],
      ),
      content: Container(
        height: 700,
        width: MediaQuery.of(context).size.width * .9,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(top: x * .01),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .30,
                  child: Container(
                      child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: x * .02, bottom: x * 0.05),
                        child: Text(
                          "Stok Bilgileri",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Kodu: "),
                          Text(widget.stokKart.KOD!),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Adı: "),
                            SizedBox(
                                height: textLenght,
                                width: MediaQuery.of(context).size.width * .5,
                                child: SingleChildScrollView(
                                  child: Text(
                                    style: TextStyle(fontSize: fontSize - 4),
                                    widget.stokKart.ADI!,
                                    maxLines: 5,
                                    textAlign: TextAlign.right,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Marka: "),
                          Text(widget.stokKart.MARKA!),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Birim: "),
                            Text(widget.stokKart.OLCUBIRIM1!),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Plasiyer Kodu: "),
                            Text(Ctanim.kullanici!.KOD!),
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Padding(
                padding: EdgeInsets.only(top: x * .02),
                child: Text(
                  "Mevcut Fiyat Bilgileri",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              sutunTasarim(x,
                  ilkTittle: "Satış Fiyat 1",
                  ikinciTittle: "Satış Fiyat 2",
                  ilkGosterim: widget.stokKart.SFIYAT1.toString(),
                  ikinciGosterim: widget.stokKart.SFIYAT2.toString()),
              sutunTasarim(x,
                  ilkTittle: "Satış Fiyat 3",
                  ikinciTittle: "Satış Fiyat 4",
                  ilkGosterim: widget.stokKart.SFIYAT3.toString(),
                  ikinciGosterim: widget.stokKart.SFIYAT4.toString()),
              sutunTasarim(x,
                  ilkTittle: "Satış Fiyat 5",
                  ikinciTittle: Ctanim.kullanici!.ALISFIYATGORMESIN == "H"
                      ? "Alış Fiyat 1"
                      : "-",
                  ilkGosterim: widget.stokKart.SFIYAT5.toString(),
                  ikinciGosterim: widget.stokKart.AFIYAT1.toString()),
              sutunTasarim(x,
                  ilkTittle: "Satış KDV",
                  ikinciTittle: "Alış KDV",
                  ilkGosterim: widget.stokKart.SATIS_KDV.toString(),
                  ikinciGosterim: widget.stokKart.ALIS_KDV.toString()),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: x * .02),
                  child: Column(
                    children: [
                      Divider(
                        thickness: 2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: x * .02),
                        child: Text(
                          "Fiyat Güncelle",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              buildDropdown('Değiştirmek istenen fiyat', seciliFiyat, fiyatlar,
                  (String? value) {
                setState(() {
                  if (value == "SFIYAT1") {
                    fiyatSira = 1;
                  } else if (value == "SFIYAT2") {
                    fiyatSira = 2;
                  } else if (value == "SFIYAT3") {
                    fiyatSira = 3;
                  } else if (value == "SFIYAT4") {
                    fiyatSira = 4;
                  } else if (value == "SFIYAT5") {
                    fiyatSira = 5;
                  }
                });
              }),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: fiyatController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 30, 38, 45))),
                    hintText: "Yeni Fiyat Giriniz",
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                  /*
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        //RegExp(r'^\d+\.?\d{0,2}')
                        ),
                    //FilteringTextInputFormatter.digitsOnly,
                  ],
                  */
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  maxLines: 7,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 30, 38, 45))),
                    hintText: "Açıklama",
                  ),
                  keyboardType: TextInputType.multiline,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        onPressed: () async {
                          BaseService bs = BaseService();
                          double eskiDeger = 0.0;
                          if (fiyatSira == 1) {
                            eskiDeger = widget.stokKart.SFIYAT1!;
                          } else if (fiyatSira == 2) {
                            eskiDeger = widget.stokKart.SFIYAT2!;
                          } else if (fiyatSira == 3) {
                            eskiDeger = widget.stokKart.SFIYAT3!;
                          } else if (fiyatSira == 4) {
                            eskiDeger = widget.stokKart.SFIYAT4!;
                          } else if (fiyatSira == 5) {
                            eskiDeger = widget.stokKart.SFIYAT5!;
                          }

                          double yeniDeger =
                              double.tryParse(fiyatController.text) ?? -1;
                          if (yeniDeger == -1) {
                            Get.snackbar(
                                "Hata", "Lütfen geçerli bir fiyat giriniz");
                            return;
                          } else {
                            await bs.stokFiyatGuncelle(
                              eskiDeger: eskiDeger,
                              FiyatSira: fiyatSira,
                              plasiyerKod: Ctanim.kullanici!.KOD!,
                              stokKod: widget.stokKart.KOD!,
                              sirket: Ctanim.sirket!,
                              yeniDeger: yeniDeger,
                            );
                          }
                        },
                        child: Text("Güncelle")),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Column sutunTasarim(double x,
      {required String ilkTittle, ilkGosterim, ikinciTittle, ikinciGosterim}) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: x * .03,
            left: x * .07,
          ),
          child: Container(
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: x * .3,
                  child: Text(
                    ilkTittle,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                    width: x * .05,
                    child: VerticalDivider(
                      color: Colors.blue,
                      thickness: 2,
                      indent: 10,
                    )),
                Padding(
                  padding: EdgeInsets.only(left: x * .05),
                  child: SizedBox(
                      width: x * .25,
                      child:
                          Text(ikinciTittle, style: TextStyle(fontSize: 16))),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: x * .03,
            left: x * .07,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: x * .3,
                  child: Text(ilkTittle != "-"
                      ? Ctanim.donusturMusteri(ilkGosterim)
                      : "-")),
              SizedBox(
                  width: x * .05,
                  child: Text(" ", style: TextStyle(fontSize: 17))),
              Padding(
                padding: EdgeInsets.only(left: x * .05),
                child: SizedBox(
                    width: x * .25,
                    child: Text(ikinciTittle != "-"
                        ? Ctanim.donusturMusteri(ikinciGosterim)
                        : "-")),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDropdown(String label, String? selectedValue, List<String> items,
      void Function(String?) onChanged,
      {bool degismeKapali = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        onChanged: degismeKapali == false ? onChanged : null,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
