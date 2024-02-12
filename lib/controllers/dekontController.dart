import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:opak_mobil_v2/dekontKayit/model/dekontKatirHarModel.dart';
import 'package:opak_mobil_v2/dekontKayit/model/dekontKayitModel.dart';

import '../../widget/ctanim.dart';

class DekontController extends GetxController {
  Rx<DekontKayitModel>? dekont = DekontKayitModel.empty().obs;
  RxList<DekontKayitModel> list_dekont = <DekontKayitModel>[].obs;
  RxList<DekontKayitModel> list_dekont_gidecek = <DekontKayitModel>[].obs;
  RxList<DekontKayitModel> list_dekont_giden = <DekontKayitModel>[].obs;
  RxList<DekontKayitModel> list_dekont_kaydedilen = <DekontKayitModel>[].obs;

  void dekontaHaraketEkle({
    required String UUID,
    required String BELGENO,
    required String TARIH,
    required int CARIID,
    required int PERSONELID,
    required String ACIKLAMA1,
    required String ACIKLAMA2,
    required String ACIKLAMA3,
    required int DOVIZID,
    required double KUR,
    required double BORC,
    required double ALACAK,
    required double DOVIZBORC,
    required double DOVIZALACAK,
    required int ALTHESAPID,
    required String VADETARIHI,
  }) {
    DekontKayitHarModel eklenecek = DekontKayitHarModel.empty();
      eklenecek.UUID= UUID;
      eklenecek.BELGENO= BELGENO;
      eklenecek.TARIH= TARIH;
      eklenecek.CARIID= CARIID;
     eklenecek. PERSONELID= PERSONELID;
     eklenecek. ACIKLAMA1= ACIKLAMA1;
     eklenecek. ACIKLAMA2= ACIKLAMA2;
     eklenecek. ACIKLAMA3= ACIKLAMA3;
     eklenecek. DOVIZID= DOVIZID;
     eklenecek. KUR= KUR;
     eklenecek. BORC= BORC;
     eklenecek. ALACAK= ALACAK;
     eklenecek. DOVIZBORC= DOVIZBORC;
     eklenecek. DOVIZALACAK= DOVIZALACAK;
     eklenecek. ALTHESAPID= ALTHESAPID;
     eklenecek. VADETARIHI= VADETARIHI;

    /*
    DekontKayitHarModel dekontHaraket = DekontKayitHarModel(
      UUID: UUID,
      BELGENO: BELGENO,
      TARIH: TARIH,
      CARIID: CARIID,
      PERSONELID: PERSONELID,
      ACIKLAMA1: ACIKLAMA1,
      ACIKLAMA2: ACIKLAMA2,
      ACIKLAMA3: ACIKLAMA3,
      DOVIZID: DOVIZID,
      KUR: KUR,
      BORC: BORC,
      ALACAK: ALACAK,
      DOVIZBORC: DOVIZBORC,
      DOVIZALACAK: DOVIZALACAK,
      ALTHESAPID: ALTHESAPID,
      VADETARIHI: VADETARIHI,
    );
    */

    dekont!.value.dekontKayitList!.add(eklenecek);
  }

  Future<List<DekontKayitModel>> getdekont( ) async {
    List<Map<String, dynamic>> result = await Ctanim.db
        ?.query("TBLMAHSUPSB", where: 'DURUM = ? ', whereArgs: [false]);
    List<DekontKayitModel> tt1 = List.generate(
        result.length, (i) => DekontKayitModel.fromJson(result[i]));
    return tt1;
  }

  Future<List<DekontKayitHarModel>> getdekontHar(int mahsupId) async {
    List<Map<String, dynamic>> result = await Ctanim.db
        ?.query("TBLMAHSUPHARSB", where: 'MAHSUPID = ? ', whereArgs: [mahsupId]);
    List<DekontKayitHarModel> tt1 = List.generate(
        result.length, (i) => DekontKayitHarModel.fromJson(result[i]));
    return tt1;
  }

  Future<void> listDekontGetir() async {
    List<DekontKayitModel> tt = [];
    getdekont().then((value) {
      tt = value;
      tt.forEach((element) {
        getdekontHar(element.ID!)
            .then((value) => element.dekontKayitList = value);
      });
      list_dekont.assignAll(tt);
    });
  }

  Future<List<DekontKayitModel>> getGidecekDekont(String belgeTip) async {
    List<Map<String, dynamic>> result = await Ctanim.db?.query("TBLMAHSUPSB",
        where: 'DURUM = ?  AND AKTARILDIMI = ?', whereArgs: [true, false]);
    return List<DekontKayitModel>.from(
        result.map((json) => DekontKayitModel.fromJson(json)).toList());
  }

  Future<void> listGidecekDekontGetir({required String belgeTip}) async {
    List<DekontKayitModel> tt = await getGidecekDekont(belgeTip);
    for (var i = 0; i < tt.length; i++) {
      var element = tt[i];
      List<DekontKayitHarModel> dekontHar = await getdekontHar(element.ID!);
      element.dekontKayitList = dekontHar;
    }
    list_dekont_gidecek.addAll(tt);
  }

  Future<List<DekontKayitModel>> getGidenDekont() async {
    List<Map<String, dynamic>> result = await Ctanim.db?.query("TBLMAHSUPSB",
        where: 'AKTARILDIMI = ?',
        whereArgs: [true],
        limit: 50,
        orderBy: 'ID DESC');
    List<DekontKayitModel> gidenDekont = List.generate(
        result.length, (i) => DekontKayitModel.fromJson(result[i]));
    return gidenDekont;
  }

  Future<RxList<DekontKayitModel>> listGidenDekontleriGetir() async {
    List<DekontKayitModel> tt = await getGidenDekont();

    await Future.forEach(tt, (element) async {
      List<DekontKayitHarModel> dekontHarList = await getdekontHar(element.ID!);
      element.dekontKayitList = dekontHarList;
    });

    list_dekont_giden.assignAll(tt);
    return list_dekont_giden;
  }

  Future<List<DekontKayitModel>> getKaydedilmisDekont() async {
    List<Map<String, dynamic>> result = await Ctanim.db?.query("TBLMAHSUPSB",
        where: 'DURUM = ? AND AKTARILDIMI = ?',
        whereArgs: [true, false],
        limit: 50,
        orderBy: 'ID DESC');
    List<DekontKayitModel> gidenDekont = List.generate(
        result.length, (i) => DekontKayitModel.fromJson(result[i]));
    return gidenDekont;
  }

  Future<RxList<DekontKayitModel>> listKaydedilmisDekontlariGetir() async {
    List<DekontKayitModel> tt = await getKaydedilmisDekont();
    await Future.forEach(tt, (element) async {
      List<DekontKayitHarModel> dekontHarList = await getdekontHar(element.ID!);
      element.dekontKayitList = dekontHarList;
    });

    list_dekont_kaydedilen.assignAll(tt);
    return list_dekont_kaydedilen;
  }
    Future<void> listGidecekTekDekontGetir(
      {required int fisID}) async {
    list_dekont_gidecek.clear();
    List<DekontKayitModel> tt = await getGidecekTekDekont(fisID);
    for (var i = 0; i < tt.length; i++) {
      var element = tt[i];
      List<DekontKayitHarModel> fisHar = await getdekontHar(element.ID!);
      element.dekontKayitList = fisHar;
     
    
    }
    list_dekont_gidecek.addAll(tt);
  }

  Future<List<DekontKayitModel>> getGidecekTekDekont( int fisID) async {
    List<Map<String, dynamic>> result = await Ctanim.db?.query("TBLMAHSUPSB",
        where: 'ID = ?',
        whereArgs: [
          fisID
        ]); // doprudan fiş ıd veriyosun diğer bakılacaklara gerek yok ki
    return List<DekontKayitModel>.from(result.map((json) => DekontKayitModel.fromJson(json)).toList());
  }



}