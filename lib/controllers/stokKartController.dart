import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:opak_mobil_v2/webservis/satisTipiModel.dart';
import 'package:opak_mobil_v2/webservis/stokFiyatListesiModel.dart';
import 'package:opak_mobil_v2/widget/cari.dart';
import 'package:opak_mobil_v2/widget/ctanim.dart';
import 'package:opak_mobil_v2/widget/modeller/sharedPreferences.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../localDB/veritabaniIslemleri.dart';
import '../main.dart';
import '../widget/veriler/listeler.dart';
import '../stok_kart/stok_tanim.dart';
import '../webservis/base.dart';

class StokKartController extends GetxController {
  RxList<StokKart> searchList = <StokKart>[].obs;
  RxList<StokKart> tempList = <StokKart>[].obs;

  // RxList<StokKart> stoklar = stoklar.obs;
  BaseService bs = BaseService();
  VeriIslemleri veriislemi = VeriIslemleri();

  @override
  void onInit() {
    super.onInit();
  }

/*  void sepetGuncellenenStok(int index, double iskonto, String fiyat) {
    var stokKart = searchList[index];

    stokKart.SATISISK = iskonto;
    stokKart.SFIYAT1 = double.parse(fiyat);
    update();
  }*/

  List<dynamic> fiyatgetir(StokKart Stok, String CariKod, String _FiyatTip,
      SatisTipiModel satisTipi, StokFiyatListesiModel stokFiyatListesi) {
    bool fiyatDegistirsinMi = false;
    if (Ctanim.kullanici!.FIYATDEGISTIRILSIN == "E") {
      fiyatDegistirsinMi = true;
    }

    String Fiyattip = _FiyatTip;
    double kosulYoksaTekrarDonecek = 0.0;
    Cari seciliCari = Cari();
    double iskontoDegeri = 0;
    for (var cari in listeler.listCari) {
      if (cari.KOD == CariKod) {
        seciliCari = cari;
      }
    }

    Fiyattip = Fiyattip;
    String seciliFiyat = "";
    double kosuldanDonenFiyat = 0.0;
    if (CariKod != '') {
      if (satisTipi.ID != -1) {
        double iskonto = 0.0;
        if (satisTipi.ISK1 == "S.Açıklama 1") {
          iskonto = double.parse(Stok.SACIKLAMA1.toString());
        } else if (satisTipi.ISK1 == "S.Açıklama 2") {
          iskonto = double.parse(Stok.SACIKLAMA2.toString());
        } else if (satisTipi.ISK1 == "S.Açıklama 3") {
          iskonto = double.parse(Stok.SACIKLAMA3.toString());
        } else if (satisTipi.ISK1 == "S.Açıklama 4") {
          iskonto = double.parse(Stok.SACIKLAMA4.toString());
        } else if (satisTipi.ISK1 == "S.Açıklama 5") {
          iskonto = double.parse(Stok.SACIKLAMA5.toString());
        } else if (satisTipi.ISK1 == "S Fiyat 1") {
          iskonto = double.parse(Stok.SFIYAT1.toString());
        } else if (satisTipi.ISK1 == "S Fiyat 2") {
          iskonto = double.parse(Stok.SFIYAT2.toString());
        } else if (satisTipi.ISK1 == "S Fiyat 3") {
          iskonto = double.parse(Stok.SFIYAT3.toString());
        } else if (satisTipi.ISK1 == "S Fiyat 4") {
          iskonto = double.parse(Stok.SFIYAT4.toString());
        } else if (satisTipi.ISK1 == "S Fiyat 5") {
          iskonto = double.parse(Stok.SFIYAT5.toString());
        } else if (satisTipi.ISK1 == "A Fiyat 1") {
          iskonto = double.parse(Stok.AFIYAT1.toString());
        } else if (satisTipi.ISK1 == "A Fiyat 2") {
          iskonto = double.parse(Stok.AFIYAT2.toString());
        } else if (satisTipi.ISK1 == "A Fiyat 3") {
          iskonto = double.parse(Stok.AFIYAT3.toString());
        } else if (satisTipi.ISK1 == "A Fiyat 4") {
          iskonto = double.parse(Stok.AFIYAT4.toString());
        } else if (satisTipi.ISK1 == "A Fiyat 5") {
          iskonto = double.parse(Stok.AFIYAT5.toString());
        } else if (satisTipi.ISK1 == "Satış İsk.") {
          iskonto = double.parse(Stok.SATISISK.toString());
        } else if (satisTipi.ISK1 == "Alış İsk.") {
          iskonto = double.parse(Stok.ALISISK.toString());
        }
        double fiyat = 0.0;
        if (satisTipi.FIYATTIP == "S.Açıklama 1") {
          fiyat = double.parse(Stok.SACIKLAMA1.toString());
        } else if (satisTipi.FIYATTIP == "S.Açıklama 2") {
          fiyat = double.parse(Stok.SACIKLAMA2.toString());
        } else if (satisTipi.FIYATTIP == "S.Açıklama 3") {
          fiyat = double.parse(Stok.SACIKLAMA3.toString());
        } else if (satisTipi.FIYATTIP == "S.Açıklama 4") {
          fiyat = double.parse(Stok.SACIKLAMA4.toString());
        } else if (satisTipi.FIYATTIP == "S.Açıklama 5") {
          fiyat = double.parse(Stok.SACIKLAMA5.toString());
        } else if (satisTipi.FIYATTIP == "S Fiyat 1") {
          fiyat = double.parse(Stok.SFIYAT1.toString());
        } else if (satisTipi.FIYATTIP == "S Fiyat 2") {
          fiyat = double.parse(Stok.SFIYAT2.toString());
        } else if (satisTipi.FIYATTIP == "S Fiyat 3") {
          fiyat = double.parse(Stok.SFIYAT3.toString());
        } else if (satisTipi.FIYATTIP == "S Fiyat 4") {
          fiyat = double.parse(Stok.SFIYAT4.toString());
        } else if (satisTipi.FIYATTIP == "S Fiyat 5") {
          fiyat = double.parse(Stok.SFIYAT5.toString());
        } else if (satisTipi.FIYATTIP == "A Fiyat 1") {
          fiyat = double.parse(Stok.AFIYAT1.toString());
        } else if (satisTipi.FIYATTIP == "A Fiyat 2") {
          fiyat = double.parse(Stok.AFIYAT2.toString());
        } else if (satisTipi.FIYATTIP == "A Fiyat 3") {
          fiyat = double.parse(Stok.AFIYAT3.toString());
        } else if (satisTipi.FIYATTIP == "A Fiyat 4") {
          fiyat = double.parse(Stok.AFIYAT4.toString());
        } else if (satisTipi.FIYATTIP == "A Fiyat 5") {
          fiyat = double.parse(Stok.AFIYAT5.toString());
        } else if (satisTipi.FIYATTIP == "Satış İsk.") {
          fiyat = double.parse(Stok.SATISISK.toString());
        } else if (satisTipi.FIYATTIP == "Alış İsk.") {
          fiyat = double.parse(Stok.ALISISK.toString());
        }

        return [fiyat, iskonto, Ctanim.seciliIslemTip.TIP, false];
      } else {
        if (Ctanim.kullanici!.SATISTIPI == "0") {
          StokKart ff = searchList.where((p0) => p0.KOD == Stok.KOD).first;

          if (Fiyattip == 'Fiyat1') {
            kosulYoksaTekrarDonecek == ff.SFIYAT1;
            //double iskonto = iskontoGetir(Stok.KOD, CariKod);
            return [ff.SFIYAT1, ff.SATISISK, "Fiyat1", true];
          } else if (Fiyattip == 'Fiyat2') {
            // iskontoGetir(Stok.KOD, CariKod);
            kosulYoksaTekrarDonecek == ff.SFIYAT2;
            // double iskonto = iskontoGetir(Stok.KOD, CariKod);
            return [ff.SFIYAT2, ff.SATISISK, "Fiyat2", true];
          } else if (Fiyattip == 'Fiyat3') {
            // iskontoGetir(Stok.KOD, CariKod);
            kosulYoksaTekrarDonecek == ff.SFIYAT3;
            // double iskonto = iskontoGetir(Stok.KOD, CariKod);
            return [ff.SFIYAT3, ff.SATISISK, "Fiyat3", true];
          } else if (Fiyattip == 'Fiyat4') {
            // iskontoGetir(Stok.KOD, CariKod);
            kosulYoksaTekrarDonecek == ff.SFIYAT4;
            //double iskonto = iskontoGetir(Stok.KOD, CariKod);
            return [ff.SFIYAT4, ff.SATISISK, "Fiyat4", true];
          } else if (Fiyattip == 'Fiyat5') {
            // iskontoGetir(Stok.KOD, CariKod);
            kosulYoksaTekrarDonecek == ff.SFIYAT5;
            //double iskonto = iskontoGetir(Stok.KOD, CariKod);
            return [ff.SFIYAT5, ff.SATISISK, "Fiyat5", true];
          } else {
            //double iskonto = iskontoGetir(Stok.KOD, CariKod);
            kosulYoksaTekrarDonecek == 0.0;
            return [0.0, ff.SATISISK, Fiyattip, true];
          }
        } else if (Ctanim.kullanici!.SATISTIPI == "1") {
          // opak kosul
          for (var element in listeler.listStokKosul) {
            if (element.KOSULID == seciliCari.KOSULID &&
                element.GRUPKODU == Stok.KOSULGRUP_KODU) {
              // stok kosul var
              if (element.ISK1 != 0) {
                iskontoDegeri = element.ISK1!;
              } else if (element.ISK2 != 0) {
                iskontoDegeri = element.ISK2!;
              } else if (element.ISK3 != 0) {
                iskontoDegeri = element.ISK3!;
              } else if (element.ISK4 != 0) {
                iskontoDegeri = element.ISK4!;
              } else if (element.ISK5 != 0) {
                iskontoDegeri = element.ISK5!;
              } else if (element.ISK6 != 0) {
                iskontoDegeri = element.ISK6!;
              }

              if (element.FIYAT == 1) {
                kosuldanDonenFiyat = Stok.SFIYAT1!;
                seciliFiyat = "Fiyat1";
              } else if (element.FIYAT == 2) {
                seciliFiyat = "Fiyat2";
                kosuldanDonenFiyat = Stok.SFIYAT2!;
              } else if (element.FIYAT == 3) {
                seciliFiyat = "Fiyat3";
                kosuldanDonenFiyat = Stok.SFIYAT3!;
              } else if (element.FIYAT == 4) {
                seciliFiyat = "Fiyat4";
                kosuldanDonenFiyat = Stok.SFIYAT4!;
              } else if (element.FIYAT == 5) {
                seciliFiyat = "Fiyat5";
                kosuldanDonenFiyat = Stok.SFIYAT5!;
              }
              /*
              double iskonto = iskontoGetir(
                Stok.KOD,
                seciliCari.KOD!,
                isk1: element.ISK1!,
                isk2: element.ISK2!,
                isk3: element.ISK3!,
                isk4: element.ISK4!,
                isk5: element.ISK5!,
                isk6: element.ISK6!,
              );
              */
              return [kosuldanDonenFiyat, iskontoDegeri, seciliFiyat, false];
            } else {
              kosuldanDonenFiyat = 0;
            }
          }
          if (kosuldanDonenFiyat == 0) {
            for (var element in listeler.listCariKosul) {
              if (element.CARIKOD == seciliCari.KOD &&
                  element.GRUPKODU == Stok.GRUP_KODU) {
                // cari kosul var
                if (element.ISK1 != 0) {
                  iskontoDegeri = element.ISK1!;
                } else if (element.ISK2 != 0) {
                  iskontoDegeri = element.ISK2!;
                } else if (element.ISK3 != 0) {
                  iskontoDegeri = element.ISK3!;
                } else if (element.ISK4 != 0) {
                  iskontoDegeri = element.ISK4!;
                } else if (element.ISK5 != 0) {
                  iskontoDegeri = element.ISK5!;
                } else if (element.ISK6 != 0) {
                  iskontoDegeri = element.ISK6!;
                }

                if (element.FIYAT == 1) {
                  seciliFiyat = "Fiyat1";
                  kosuldanDonenFiyat = Stok.SFIYAT1!;
                } else if (element.FIYAT == 2) {
                  seciliFiyat = "Fiyat2";
                  kosuldanDonenFiyat = Stok.SFIYAT2!;
                } else if (element.FIYAT == 3) {
                  seciliFiyat = "Fiyat3";
                  kosuldanDonenFiyat = Stok.SFIYAT3!;
                } else if (element.FIYAT == 4) {
                  seciliFiyat = "Fiyat4";
                  kosuldanDonenFiyat = Stok.SFIYAT4!;
                } else if (element.FIYAT == 5) {
                  seciliFiyat = "Fiyat5";
                  kosuldanDonenFiyat = Stok.SFIYAT5!;
                }
                /*
                double iskonto = iskontoGetir(
                  Stok.KOD,
                  seciliCari.KOD!,
                  isk1: element.ISK1!,
                  isk2: element.ISK2!,
                  isk3: element.ISK3!,
                  isk4: element.ISK4!,
                  isk5: element.ISK5!,
                  isk6: element.ISK6!,
                );
                */
                return [kosuldanDonenFiyat, iskontoDegeri, seciliFiyat, false];
              } else {
                kosuldanDonenFiyat = 0;
              }
            }
          }
          if (kosuldanDonenFiyat == 0) {
            for (var element in listeler.listCariStokKosul) {
              if (element.CARIKOD == seciliCari.KOD &&
                  element.STOKKOD == Stok.KOD) {
                // caristok kosul var
                if (element.ISK1 != 0) {
                  iskontoDegeri = element.ISK1!;
                } else if (element.ISK2 != 0) {
                  iskontoDegeri = element.ISK2!;
                }
                if (element.FIYAT == 1) {
                  seciliFiyat = "Fiyat1";
                  kosuldanDonenFiyat = Stok.SFIYAT1!;
                } else if (element.FIYAT == 2) {
                  seciliFiyat = "Fiyat2";
                  kosuldanDonenFiyat = Stok.SFIYAT2!;
                } else if (element.FIYAT == 3) {
                  seciliFiyat = "Fiyat3";
                  kosuldanDonenFiyat = Stok.SFIYAT3!;
                } else if (element.FIYAT == 4) {
                  seciliFiyat = "Fiyat4";
                  kosuldanDonenFiyat = Stok.SFIYAT4!;
                } else if (element.FIYAT == 5) {
                  seciliFiyat = "Fiyat5";
                  kosuldanDonenFiyat = Stok.SFIYAT5!;
                }
                /*
                double iskonto = iskontoGetir(
                  Stok.KOD,
                  seciliCari.KOD!,
                  isk1: element.ISK1!,
                  isk2: element.ISK2!,
                );
                */
                return [kosuldanDonenFiyat, iskontoDegeri, seciliFiyat, false];
              } else {
                kosuldanDonenFiyat = 0;
              }
            }
          }
        } else if (Ctanim.kullanici!.SATISTIPI == "2") {
          String fiyatTipSon = "";
          double sonFiyat = 0.0;
          if(seciliCari.FIYAT == 1){
            sonFiyat = Stok.SFIYAT1!;
            fiyatTipSon = "Fiyat1";

          }else if (seciliCari.FIYAT == 2){
            sonFiyat = Stok.SFIYAT2!;
            fiyatTipSon = "Fiyat2";

          }else if (seciliCari.FIYAT == 3){
            sonFiyat = Stok.SFIYAT3!;
            fiyatTipSon = "Fiyat3";

          }else if (seciliCari.FIYAT == 4){
            sonFiyat = Stok.SFIYAT4!;
            fiyatTipSon = "Fiyat4";

          }else if (seciliCari.FIYAT == 5){
            sonFiyat = Stok.SFIYAT5!;
            fiyatTipSon = "Fiyat5";
          }else{
            sonFiyat = 0.0;
            fiyatTipSon = "Fiyat1";
          }
          return [sonFiyat, Stok.SATISISK, fiyatTipSon, false];
        } else if (Ctanim.kullanici!.SATISTIPI == "3") {
          if (Ctanim.seciliStokFiyatListesi.ID != -1) {
            for (var element in listeler.listStokFiyatListesiHar) {
              if (Ctanim.seciliStokFiyatListesi.ID == element.USTID &&
                  element.STOKKOD == Stok.KOD) {
                return [
                  element.FIYAT,
                  element.ISK1,
                  Ctanim.seciliStokFiyatListesi.ADI,
                  false
                ];
              }
            }
            StokKart ff = searchList.where((p0) => p0.KOD == Stok.KOD).first;

            if (Fiyattip == 'Fiyat1') {
              kosulYoksaTekrarDonecek == ff.SFIYAT1;
              //double iskonto = iskontoGetir(Stok.KOD, CariKod);
              return [ff.SFIYAT1, ff.SATISISK, "Fiyat1", true];
            } else if (Fiyattip == 'Fiyat2') {
              // iskontoGetir(Stok.KOD, CariKod);
              kosulYoksaTekrarDonecek == ff.SFIYAT2;
              // double iskonto = iskontoGetir(Stok.KOD, CariKod);
              return [ff.SFIYAT2, ff.SATISISK, "Fiyat2", true];
            } else if (Fiyattip == 'Fiyat3') {
              // iskontoGetir(Stok.KOD, CariKod);
              kosulYoksaTekrarDonecek == ff.SFIYAT3;
              // double iskonto = iskontoGetir(Stok.KOD, CariKod);
              return [ff.SFIYAT3, ff.SATISISK, "Fiyat3", true];
            } else if (Fiyattip == 'Fiyat4') {
              // iskontoGetir(Stok.KOD, CariKod);
              kosulYoksaTekrarDonecek == ff.SFIYAT4;
              //double iskonto = iskontoGetir(Stok.KOD, CariKod);
              return [ff.SFIYAT4, ff.SATISISK, "Fiyat4", true];
            } else if (Fiyattip == 'Fiyat5') {
              // iskontoGetir(Stok.KOD, CariKod);
              kosulYoksaTekrarDonecek == ff.SFIYAT5;
              //double iskonto = iskontoGetir(Stok.KOD, CariKod);
              return [ff.SFIYAT5, ff.SATISISK, "Fiyat5", true];
            } else {
              //double iskonto = iskontoGetir(Stok.KOD, CariKod);
              kosulYoksaTekrarDonecek == 0.0;
              return [0.0, ff.SATISISK, Fiyattip, true];
            }
          } else {
            StokKart ff = searchList.where((p0) => p0.KOD == Stok.KOD).first;

            if (Fiyattip == 'Fiyat1') {
              kosulYoksaTekrarDonecek == ff.SFIYAT1;
              //double iskonto = iskontoGetir(Stok.KOD, CariKod);
              return [ff.SFIYAT1, ff.SATISISK, "Fiyat1", true];
            } else if (Fiyattip == 'Fiyat2') {
              // iskontoGetir(Stok.KOD, CariKod);
              kosulYoksaTekrarDonecek == ff.SFIYAT2;
              // double iskonto = iskontoGetir(Stok.KOD, CariKod);
              return [ff.SFIYAT2, ff.SATISISK, "Fiyat2", true];
            } else if (Fiyattip == 'Fiyat3') {
              // iskontoGetir(Stok.KOD, CariKod);
              kosulYoksaTekrarDonecek == ff.SFIYAT3;
              // double iskonto = iskontoGetir(Stok.KOD, CariKod);
              return [ff.SFIYAT3, ff.SATISISK, "Fiyat3", true];
            } else if (Fiyattip == 'Fiyat4') {
              // iskontoGetir(Stok.KOD, CariKod);
              kosulYoksaTekrarDonecek == ff.SFIYAT4;
              //double iskonto = iskontoGetir(Stok.KOD, CariKod);
              return [ff.SFIYAT4, ff.SATISISK, "Fiyat4", true];
            } else if (Fiyattip == 'Fiyat5') {
              // iskontoGetir(Stok.KOD, CariKod);
              kosulYoksaTekrarDonecek == ff.SFIYAT5;
              //double iskonto = iskontoGetir(Stok.KOD, CariKod);
              return [ff.SFIYAT5, ff.SATISISK, "Fiyat5", true];
            } else {
              //double iskonto = iskontoGetir(Stok.KOD, CariKod);
              kosulYoksaTekrarDonecek == 0.0;
              return [0.0, ff.SATISISK, Fiyattip, true];
            }
          }
        }
        if (kosuldanDonenFiyat == 0) {
          if (Fiyattip == "Fiyat1") {
            return [Stok.SFIYAT1, Stok.SATISISK, _FiyatTip, true];
          } else if (Fiyattip == "Fiyat2") {
            return [Stok.SFIYAT2, Stok.SATISISK, _FiyatTip, true];
          } else if (Fiyattip == "Fiyat3") {
            return [Stok.SFIYAT3, Stok.SATISISK, _FiyatTip, true];
          } else if (Fiyattip == "Fiyat4") {
            return [Stok.SFIYAT4, Stok.SATISISK, _FiyatTip, true];
          } else if (Fiyattip == "Fiyat5") {
            return [Stok.SFIYAT5, Stok.SATISISK, _FiyatTip, true];
          }
        }
      }
      return [];
    }
    return [];
  }
/*
  double iskontoGetir(String StokKod, String CariKod,
      {double isk1 = 0,
      double isk2 = 0,
      double isk3 = 0,
      double isk4 = 0,
      double isk5 = 0,
      double isk6 = 0}) {
    StokKart ff =
        stokKartEx.searchList.where(((p0) => p0.KOD == StokKod)).first;
    return ff.SATISISK;
  }
  */
    Future<int> stokAramaFiltreCek() async {
    int value = await SharedPrefsHelper.stokAraFiltreGetir();
    print("VALUE" + value.toString());
    if (value != -1) {
     return value;
    }
    else{
      return -1;
    }
  }

  void searchB(String query) {
    if (query.isEmpty) {
      searchList.assignAll(listeler.liststok);
    } else {
      var results = listeler.liststok
          .where((value) =>
              value.ADI!.toLowerCase().contains(query.toLowerCase()) ||
              value.KOD!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      searchList.assignAll(results);
      
    }
  }

  Future<void> searchC(String query, String cariKod, String fiyatTip,
      SatisTipiModel satisTipi, StokFiyatListesiModel stokFiyatListesiModel) async {
    // QUERY BOŞSA    
    if (query.isEmpty) {
      tempList.clear();
      if (listeler.liststok.length > 100) {
        if (Ctanim.secililiMarkalarFiltre.isEmpty) {
          for (int i = 0; i < 100; i++) {
            if (cariKod == "") {
              tempList.add(listeler.liststok[i]);
            } else {
              List<dynamic> gelenFiyatVeIskonto = fiyatgetir(
                  listeler.liststok[i],
                  cariKod,
                  fiyatTip,
                  satisTipi,
                  stokFiyatListesiModel);
              listeler.liststok[i].guncelDegerler!.carpan = 1.0;
              listeler.liststok[i].guncelDegerler!.guncelBarkod =
                  listeler.liststok[i].KOD!;
              listeler.liststok[i].guncelDegerler!.fiyat =
                  double.parse(gelenFiyatVeIskonto[0].toString());
              listeler.liststok[i].guncelDegerler!.iskonto =
                  double.parse(gelenFiyatVeIskonto[1].toString());
              listeler.liststok[i].guncelDegerler!.seciliFiyati =
                  gelenFiyatVeIskonto[2].toString();
              listeler.liststok[i].guncelDegerler!.fiyatDegistirMi =
                  gelenFiyatVeIskonto[3];

              listeler.liststok[i].guncelDegerler!.netfiyat =
                  listeler.liststok[i].guncelDegerler!.hesaplaNetFiyat();
              if (!Ctanim.fiyatListesiKosul.contains(
                  listeler.liststok[i].guncelDegerler!.seciliFiyati)) {
                Ctanim.fiyatListesiKosul
                    .add(listeler.liststok[i].guncelDegerler!.seciliFiyati!);
              }

              tempList.add(listeler.liststok[i]);
            }
          }
        } else {
         tempList.clear();
            if (cariKod == "") {
               List<StokKart> results = [];
              results.addAll(listeler.liststok);
              results.removeWhere((element) =>
             !Ctanim.secililiMarkalarFiltre.contains(element.MARKA));
              tempList.assignAll(results);
            } else {
              tempList.clear();
            List<StokKart> results = [];
            results.addAll(listeler.liststok);
            results.removeWhere((element) =>
                !Ctanim.secililiMarkalarFiltre.contains(element.MARKA));

            if (results.length > 100) {
              for (int i = 0; i < 100; i++) {
                List<dynamic> gelenFiyatVeIskonto = fiyatgetir(results[i],
                    cariKod, fiyatTip, satisTipi, stokFiyatListesiModel);
                results[i].guncelDegerler!.carpan = 1.0;
                results[i].guncelDegerler!.guncelBarkod = results[i].KOD!;
                results[i].guncelDegerler!.fiyat =
                    double.parse(gelenFiyatVeIskonto[0].toString());
                results[i].guncelDegerler!.iskonto =
                    double.parse(gelenFiyatVeIskonto[1].toString());
                results[i].guncelDegerler!.seciliFiyati =
                    gelenFiyatVeIskonto[2].toString();
                results[i].guncelDegerler!.fiyatDegistirMi =
                    gelenFiyatVeIskonto[3];

                results[i].guncelDegerler!.netfiyat =
                    results[i].guncelDegerler!.hesaplaNetFiyat();
                if (!Ctanim.fiyatListesiKosul
                    .contains(results[i].guncelDegerler!.seciliFiyati)) {
                  Ctanim.fiyatListesiKosul
                      .add(results[i].guncelDegerler!.seciliFiyati!);
                }

                tempList.add(results[i]);
              }
            } else {
              for (int i = 0; i < results.length; i++) {
                List<dynamic> gelenFiyatVeIskonto = fiyatgetir(results[i],
                    cariKod, fiyatTip, satisTipi, stokFiyatListesiModel);
                results[i].guncelDegerler!.carpan = 1.0;
                results[i].guncelDegerler!.guncelBarkod = results[i].KOD!;
                results[i].guncelDegerler!.fiyat =
                    double.parse(gelenFiyatVeIskonto[0].toString());
                results[i].guncelDegerler!.iskonto =
                    double.parse(gelenFiyatVeIskonto[1].toString());
                results[i].guncelDegerler!.seciliFiyati =
                    gelenFiyatVeIskonto[2].toString();
                results[i].guncelDegerler!.fiyatDegistirMi =
                    gelenFiyatVeIskonto[3];

                results[i].guncelDegerler!.netfiyat =
                    results[i].guncelDegerler!.hesaplaNetFiyat();
                if (!Ctanim.fiyatListesiKosul
                    .contains(results[i].guncelDegerler!.seciliFiyati)) {
                  Ctanim.fiyatListesiKosul
                      .add(results[i].guncelDegerler!.seciliFiyati!);
                }

                tempList.add(results[i]);
              }
            }
            }
          
        }
      } else {
        if (Ctanim.secililiMarkalarFiltre.isEmpty) {
          for (int i = 0; i < listeler.liststok.length; i++) {
            if (cariKod == "") {
              tempList.add(listeler.liststok[i]);
            } else {
              List<dynamic> gelenFiyatVeIskonto = fiyatgetir(
                  listeler.liststok[i],
                  cariKod,
                  fiyatTip,
                  satisTipi,
                  stokFiyatListesiModel);
              listeler.liststok[i].guncelDegerler!.carpan = 1.0;
              listeler.liststok[i].guncelDegerler!.guncelBarkod =
                  listeler.liststok[i].KOD!;
              listeler.liststok[i].guncelDegerler!.fiyat =
                  double.parse(gelenFiyatVeIskonto[0].toString());
              listeler.liststok[i].guncelDegerler!.iskonto =
                  double.parse(gelenFiyatVeIskonto[1].toString());
              listeler.liststok[i].guncelDegerler!.seciliFiyati =
                  gelenFiyatVeIskonto[2].toString();
              listeler.liststok[i].guncelDegerler!.fiyatDegistirMi =
                  gelenFiyatVeIskonto[3];

              listeler.liststok[i].guncelDegerler!.netfiyat =
                  listeler.liststok[i].guncelDegerler!.hesaplaNetFiyat();
              if (!Ctanim.fiyatListesiKosul.contains(
                  listeler.liststok[i].guncelDegerler!.seciliFiyati)) {
                Ctanim.fiyatListesiKosul
                    .add(listeler.liststok[i].guncelDegerler!.seciliFiyati!);
              }

              tempList.add(listeler.liststok[i]);
            }
          }
        } else {
          if (cariKod == "") {
    
              List<StokKart> results = [];
              results.addAll(listeler.liststok);
              results.removeWhere((element) =>
              !Ctanim.secililiMarkalarFiltre.contains(element.MARKA));

              tempList.assignAll(results);
            
          } else {
            tempList.clear();
            List<StokKart> results = [];
            results.addAll(listeler.liststok);
            results.removeWhere((element) =>
                !Ctanim.secililiMarkalarFiltre.contains(element.MARKA));

        
              for (int i = 0; i < results.length; i++) {
                List<dynamic> gelenFiyatVeIskonto = fiyatgetir(results[i],
                    cariKod, fiyatTip, satisTipi, stokFiyatListesiModel);
                results[i].guncelDegerler!.carpan = 1.0;
                results[i].guncelDegerler!.guncelBarkod = results[i].KOD!;
                results[i].guncelDegerler!.fiyat =
                    double.parse(gelenFiyatVeIskonto[0].toString());
                results[i].guncelDegerler!.iskonto =
                    double.parse(gelenFiyatVeIskonto[1].toString());
                results[i].guncelDegerler!.seciliFiyati =
                    gelenFiyatVeIskonto[2].toString();
                results[i].guncelDegerler!.fiyatDegistirMi =
                    gelenFiyatVeIskonto[3];

                results[i].guncelDegerler!.netfiyat =
                    results[i].guncelDegerler!.hesaplaNetFiyat();
                if (!Ctanim.fiyatListesiKosul
                    .contains(results[i].guncelDegerler!.seciliFiyati)) {
                  Ctanim.fiyatListesiKosul
                      .add(results[i].guncelDegerler!.seciliFiyati!);
                }

                tempList.add(results[i]);
              }
            
          }
        }
      }

    } 
    // QUERY DOLUYSA
    else {
      var results;
   
      List<String> queryparcali = query.split(" ");
      if (queryparcali.length == 1) {
        results = listeler.liststok
            .where((value) =>
                value.ADI!
                    .toLowerCase()
                    .contains(queryparcali[0].toLowerCase()) ||
                value.KOD!.toLowerCase().contains(query.toLowerCase()) ||
                value.MARKA!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else if (queryparcali.length == 2) {
        results = listeler.liststok
            .where((value) =>
                (value.ADI!
                        .toLowerCase()
                        .contains(queryparcali[0].toLowerCase()) &&
                    value.ADI!
                        .toLowerCase()
                        .contains(queryparcali[1].toLowerCase())) ||
                value.KOD!.toLowerCase().contains(query.toLowerCase()) ||
                value.MARKA!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else if (queryparcali.length == 3) {
        results = listeler.liststok
            .where((value) =>
                (value.ADI!
                        .toLowerCase()
                        .contains(queryparcali[0].toLowerCase()) &&
                    value.ADI!
                        .toLowerCase()
                        .contains(queryparcali[1].toLowerCase()) &&
                    value.ADI!
                        .toLowerCase()
                        .contains(queryparcali[2].toLowerCase())) ||
                value.KOD!.toLowerCase().contains(query.toLowerCase()) ||
                value.MARKA!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else if (queryparcali.length == 4) {
        results = listeler.liststok
            .where((value) =>
                (value.ADI!
                        .toLowerCase()
                        .contains(queryparcali[0].toLowerCase()) &&
                    value.ADI!
                        .toLowerCase()
                        .contains(queryparcali[1].toLowerCase()) &&
                    value.ADI!
                        .toLowerCase()
                        .contains(queryparcali[2].toLowerCase()) &&
                    value.ADI!
                        .toLowerCase()
                        .contains(queryparcali[3].toLowerCase())) ||
                value.KOD!.toLowerCase().contains(query.toLowerCase()) ||
                value.MARKA!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }

      if (results.length == 0) {
        results = listeler.liststok
            .where((value) =>
                value.BARKOD1!.toLowerCase() == query.toLowerCase())
            .toList();
        //BARKOD1 İLE BULUNURSA YAPILACAKALAR
        if (results.length > 0) {
          if (cariKod == "") {
            tempList.assignAll(results);
          } else {
            if (results[0].BARKODCARPAN1! > 1) {
              results[0].guncelDegerler!.carpan = results[0].BARKODCARPAN1!;
              results[0].guncelDegerler!.guncelBarkod = results[0].BARKOD1!;
            } else {
              results[0].guncelDegerler!.carpan = 1.0;
              results[0].guncelDegerler!.guncelBarkod = results[0].KOD!;
            }
            if (results[0].BARKODFIYAT1! > 0) {
              results[0].guncelDegerler!.guncelBarkod = results[0].BARKOD1!;
              results[0].guncelDegerler!.fiyat = results[0].BARKODFIYAT1;
              results[0].guncelDegerler!.iskonto = results[0].BARKODISK1;
              results[0].guncelDegerler!.seciliFiyati =
                  "Barkod"; // hata verebilir
            
              results[0].guncelDegerler!.fiyatDegistirMi = false;
              results[0].guncelDegerler!.netfiyat =
                  results[0].guncelDegerler!.hesaplaNetFiyat();
              if (!Ctanim.fiyatListesiKosul
                  .contains(results[0].guncelDegerler!.seciliFiyati)) {
                Ctanim.fiyatListesiKosul
                    .add(results[0].guncelDegerler!.seciliFiyati!);
              }
            } else {
              List<dynamic> gelenFiyatVeIskonto = fiyatgetir(results[0],
                  cariKod, fiyatTip, satisTipi, stokFiyatListesiModel);
              results[0].guncelDegerler!.fiyat =
                  double.parse(gelenFiyatVeIskonto[0].toString());

              results[0].guncelDegerler!.iskonto =
                  double.parse(gelenFiyatVeIskonto[1].toString());

              results[0].guncelDegerler!.seciliFiyati =
                  gelenFiyatVeIskonto[2].toString();

              results[0].guncelDegerler!.fiyatDegistirMi =
                  gelenFiyatVeIskonto[3];

              results[0].guncelDegerler!.netfiyat =
                  results[0].guncelDegerler!.hesaplaNetFiyat();

              if (!Ctanim.fiyatListesiKosul
                  .contains(results[0].guncelDegerler!.seciliFiyati)) {
                Ctanim.fiyatListesiKosul
                    .add(results[0].guncelDegerler!.seciliFiyati!);
              }
            }

            tempList.assignAll(results);
          }
        }

        if (results.length == 0) {
          results = listeler.liststok
              .where((value) =>
                  value.BARKOD2!.toLowerCase() == query.toLowerCase())
              .toList();
          //BARKOD2 İLE BULUNURSA YAPILACAKALAR
          if (results.length > 0) {
            if (cariKod == "") {
              tempList.assignAll(results);
            } else {
              if (results[0].BARKODCARPAN2! > 1) {
                results[0].guncelDegerler!.carpan = results[0].BARKODCARPAN2!;
                results[0].guncelDegerler!.guncelBarkod = results[0].BARKOD2!;
              } else {
                results[0].guncelDegerler!.carpan = 1.0;
                results[0].guncelDegerler!.guncelBarkod = results[0].KOD!;
              }
              if (results[0].BARKODFIYAT2! > 0) {
                results[0].guncelDegerler!.guncelBarkod = results[0].BARKOD2!;
                results[0].guncelDegerler!.fiyat = results[0].BARKODFIYAT2;
                results[0].guncelDegerler!.iskonto = results[0].BARKODISK2;
                results[0].guncelDegerler!.seciliFiyati =
                    "Barkod"; // hata verebilir
                results[0].guncelDegerler!.fiyatDegistirMi = false;
                results[0].guncelDegerler!.netfiyat =
                    results[0].guncelDegerler!.hesaplaNetFiyat();
                if (!Ctanim.fiyatListesiKosul
                    .contains(results[0].guncelDegerler!.seciliFiyati)) {
                  Ctanim.fiyatListesiKosul
                      .add(results[0].guncelDegerler!.seciliFiyati!);
                }
              } else {
                List<dynamic> gelenFiyatVeIskonto = fiyatgetir(results[0],
                    cariKod, fiyatTip, satisTipi, stokFiyatListesiModel);
                results[0].guncelDegerler!.fiyat =
                    double.parse(gelenFiyatVeIskonto[0].toString());

                results[0].guncelDegerler!.iskonto =
                    double.parse(gelenFiyatVeIskonto[1].toString());

                results[0].guncelDegerler!.seciliFiyati =
                    gelenFiyatVeIskonto[2].toString();

                results[0].guncelDegerler!.fiyatDegistirMi =
                    gelenFiyatVeIskonto[3];

                results[0].guncelDegerler!.netfiyat =
                    results[0].guncelDegerler!.hesaplaNetFiyat();

                if (!Ctanim.fiyatListesiKosul
                    .contains(results[0].guncelDegerler!.seciliFiyati)) {
                  Ctanim.fiyatListesiKosul
                      .add(results[0].guncelDegerler!.seciliFiyati!);
                }
              }

              tempList.assignAll(results);
            }
          }
        }
        if (results.length == 0) {
          results = listeler.liststok
              .where((value) =>
                  value.BARKOD3!.toLowerCase() == query.toLowerCase())
              .toList();
          //BARKOD3 İLE BULUNURSA YAPILACAKALAR
          if (results.length > 0) {
            if (cariKod == "") {
              tempList.assignAll(results);
            } else {
              if (results[0].BARKODCARPAN3! > 1) {
                results[0].guncelDegerler!.carpan = results[0].BARKODCARPAN3!;
                results[0].guncelDegerler!.guncelBarkod = results[0].BARKOD3!;
              } else {
                results[0].guncelDegerler!.carpan = 1.0;
                results[0].guncelDegerler!.guncelBarkod = results[0].KOD!;
              }
              if (results[0].BARKODFIYAT3! > 0) {
                results[0].guncelDegerler!.guncelBarkod = results[0].BARKOD3!;
                results[0].guncelDegerler!.fiyat = results[0].BARKODFIYAT3;
                results[0].guncelDegerler!.iskonto = results[0].BARKODISK3;
                results[0].guncelDegerler!.seciliFiyati =
                    "Barkod"; // hata verebilir
                results[0].guncelDegerler!.fiyatDegistirMi = false;
                results[0].guncelDegerler!.netfiyat =
                    results[0].guncelDegerler!.hesaplaNetFiyat();
                if (!Ctanim.fiyatListesiKosul
                    .contains(results[0].guncelDegerler!.seciliFiyati)) {
                  Ctanim.fiyatListesiKosul
                      .add(results[0].guncelDegerler!.seciliFiyati!);
                }
              } else {
                List<dynamic> gelenFiyatVeIskonto = fiyatgetir(results[0],
                    cariKod, fiyatTip, satisTipi, stokFiyatListesiModel);
                results[0].guncelDegerler!.fiyat =
                    double.parse(gelenFiyatVeIskonto[0].toString());

                results[0].guncelDegerler!.iskonto =
                    double.parse(gelenFiyatVeIskonto[1].toString());

                results[0].guncelDegerler!.seciliFiyati =
                    gelenFiyatVeIskonto[2].toString();

                results[0].guncelDegerler!.fiyatDegistirMi =
                    gelenFiyatVeIskonto[3];

                results[0].guncelDegerler!.netfiyat =
                    results[0].guncelDegerler!.hesaplaNetFiyat();

                if (!Ctanim.fiyatListesiKosul
                    .contains(results[0].guncelDegerler!.seciliFiyati)) {
                  Ctanim.fiyatListesiKosul
                      .add(results[0].guncelDegerler!.seciliFiyati!);
                }
              }

              tempList.assignAll(results);
            }
          }
        }

        if (results.length == 0) {
          results = listeler.liststok
              .where((value) =>
                  value.BARKOD4!.toLowerCase() == query.toLowerCase())
              .toList();
          //BARKOD4 İLE BULUNURSA YAPILACAKALAR
          if (results.length > 0) {
            if (cariKod == "") {
              tempList.assignAll(results);
            } else {
              if (results[0].BARKODCARPAN4! > 1) {
                results[0].guncelDegerler!.carpan = results[0].BARKODCARPAN4!;
                results[0].guncelDegerler!.guncelBarkod = results[0].BARKOD4!;
              } else {
                results[0].guncelDegerler!.carpan = 1.0;
                results[0].guncelDegerler!.guncelBarkod = results[0].KOD!;
              }
              if (results[0].BARKODFIYAT4! > 0) {
                results[0].guncelDegerler!.guncelBarkod = results[0].BARKOD4!;
                results[0].guncelDegerler!.fiyat = results[0].BARKODFIYAT4;
                results[0].guncelDegerler!.iskonto = results[0].BARKODISK4;
                results[0].guncelDegerler!.seciliFiyati =
                    "Barkod"; // hata verebilir
                results[0].guncelDegerler!.fiyatDegistirMi = false;
                results[0].guncelDegerler!.netfiyat =
                    results[0].guncelDegerler!.hesaplaNetFiyat();
                if (!Ctanim.fiyatListesiKosul
                    .contains(results[0].guncelDegerler!.seciliFiyati)) {
                  Ctanim.fiyatListesiKosul
                      .add(results[0].guncelDegerler!.seciliFiyati!);
                }
              } else {
                List<dynamic> gelenFiyatVeIskonto = fiyatgetir(results[0],
                    cariKod, fiyatTip, satisTipi, stokFiyatListesiModel);
                results[0].guncelDegerler!.fiyat =
                    double.parse(gelenFiyatVeIskonto[0].toString());

                results[0].guncelDegerler!.iskonto =
                    double.parse(gelenFiyatVeIskonto[1].toString());

                results[0].guncelDegerler!.seciliFiyati =
                    gelenFiyatVeIskonto[2].toString();

                results[0].guncelDegerler!.fiyatDegistirMi =
                    gelenFiyatVeIskonto[3];

                results[0].guncelDegerler!.netfiyat =
                    results[0].guncelDegerler!.hesaplaNetFiyat();

                if (!Ctanim.fiyatListesiKosul
                    .contains(results[0].guncelDegerler!.seciliFiyati)) {
                  Ctanim.fiyatListesiKosul
                      .add(results[0].guncelDegerler!.seciliFiyati!);
                }
              }

              tempList.assignAll(results);
            }
          }
        }

        if (results.length == 0) {
          results = listeler.liststok
              .where((value) =>
                  value.BARKOD5!.toLowerCase() == query.toLowerCase())
              .toList();
          //BARKOD5 İLE BULUNURSA YAPILACAKALAR
          if (results.length > 0) {
            if (cariKod == "") {
              tempList.assignAll(results);
            } else {
              if (results[0].BARKODCARPAN5! > 1) {
                results[0].guncelDegerler!.carpan = results[0].BARKODCARPAN5!;
                results[0].guncelDegerler!.guncelBarkod = results[0].BARKOD5!;
              } else {
                results[0].guncelDegerler!.carpan = 1.0;
                results[0].guncelDegerler!.guncelBarkod = results[0].KOD!;
              }
              if (results[0].BARKODFIYAT5! > 0) {
                results[0].guncelDegerler!.guncelBarkod = results[0].BARKOD5!;
                results[0].guncelDegerler!.fiyat = results[0].BARKODFIYAT5;
                results[0].guncelDegerler!.iskonto = results[0].BARKODISK5;
                results[0].guncelDegerler!.seciliFiyati =
                    "Barkod"; // hata verebilir
                results[0].guncelDegerler!.fiyatDegistirMi = false;
                results[0].guncelDegerler!.netfiyat =
                    results[0].guncelDegerler!.hesaplaNetFiyat();
                if (!Ctanim.fiyatListesiKosul
                    .contains(results[0].guncelDegerler!.seciliFiyati)) {
                  Ctanim.fiyatListesiKosul
                      .add(results[0].guncelDegerler!.seciliFiyati!);
                }
              } else {
                List<dynamic> gelenFiyatVeIskonto = fiyatgetir(results[0],
                    cariKod, fiyatTip, satisTipi, stokFiyatListesiModel);
                results[0].guncelDegerler!.fiyat =
                    double.parse(gelenFiyatVeIskonto[0].toString());

                results[0].guncelDegerler!.iskonto =
                    double.parse(gelenFiyatVeIskonto[1].toString());

                results[0].guncelDegerler!.seciliFiyati =
                    gelenFiyatVeIskonto[2].toString();

                results[0].guncelDegerler!.fiyatDegistirMi =
                    gelenFiyatVeIskonto[3];

                results[0].guncelDegerler!.netfiyat =
                    results[0].guncelDegerler!.hesaplaNetFiyat();

                if (!Ctanim.fiyatListesiKosul
                    .contains(results[0].guncelDegerler!.seciliFiyati)) {
                  Ctanim.fiyatListesiKosul
                      .add(results[0].guncelDegerler!.seciliFiyati!);
                }
              }

              tempList.assignAll(results);
            }
          }
        }

        if (results.length == 0) {
          results = listeler.liststok
              .where((value) =>
                  value.BARKOD6!.toLowerCase() == query.toLowerCase())
              .toList();
          //BARKO6 İLE BULUNURSA YAPILACAKALAR
          if (results.length > 0) {
            if (cariKod == "") {
              tempList.assignAll(results);
            } else {
              if (results[0].BARKODCARPAN6! > 1) {
                results[0].guncelDegerler!.carpan = results[0].BARKODCARPAN6!;
                results[0].guncelDegerler!.guncelBarkod = results[0].BARKOD6!;
              } else {
                results[0].guncelDegerler!.carpan = 1.0;
                results[0].guncelDegerler!.guncelBarkod = results[0].KOD!;
              }
              if (results[0].BARKODFIYAT6! > 0) {
                results[0].guncelDegerler!.guncelBarkod = results[0].BARKOD6!;
                results[0].guncelDegerler!.fiyat = results[0].BARKODFIYAT6;
                results[0].guncelDegerler!.iskonto = results[0].BARKODISK6;
                results[0].guncelDegerler!.seciliFiyati =
                    "Barkod"; // hata verebilir
                results[0].guncelDegerler!.fiyatDegistirMi = false;
                results[0].guncelDegerler!.netfiyat =
                    results[0].guncelDegerler!.hesaplaNetFiyat();
                if (!Ctanim.fiyatListesiKosul
                    .contains(results[0].guncelDegerler!.seciliFiyati)) {
                  Ctanim.fiyatListesiKosul
                      .add(results[0].guncelDegerler!.seciliFiyati!);
                }
              } else {
                List<dynamic> gelenFiyatVeIskonto = fiyatgetir(results[0],
                    cariKod, fiyatTip, satisTipi, stokFiyatListesiModel);
                results[0].guncelDegerler!.fiyat =
                    double.parse(gelenFiyatVeIskonto[0].toString());

                results[0].guncelDegerler!.iskonto =
                    double.parse(gelenFiyatVeIskonto[1].toString());

                results[0].guncelDegerler!.seciliFiyati =
                    gelenFiyatVeIskonto[2].toString();

                results[0].guncelDegerler!.fiyatDegistirMi =
                    gelenFiyatVeIskonto[3];

                results[0].guncelDegerler!.netfiyat =
                    results[0].guncelDegerler!.hesaplaNetFiyat();

                if (!Ctanim.fiyatListesiKosul
                    .contains(results[0].guncelDegerler!.seciliFiyati)) {
                  Ctanim.fiyatListesiKosul
                      .add(results[0].guncelDegerler!.seciliFiyati!);
                }
              }

              tempList.assignAll(results);
            }
          }
        }
        if (results.length == 0) {
          //BURDA KALDIK
          var bul = listeler.listDahaFazlaBarkod
              .where((element) => element.BARKOD == query)
              .toList();
          if (bul.length > 0) {
            var sonBulunan = listeler.liststok
                .where((element) => element.KOD == bul[0].KOD)
                .toList();

            if (sonBulunan.length > 0) {
              if (cariKod == "") {
                tempList.assignAll(sonBulunan);
              } else {
                sonBulunan[0].guncelDegerler!.carpan = bul[0].CARPAN;
                sonBulunan[0].guncelDegerler!.guncelBarkod = bul[0].KOD;

                List<dynamic> gelenFiyatVeIskonto = fiyatgetir(sonBulunan[0],
                    cariKod, fiyatTip, satisTipi, stokFiyatListesiModel);
                sonBulunan[0].guncelDegerler!.fiyat =
                    double.parse(gelenFiyatVeIskonto[0].toString());
                sonBulunan[0].guncelDegerler!.iskonto =
                    double.parse(gelenFiyatVeIskonto[1].toString());
                sonBulunan[0].guncelDegerler!.seciliFiyati =
                    gelenFiyatVeIskonto[2].toString();
                sonBulunan[0].guncelDegerler!.fiyatDegistirMi =
                    gelenFiyatVeIskonto[3];
                sonBulunan[0].BARKODCARPAN1 = bul[0].CARPAN;
                sonBulunan[0].guncelDegerler!.netfiyat =
                    sonBulunan[0].guncelDegerler!.hesaplaNetFiyat();
                if (!Ctanim.fiyatListesiKosul
                    .contains(sonBulunan[0].guncelDegerler!.seciliFiyati)) {
                  Ctanim.fiyatListesiKosul
                      .add(sonBulunan[0].guncelDegerler!.seciliFiyati!);
                }

                tempList.assignAll(sonBulunan);
              }
            }
          }
        }
      } 
      else if (results.length > 100) {
        if (cariKod == "") {
          if (Ctanim.secililiMarkalarFiltre.isEmpty) {
            tempList.assignAll(results);
          } else {
            results.removeWhere((element) =>
                !Ctanim.secililiMarkalarFiltre.contains(element.MARKA));
            tempList.assignAll(results);
          }
        } else {
          if (Ctanim.secililiMarkalarFiltre.isEmpty) {
            for (int i = 0; i < 100; i++) {
              List<dynamic> gelenFiyatVeIskonto = fiyatgetir(results[i],
                  cariKod, fiyatTip, satisTipi, stokFiyatListesiModel);
              results[i].guncelDegerler!.carpan = 1.0;
              results[i].guncelDegerler!.guncelBarkod = results[i].KOD!;
              results[i].guncelDegerler!.fiyat =
                  double.parse(gelenFiyatVeIskonto[0].toString());
              results[i].guncelDegerler!.iskonto =
                  double.parse(gelenFiyatVeIskonto[1].toString());
              results[i].guncelDegerler!.seciliFiyati =
                  gelenFiyatVeIskonto[2].toString();
              results[i].guncelDegerler!.fiyatDegistirMi =
                  gelenFiyatVeIskonto[3];

              results[i].guncelDegerler!.netfiyat =
                  results[i].guncelDegerler!.hesaplaNetFiyat();
              if (!Ctanim.fiyatListesiKosul
                  .contains(results[i].guncelDegerler!.seciliFiyati)) {
                Ctanim.fiyatListesiKosul
                    .add(results[i].guncelDegerler!.seciliFiyati!);
              }
            }
            tempList.assignAll(results);
          } else {
            int sayac = 0;
            List<StokKart> results2 = [];
            for (var element in results) {
              if (Ctanim.secililiMarkalarFiltre.contains(element.MARKA)) {
                if (sayac < 100) {
                  sayac++;
                  results2.add(element);
                } else {
                  break;
                }
              }
            }
         
              for (int i = 0; i < results2.length; i++) {
                List<dynamic> gelenFiyatVeIskonto = fiyatgetir(results2[i],
                    cariKod, fiyatTip, satisTipi, stokFiyatListesiModel);
                results2[i].guncelDegerler!.carpan = 1.0;
                results2[i].guncelDegerler!.guncelBarkod = results2[i].KOD!;
                results2[i].guncelDegerler!.fiyat =
                    double.parse(gelenFiyatVeIskonto[0].toString());
                results2[i].guncelDegerler!.iskonto =
                    double.parse(gelenFiyatVeIskonto[1].toString());
                results2[i].guncelDegerler!.seciliFiyati =
                    gelenFiyatVeIskonto[2].toString();
                results2[i].guncelDegerler!.fiyatDegistirMi =
                    gelenFiyatVeIskonto[3];

                results2[i].guncelDegerler!.netfiyat =
                    results2[i].guncelDegerler!.hesaplaNetFiyat();
                if (!Ctanim.fiyatListesiKosul
                    .contains(results2[i].guncelDegerler!.seciliFiyati)) {
                  Ctanim.fiyatListesiKosul
                      .add(results2[i].guncelDegerler!.seciliFiyati!);
                }
              }
              tempList.assignAll(results2);
            
          }
        }
      } else {
        if (cariKod == "") {
          if (Ctanim.secililiMarkalarFiltre.isEmpty) {
            tempList.assignAll(results);
          } else {
            results.removeWhere((element) =>
                !Ctanim.secililiMarkalarFiltre.contains(element.MARKA));

            tempList.assignAll(results);
          }
        } else {
          if (Ctanim.secililiMarkalarFiltre.isEmpty) {
            for (int i = 0; i < results.length; i++) {
              List<dynamic> gelenFiyatVeIskonto = fiyatgetir(results[i],
                  cariKod, fiyatTip, satisTipi, stokFiyatListesiModel);
              results[i].guncelDegerler!.carpan = 1.0;
              results[i].guncelDegerler!.guncelBarkod = results[i].KOD!;
              results[i].guncelDegerler!.fiyat =
                  double.parse(gelenFiyatVeIskonto[0].toString());
              results[i].guncelDegerler!.iskonto =
                  double.parse(gelenFiyatVeIskonto[1].toString());
              results[i].guncelDegerler!.seciliFiyati =
                  gelenFiyatVeIskonto[2].toString();
              results[i].guncelDegerler!.fiyatDegistirMi =
                  gelenFiyatVeIskonto[3];

              results[i].guncelDegerler!.netfiyat =
                  results[i].guncelDegerler!.hesaplaNetFiyat();
              if (!Ctanim.fiyatListesiKosul
                  .contains(results[i].guncelDegerler!.seciliFiyati)) {
                Ctanim.fiyatListesiKosul
                    .add(results[i].guncelDegerler!.seciliFiyati!);
              }
            }
            tempList.assignAll(results);
          } else {
            List<StokKart> result2 = [];

            for (int i = 0; i < results.length; i++) {
              if (Ctanim.secililiMarkalarFiltre
                  .any((item) => item == results[i].MARKA)) {
                result2.add(results[i]);
              }
            }
            for (int i = 0; i < result2.length; i++) {
              List<dynamic> gelenFiyatVeIskonto = fiyatgetir(result2[i],
                  cariKod, fiyatTip, satisTipi, stokFiyatListesiModel);
              result2[i].guncelDegerler!.carpan = 1.0;
              result2[i].guncelDegerler!.guncelBarkod = result2[i].KOD!;
              result2[i].guncelDegerler!.fiyat =
                  double.parse(gelenFiyatVeIskonto[0].toString());
              result2[i].guncelDegerler!.iskonto =
                  double.parse(gelenFiyatVeIskonto[1].toString());
              result2[i].guncelDegerler!.seciliFiyati =
                  gelenFiyatVeIskonto[2].toString();
              result2[i].guncelDegerler!.fiyatDegistirMi =
                  gelenFiyatVeIskonto[3];

              result2[i].guncelDegerler!.netfiyat =
                  result2[i].guncelDegerler!.hesaplaNetFiyat();
              if (!Ctanim.fiyatListesiKosul
                  .contains(result2[i].guncelDegerler!.seciliFiyati)) {
                Ctanim.fiyatListesiKosul
                    .add(result2[i].guncelDegerler!.seciliFiyati!);
              }
            }
            tempList.assignAll(result2);
          }
        }
      }
    }
    List<StokKart> tempTempStok = [];
    tempTempStok.addAll(tempList); 
    int sonuc = await stokAramaFiltreCek();  
    
          if (sonuc == 1) {
    
        stokKartEx.tempList.sort((a, b) => b.BAKIYE!.compareTo(a.BAKIYE!));
      
      } else if (sonuc == 2) {
        stokKartEx.tempList..sort((a, b) => a.BAKIYE!.compareTo(b.BAKIYE!));
      } else if (sonuc == 3) {
   
  stokKartEx.tempList.clear();
                        stokKartEx.tempList.addAll(tempTempStok);
                        stokKartEx.tempList
                            .removeWhere((cari) => cari.BAKIYE! >= 0);
      } else if (sonuc == 4) {
  stokKartEx.tempList.clear();
                        stokKartEx.tempList.addAll(tempTempStok);
                        stokKartEx.tempList
                            .removeWhere((cari) => cari.BAKIYE! < 0);
      }else{
        print("-1 GELDİ FİLTRELEMEDE"+tempList.length.toString());
      }
  }

  Future aToZSort() async {
    Comparator<StokKart> sirala =
        (a, b) => a.ADI!.toLowerCase().compareTo(b.ADI!.toLowerCase());
    listeler.liststok.sort(sirala);
  }

//servisten stokları günceller
  Future<String> servisStokGetir() async {
    if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
      print("internet yok");
      const snackBar = SnackBar(
        content: Text(
          'İnternet bağlantısı yok.',
          style: TextStyle(fontSize: 16),
        ),
        showCloseIcon: true,
        backgroundColor: Colors.blue,
        closeIconColor: Colors.white,
      );
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
      return "İnternet bağlantısı yok.";
    } else {
      if (Ctanim.db == null) {
        const snackBar = SnackBar(
          content: Text(
            'Veritabanı bağlantısı başarısız.',
            style: TextStyle(fontSize: 16),
          ),
          showCloseIcon: true,
          backgroundColor: Colors.blue,
          closeIconColor: Colors.white,
        );
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
        return 'Veritabanı bağlantısı başarısız.';
      } else {
        String don = await bs.getirStoklar(
            kullaniciKodu: Ctanim.kullanici!.KOD, sirket: Ctanim.sirket!);
        return don;
      }
    }
  }
}
