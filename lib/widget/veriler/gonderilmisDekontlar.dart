import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:opak_mobil_v2/controllers/dekontController.dart';
import 'package:opak_mobil_v2/dekontKayit/model/dekontKayitModel.dart';
import '../appbar.dart';
import '../../controllers/tahsilatController.dart';
import '../../faturaFis/fis.dart';
import '../../faturaFis/fisHareket.dart';
import '../veriler/listeler.dart';
import '../../widget/ctanim.dart';
import '../../tahsilatOdemeModel/tahsilat.dart';
import '../../tahsilatOdemeModel/tahsilatHaraket.dart';
import 'gonderilmisDekontlarDetay.dart';
import 'package:intl/intl.dart';
import '../../widget/customAlertDialog.dart';

class gonderilmisDekontlar extends StatefulWidget {
  final List<DekontKayitModel> gidenFisler;
  const gonderilmisDekontlar({super.key, required this.gidenFisler});

  @override
  State<gonderilmisDekontlar> createState() =>
      _gonderilmisDekontlarState();
}
// asd

class _gonderilmisDekontlarState
    extends State<gonderilmisDekontlar> {
  DekontController dekontEx = Get.find();
  Future<String> pickDate() async {
    DateTime? selectedDate = await showDatePicker(
      locale: const Locale('tr', 'TR'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      return formattedDate;
    } else {
      return '';
    }
  }

  bool startSecili = true;
  bool endSecili = false;
  bool isLoading = false;

  String basTar = "";
  String bitTar = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(height: 50, title: "Gönderilmiş Dekontlar"),
      body: Column(
        children: [
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.2,
                      child: ElevatedButton(
                        onPressed: () async {
                          String date = await pickDate();
                          if (date == "") return;
                          setState(() {
                            basTar = date;
                            print(basTar);
                          });
                        },
                        child: Text(
                            basTar != "" ? basTar : "Başlangıç Tarihi Seçiniz"),
                      ),
                    ),
                    SizedBox(width: 16),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.2,
                      child: ElevatedButton(
                        onPressed: () async {
                          String date = await pickDate();
                          if (date == "") return;
                          setState(() async {
                            bitTar = date;
                            print(bitTar);
                            print("bitti ara");
                            isLoading = true;
                            widget.gidenFisler.clear();
                            setState(() {});
                            List<DekontKayitModel> gidenTarihliFisler = [];
                            try {
                              gidenTarihliFisler = (await dekontEx
                                  .listTarihliGidenDekontlariGetir(
                                      basTar, bitTar)) as List<DekontKayitModel>;

                              widget.gidenFisler.addAll(gidenTarihliFisler);
                              isLoading = false;
                              setState(() {});
                            } catch (e) {
                              print(e);
                            }
                          });
                        },
                        child: Text(
                            bitTar != "" ? bitTar : "Bitiş Tarihi Seçiniz"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          isLoading == false
              ? Expanded(
                  child: widget.gidenFisler.length > 0
                      ? ListView.builder(
                          itemCount: widget.gidenFisler.length,
                          itemBuilder: (context, index) {
                           

                            DekontKayitModel fis = widget.gidenFisler[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                    title:
                                        Text(
                                          "Belge No: "+  fis.BELGE_NO!,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                       
                                    subtitle: Text(
                                      "Tarih :" + fis.TARIH!,
                                    ),
                                    trailing: IconButton(
                                            icon:
                                                Icon(Icons.arrow_right_rounded),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          gonderilmisDekontlarDetay(
                                                            fis: fis,
                                                          ))));
                                            },
                                          )
                                        
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                )
                              ],
                            );
                          },
                        )
                      : Center(
                          child: Text("Veri Bulunamadı"),
                        ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }
}
