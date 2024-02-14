import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../widget/ctanim.dart';
import 'dekontKatirHarModel.dart';

class DekontKayitModel {
  int? ID = 0;
  String? UUID = "";
  int? SUBEID = 0;
  String? TARIH = DateFormat("yyyy-MM-dd").format(DateTime.now());
  int? FISNO = 0;
  String? SERI = "";
  String? ACIKLAMA1 = "";
  String? ACIKLAMA2 = "";
  String? ACIKLAMA3 = "";
  int? PLASIYERID = 0;
  int? PROJEID = 0;
  int? MUHASEBEID = 0;
  String? TEXTYEDEK1 = "";
  String? TEXTYEDEK2 = "";
  double? SAYISALYEDEK1 = 0.0;
  double? SAYISALYEDEK2 = 0.0;
  String? TARIHYEDEK1 = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String? TARIHYEDEK2 = DateFormat("yyyy-MM-dd").format(DateTime.now());
  int? DOVIZID = 0;
  double? KUR = 0.0;
  int? KAYITTIPI = 0;
  int? ESKIID = 0;
  String? BELGE_NO = "";
  int? DONEM = 0;
  int? TIP = 0;
  int? ISLEMTIPI = 0;
  String? GUID = "";
  bool? DURUM = false;
  bool? AKTARILDIMI = false;
  List<DekontKayitHarModel>? dekontKayitList = [];

  DekontKayitModel({
    this.ID,
    this.UUID,
    this.SUBEID,
    this.TARIH,
    this.FISNO,
    this.SERI,
    this.ACIKLAMA1,
    this.ACIKLAMA2,
    this.ACIKLAMA3,
    this.PLASIYERID,
    this.PROJEID,
    this.MUHASEBEID,
    this.TEXTYEDEK1,
    this.TEXTYEDEK2,
    this.SAYISALYEDEK1,
    this.SAYISALYEDEK2,
    this.TARIHYEDEK1,
    this.TARIHYEDEK2,
    this.DOVIZID,
    this.KUR,
    this.KAYITTIPI,
    this.ESKIID,
    this.BELGE_NO,
    this.DONEM,
    this.TIP,
    this.ISLEMTIPI,
    this.GUID,
    this.AKTARILDIMI,
    this.DURUM,
  });

  DekontKayitModel.empty()
      : this(
          ID: 0,
          UUID: "",
          SUBEID: 0,
          TARIH: DateFormat("yyyy-MM-dd").format(DateTime.now()),
          FISNO: 0,
          SERI: "",
          ACIKLAMA1: "",
          ACIKLAMA2: "",
          ACIKLAMA3: "",
          PLASIYERID: 0,
          PROJEID: 0,
          MUHASEBEID: 0,
          TEXTYEDEK1: "",
          TEXTYEDEK2: "",
          SAYISALYEDEK1: 0.0,
          SAYISALYEDEK2: 0.0,
          TARIHYEDEK1: DateFormat("yyyy-MM-dd").format(DateTime.now()),
          TARIHYEDEK2: DateFormat("yyyy-MM-dd").format(DateTime.now()),
          DOVIZID: 0,
          KUR: 0.0,
          KAYITTIPI: 0,
          ESKIID: 0,
          BELGE_NO: "",
          DONEM: 0,
          TIP: 0,
          ISLEMTIPI: 0,
          GUID: "",
          AKTARILDIMI: false,
          DURUM: false,
        );

  DekontKayitModel.fromJson(Map<String, dynamic> json) {
    ID = int.parse(json['ID'].toString());
    UUID = json['UUID'];
    SUBEID = int.parse(json['SUBEID'].toString());
    TARIH = json['TARIH'];
    FISNO = int.parse(json['FISNO'].toString());
    SERI = json['SERI'];
    ACIKLAMA1 = json['ACIKLAMA1'];
    ACIKLAMA2 = json['ACIKLAMA2'];
    ACIKLAMA3 = json['ACIKLAMA3'];
    PLASIYERID = int.parse(json['PLASIYERID'].toString());
    PROJEID = int.parse(json['PROJEID'].toString());
    MUHASEBEID = int.parse(json['MUHASEBEID'].toString());
    TEXTYEDEK1 = json['TEXTYEDEK1'];
    TEXTYEDEK2 = json['TEXTYEDEK2'];
    SAYISALYEDEK1 = double.parse(json['SAYISALYEDEK1'].toString());
    SAYISALYEDEK2 = double.parse(json['SAYISALYEDEK2'].toString());
    TARIHYEDEK1 = json['TARIHYEDEK1'];
    TARIHYEDEK2 = json['TARIHYEDEK2'];
    DOVIZID = int.parse(json['DOVIZID'].toString());
    KUR = double.parse(json['KUR'].toString());
    KAYITTIPI = int.parse(json['KAYITTIPI'].toString());
    ESKIID = int.parse(json['ESKIID'].toString());
    BELGE_NO = json['BELGE_NO'];
    DONEM = int.parse(json['DONEM'].toString());
    TIP = int.parse(json['TIP'].toString());
    ISLEMTIPI = int.parse(json['ISLEMTIPI'].toString());
    GUID = json['GUID'];
    DURUM = json['DURUM'] == 0 ? false : true;
    AKTARILDIMI = json['AKTARILDIMI'] == 0 ? false : true;
    if (json['DEKONTKAYITHAR'] != null) {
      dekontKayitList = <DekontKayitHarModel>[];
      json['DEKONTKAYITHAR'].forEach((v) {
        dekontKayitList!.add(DekontKayitHarModel.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = ID;
    data['UUID'] = UUID;
    data['SUBEID'] = SUBEID;
    data['TARIH'] = TARIH;
    data['FISNO'] = FISNO;
    data['SERI'] = SERI;
    data['ACIKLAMA1'] = ACIKLAMA1;
    data['ACIKLAMA2'] = ACIKLAMA2;
    data['ACIKLAMA3'] = ACIKLAMA3;
    data['PLASIYERID'] = PLASIYERID;
    data['PROJEID'] = PROJEID;
    data['MUHASEBEID'] = MUHASEBEID;
    data['TEXTYEDEK1'] = TEXTYEDEK1;
    data['TEXTYEDEK2'] = TEXTYEDEK2;
    data['SAYISALYEDEK1'] = SAYISALYEDEK1;
    data['SAYISALYEDEK2'] = SAYISALYEDEK2;
    data['TARIHYEDEK1'] = TARIHYEDEK1;
    data['TARIHYEDEK2'] = TARIHYEDEK2;
    data['DOVIZID'] = DOVIZID;
    data['KUR'] = KUR;
    data['KAYITTIPI'] = KAYITTIPI;
    data['ESKIID'] = ESKIID;
    data['BELGE_NO'] = BELGE_NO;
    data['DONEM'] = DONEM;
    data['TIP'] = TIP;
    data['ISLEMTIPI'] = ISLEMTIPI;
    data['GUID'] = GUID;
    data['AKTARILDIMI'] = AKTARILDIMI;
    data['DURUM'] = DURUM;

    return data;
  }

  Map<String, dynamic> toJson2() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = ID;
    data['UUID'] = UUID;
    data['SUBEID'] = SUBEID;
    data['TARIH'] = TARIH;
    data['FISNO'] = FISNO;
    data['SERI'] = SERI;
    data['ACIKLAMA1'] = ACIKLAMA1;
    data['ACIKLAMA2'] = ACIKLAMA2;
    data['ACIKLAMA3'] = ACIKLAMA3;
    data['PLASIYERID'] = PLASIYERID;
    data['PROJEID'] = PROJEID;
    data['MUHASEBEID'] = MUHASEBEID;
    data['TEXTYEDEK1'] = TEXTYEDEK1;
    data['TEXTYEDEK2'] = TEXTYEDEK2;
    data['SAYISALYEDEK1'] = SAYISALYEDEK1;
    data['SAYISALYEDEK2'] = SAYISALYEDEK2;
    data['TARIHYEDEK1'] = TARIHYEDEK1;
    data['TARIHYEDEK2'] = TARIHYEDEK2;
    data['DOVIZID'] = DOVIZID;
    data['KUR'] = KUR;
    data['KAYITTIPI'] = KAYITTIPI;
    data['ESKIID'] = ESKIID;
    data['BELGE_NO'] = BELGE_NO;
    data['DONEM'] = DONEM;
    data['TIP'] = TIP;
    data['ISLEMTIPI'] = ISLEMTIPI;
    data['GUID'] = GUID;
    data['AKTARILDIMI'] = AKTARILDIMI;
    data['DURUM'] = DURUM;
    data['DEKONTKAYITHAR'] = dekontKayitList!.map((e) => e.toJson()).toList();

    return data;
  }

  Future<int?> dekontEkle({
    required DekontKayitModel dekont,
  }) async {
    
    var result;

    if (dekont.ID != 0) {
      try {
        await Ctanim.db?.update("TBLMAHSUPSB", dekont.toJson(),
            where: 'ID = ?',
            whereArgs: [dekont.ID]).then((value) => result = value);

        for (var element in dekont.dekontKayitList!) {
          if (element.ID! > 0) {
            await Ctanim.db?.update("TBLMAHSUPHARSB", element.toJson(),
                where: "ID=?", whereArgs: [element.ID]);
          } else {
            element.ID = null;
            await Ctanim.db
                ?.insert("TBLMAHSUPHARSB", element.toJson())
                .then((value) {
              return element.ID = value;
            });
            print("DEKONTA EKLENEN ID : " + element.ID.toString());
          }
        }

   

        return result;
      } on PlatformException catch (e) {
        print(e);
      }
    } else {
      print("else");
      try {
        dekont.ID = null;
        
          result = await Ctanim.db
              ?.insert("TBLMAHSUPSB", dekont.toJson())
              .then((value) => dekont.ID = value);
          print("ELse:" + dekont.ID.toString());
          for (var element in dekont.dekontKayitList!) {
            element.MAHSUPID = result;
            element.ID = null;
            int gelenID = await Ctanim.db
                ?.insert("TBLMAHSUPHARSB", element.toJson())
                .then((value) => element.ID = value);
            //!mi
            element.ID = gelenID;
          }
          return result;
     
      } on PlatformException catch (e) {
        print(e);
      }
    }
  }

  Future<void> dekontVeHareketSil(int fisId) async {
    //? mahsup hareketlerini sil
    await Ctanim.db
        ?.delete("TBLMAHSUPHARSB", where: "MAHSUPID = ?", whereArgs: [fisId]);
    //? mahsup sil
    await Ctanim.db?.delete("TBLMAHSUPSB", where: "ID = ?", whereArgs: [fisId]);
  }

  Future<int> dekontHarSil(String UUID) async {
    var result = await Ctanim.db
        ?.delete("TBLMAHSUPHARSB", where: 'UUID= ?', whereArgs: [UUID]);
    return result;
  }
}
