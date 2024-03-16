import 'package:intl/intl.dart';
class GecmisSatisModel {
  int? ID;
  String? PLASIYERID;
  String? PLASIYERADI;
  int? SUBEID;
  String? SUBEADI;
  String? TARIH =  DateFormat("yyyy-MM-dd").format(DateTime.now());
  String? VADETARIHI = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String? BELGENO;
  String? ACIKLAMA;
  double? BORC;
  double? ALACAK;
  double? BAKIYE;
  int? DOVIZID;
  String? PARA;
  double? KUR;
  String? RAPORKOD1;
  String? RAPORKOD2;
  String? RAPORKOD3;
  String? RAPORKOD4;
  String? RAPORKOD5;
  String? RAPORKOD6;
  double? DOVIZALACAK;
  double? DOVIZBORC;
  double? DOVIZBAKIYE;
  int? TIP;
  String? TIPACIKLAMA;
  int? FISID;
  int? FATURAID;
  int? MCEKID;
  int? MSENETID;
  String? FATURATIP;
  int? KCEKID;
  int? KSENETID;
  int? KASAID;
  int? BANKAID;
  int? MUHASEBEID;
  String? ACIKLAMA1;
  String? ACIKLAMA2;
  String? ACIKLAMA3;
  double? SACIKLAMA1;
  double? SACIKLAMA2;
  double? SACIKLAMA3;
  String? TEXTYEDEK1;
  String? TEXTYEDEK2;
  double? SAYISALYEDEK1;
  double? SAYISALYEDEK2;
  String? TARIHYEDEK1 = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String? TARIHYEDEK2 = DateFormat("yyyy-MM-dd").format(DateTime.now());
  int? DEVIRID;
  int? PROJEID;
  String? PROJEKODU;
  String? PROJEADI;
  int? ALTHESAPID;
  String? ALTHESAPADI;
  String? KAYITTIPI;
  String? TELEFON;
  String? CARIVADEGUNU;
  String? CARIADI;
  String? CARIKODU;
  String? ISLEMTIPI;
  String? ISLEMTIPACIKLAMA;
  int? BAKIYETIP;
  int? STOKGIRIS;
  int? STOKCIKIS;

  String? BIRIM;
  double? KDV;
  double? NETFIYAT;
  double? BRUTFIYAT;
  double? KDVDAHILFIYAT;
  double? BRUTTOPLAM;
  double? TOPLAM;
  

  bool? isExpanded = false;

  GecmisSatisModel(
      {this.ID,
      this.PLASIYERID,
      this.PLASIYERADI,
      this.SUBEID,
      this.SUBEADI,
      this.TARIH,
      this.VADETARIHI,
      this.BELGENO,
      this.ACIKLAMA,
      this.BORC,
      this.ALACAK,
      this.BAKIYE,
      this.DOVIZID,
      this.PARA,
      this.KUR,
      this.RAPORKOD1,
      this.RAPORKOD2,
      this.RAPORKOD3,
      this.RAPORKOD4,
      this.RAPORKOD5,
      this.RAPORKOD6,
      this.DOVIZALACAK,
      this.DOVIZBORC,
      this.DOVIZBAKIYE,
      this.TIP,
      this.TIPACIKLAMA,
      this.FISID,
      this.FATURAID,
      this.MCEKID,
      this.MSENETID,
      this.FATURATIP,
      this.KCEKID,
      this.KSENETID,
      this.KASAID,
      this.BANKAID,
      this.MUHASEBEID,
      this.ACIKLAMA1,
      this.ACIKLAMA2,
      this.ACIKLAMA3,
      this.SACIKLAMA1,
      this.SACIKLAMA2,
      this.SACIKLAMA3,
      this.TEXTYEDEK1,
      this.TEXTYEDEK2,
      this.SAYISALYEDEK1,
      this.SAYISALYEDEK2,
      this.TARIHYEDEK1,
      this.TARIHYEDEK2,
      this.DEVIRID,
      this.PROJEID,
      this.PROJEKODU,
      this.PROJEADI,
      this.ALTHESAPID,
      this.ALTHESAPADI,
      this.KAYITTIPI,
      this.TELEFON,
      this.CARIVADEGUNU,
      this.CARIADI,
      this.CARIKODU,
      this.ISLEMTIPI,
      this.ISLEMTIPACIKLAMA,
      this.STOKGIRIS,
      this.STOKCIKIS,
      this.BIRIM,
      this.KDV,
      this.NETFIYAT,
      this.BRUTFIYAT,
      this.KDVDAHILFIYAT,
      this.BRUTTOPLAM,
      this.TOPLAM,
      this.isExpanded = false,
      this.BAKIYETIP});

  GecmisSatisModel.fromJson(Map<String, dynamic> json) {
    ID = int.tryParse(json['ID'])??0;
    PLASIYERID = json['PLASIYERID'];
    PLASIYERADI = json['PLASIYERADI'];
    SUBEID = int.tryParse(json['SUBEID'])??0;
    SUBEADI = json['SUBEADI'];
    TARIH = json['TARIH'];
    VADETARIHI = (json['VADETARIHI']);
    BELGENO = json['BELGE_NO'];
    ACIKLAMA = json['ACIKLAMA'];
    BORC = double.tryParse(json['BORC'])??0.0;
    ALACAK = double.tryParse(json['ALACAK'])??0.0;
    BAKIYE = double.tryParse(json['BAKIYE'])??0.0;
    DOVIZID = int.tryParse(json['DOVIZID'])??0;
    PARA = json['PARA'];
    KUR = double.tryParse(json['KUR'])??0.0;
    RAPORKOD1 = json['RAPORKOD1'];
    RAPORKOD2 = json['RAPORKOD2'];
    RAPORKOD3 = json['RAPORKOD3'];
    RAPORKOD4 = json['RAPORKOD4'];
    RAPORKOD5 = json['RAPORKOD5'];
    RAPORKOD6 = json['RAPORKOD6'];
    DOVIZALACAK = double.tryParse(json['DOVIZALACAK'])??0.0;
    DOVIZBORC = double.tryParse(json['DOVIZBORC'])??0.0;
    DOVIZBAKIYE = double.tryParse(json['DOVIZBAKIYE'])??0.0;
    TIP = int.tryParse(json['TIP'])??0;
    TIPACIKLAMA = json['TIPACIKLAMA'];
    FISID = int.tryParse(json['FISID'])??0;
    FATURAID = int.tryParse(json['FATURAID'])??0;
    MCEKID = int.tryParse(json['MCEKID'])??0;
    MSENETID = int.tryParse(json['MSENETID'])??0;
    FATURATIP = json['FATURATIP'];
    KCEKID = int.tryParse(json['KCEKID'])??0;
    KSENETID = int.tryParse(json['KSENETID'])??0;
    KASAID = int.tryParse(json['KASAID'])??0;
    BANKAID = int.tryParse(json['BANKAID'])??0;
    MUHASEBEID = int.tryParse(json['MUHASEBEID'])??0;
    ACIKLAMA1 = json['ACIKLAMA1'];
    ACIKLAMA2 = json['ACIKLAMA2'];
    ACIKLAMA3 = json['ACIKLAMA3'];
    SACIKLAMA1 =double.tryParse(json['SACIKLAMA1'])??0.0;
    SACIKLAMA2 =double.tryParse(json['SACIKLAMA1'])??0.0;
    SACIKLAMA3 = double.tryParse(json['SACIKLAMA1'])??0.0;
    TEXTYEDEK1 = json['TEXTYEDEK1'];
    TEXTYEDEK2 = json['TEXTYEDEK2'];
    SAYISALYEDEK1 = double.tryParse(json['SAYISALYEDEK1'])??0.0;
    SAYISALYEDEK2 = double.tryParse(json['SAYISALYEDEK2'])??0.0;
    TARIHYEDEK1 = json['TARIHYEDEK1'];
    TARIHYEDEK2 = json['TARIHYEDEK2'];
    DEVIRID = int.tryParse(json['DEVIRID'])??0;
    PROJEID = int.tryParse(json['PROJEID'])??0;
    PROJEKODU = json['PROJEKODU'];
    PROJEADI = json['PROJEADI'];
    ALTHESAPID = int.tryParse(json['ALTHESAPID'])??0;
    ALTHESAPADI = json['ALTHESAPADI'];
    KAYITTIPI = json['KAYITTIPI'];
    TELEFON = json['TELEFON'];
    CARIVADEGUNU = json['CARIVADEGUNU'];
    CARIADI = json['CARIADI'];
    CARIKODU = json['CARIKODU'];
    ISLEMTIPI = json['ISLEMTIPI'];
    ISLEMTIPACIKLAMA = json['ISLEMTIPACIKLAMA'];
    BAKIYETIP = int.tryParse(json['BAKIYETIP'])??0;
    STOKGIRIS = int.tryParse(json['STOKGIRIS'])??0;
    STOKCIKIS = int.tryParse(json['STOKCIKIS'])??0;
    BIRIM = json['BIRIM'];
    KDV = double.tryParse(json['KDV'])??0.0;
    NETFIYAT = double.tryParse(json['NETFIYAT'])??0.0;
    BRUTFIYAT = double.tryParse(json['BRUTFIYAT'])??0.0;
    KDVDAHILFIYAT = double.tryParse(json['KDVDAHILFIYAT'])??0.0;
    BRUTTOPLAM = double.tryParse(json['BRUTTOPLAM'])??0.0;
    TOPLAM = double.tryParse(json['TOPLAM'])??0.0;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.ID;
    data['PLASIYERID'] = this.PLASIYERID;
    data['PLASIYERADI'] = this.PLASIYERADI;
    data['SUBEID'] = this.SUBEID;
    data['SUBEADI'] = this.SUBEADI;
    data['TARIH'] = this.TARIH;
    data['VADETARIHI'] = this.VADETARIHI;
    data['BELGE_NO'] = this.BELGENO;
    data['ACIKLAMA'] = this.ACIKLAMA;
    data['BORC'] = this.BORC;
    data['ALACAK'] = this.ALACAK;
    data['BAKIYE'] = this.BAKIYE;
    data['DOVIZID'] = this.DOVIZID;
    data['PARA'] = this.PARA;
    data['KUR'] = this.KUR;
    data['RAPORKOD1'] = this.RAPORKOD1;
    data['RAPORKOD2'] = this.RAPORKOD2;
    data['RAPORKOD3'] = this.RAPORKOD3;
    data['RAPORKOD4'] = this.RAPORKOD4;
    data['RAPORKOD5'] = this.RAPORKOD5;
    data['RAPORKOD6'] = this.RAPORKOD6;
    data['DOVIZALACAK'] = this.DOVIZALACAK;
    data['DOVIZBORC'] = this.DOVIZBORC;
    data['DOVIZBAKIYE'] = this.DOVIZBAKIYE;
    data['TIP'] = this.TIP;
    data['TIPACIKLAMA'] = this.TIPACIKLAMA;
    data['FISID'] = this.FISID;
    data['FATURAID'] = this.FATURAID;
    data['MCEKID'] = this.MCEKID;
    data['MSENETID'] = this.MSENETID;
    data['FATURATIP'] = this.FATURATIP;
    data['KCEKID'] = this.KCEKID;
    data['KSENETID'] = this.KSENETID;
    data['KASAID'] = this.KASAID;
    data['BANKAID'] = this.BANKAID;
    data['MUHASEBEID'] = this.MUHASEBEID;
    data['ACIKLAMA1'] = this.ACIKLAMA1;
    data['ACIKLAMA2'] = this.ACIKLAMA2;
    data['ACIKLAMA3'] = this.ACIKLAMA3;
    data['SACIKLAMA1'] = this.SACIKLAMA1;
    data['SACIKLAMA2'] = this.SACIKLAMA2;
    data['SACIKLAMA3'] = this.SACIKLAMA3;
    data['TEXTYEDEK1'] = this.TEXTYEDEK1;
    data['TEXTYEDEK2'] = this.TEXTYEDEK2;
    data['SAYISALYEDEK1'] = this.SAYISALYEDEK1;
    data['SAYISALYEDEK2'] = this.SAYISALYEDEK2;
    data['TARIHYEDEK1'] = this.TARIHYEDEK1;
    data['TARIHYEDEK2'] = this.TARIHYEDEK2;
    data['DEVIRID'] = this.DEVIRID;
    data['PROJEID'] = this.PROJEID;
    data['PROJEKODU'] = this.PROJEKODU;
    data['PROJEADI'] = this.PROJEADI;
    data['ALTHESAPID'] = this.ALTHESAPID;
    data['ALTHESAPADI'] = this.ALTHESAPADI;
    data['KAYITTIPI'] = this.KAYITTIPI;
    data['TELEFON'] = this.TELEFON;
    data['CARIVADEGUNU'] = this.CARIVADEGUNU;
    data['CARIADI'] = this.CARIADI;
    data['CARIKODU'] = this.CARIKODU;
    data['ISLEMTIPI'] = this.ISLEMTIPI;
    data['ISLEMTIPACIKLAMA'] = this.ISLEMTIPACIKLAMA;
    data['BAKIYETIP'] = this.BAKIYETIP;
    data['STOKGIRIS'] = this.STOKGIRIS;
    data['STOKCIKIS'] = this.STOKCIKIS;
    data['BIRIM'] = this.BIRIM;
    data['KDV'] = this.KDV;
    data['NETFIYAT'] = this.NETFIYAT;
    data['BRUTFIYAT'] = this.BRUTFIYAT;
    data['KDVDAHILFIYAT'] = this.KDVDAHILFIYAT;
    data['BRUTTOPLAM'] = this.BRUTTOPLAM;
    data['TOPLAM'] = this.TOPLAM;
    
    return data;
  }
}
