import 'package:intl/intl.dart';

import '../../widget/ctanim.dart';

class DekontKayitHarModel {
  int? ID = 0;
  String? UUID = "";
  int? MAHSUPID = 0;
  int? SIRA = 0;
  String? BELGENO = "";
  String? TARIH = DateFormat("yyyy-MM-dd").format(DateTime.now());
  int? TIP = 0;
  int? CARIID = 0;
  int? BANKAID = 0;
  int? STOKID = 0;
  int? MUHASEBEKODID = 0;
  int? PERSONELID = 0;
  int? MASRAFID = 0;
  String? ACIKLAMA1 = "";
  String? ACIKLAMA2 = "";
  String? ACIKLAMA3 = "";
  int? DOVIZID = 0;
  double? KUR = 0.0;
  double? BORC = 0.0;
  double? ALACAK = 0.0;
  double? DOVIZBORC = 0.0;
  double? DOVIZALACAK = 0.0;
  double? MIKTAR = 0.0;
  String? KDVVARMI = "H";
  String? KDVDAHILMI = "H";
  double? KDVORAN = 0.0;
  double? KDVTUTAR = 0.0;
  String? BFORMU = "H";
  int? DEPOID = 0;
  int? MUHASEBEID = 0;
  String? TEXTYEDEK1 = "";
  String? TEXTYEDEK2 = "";
  double? SAYISALYEDEK1 = 0.0;
  double? SAYISALYEDEK2 = 0.0;
  String? TARIHYEDEK1 = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String? TARIHYEDEK2 = DateFormat("yyyy-MM-dd").format(DateTime.now());
  int? KARTID = 0;
  int? HIZMETID = 0;
  int? KAYITTIPI = 0;
  int? ALTHESAPID = 0;
  int? DONEM = 0;
  int? PROJEID = 0;
  int? TAKSIT = 0;
  String? HIZMETKATEGORIID = "";
  int? ISLEMTIPI = 0;
  String? GUID = "";
  int? BANKAHESAPTIP = 0;
  String? VADETARIHI = DateFormat("yyyy-MM-dd").format(DateTime.now());
  int? KASAID = 0;
  int? CARIKARTID = 0;

  DekontKayitHarModel({
    this.ID,
    this.UUID,
    this.MAHSUPID,
    this.SIRA,
    this.BELGENO,
    this.TARIH,
    this.TIP,
    this.CARIID,
    this.BANKAID,
    this.STOKID,
    this.MUHASEBEKODID,
    this.PERSONELID,
    this.MASRAFID,
    this.ACIKLAMA1,
    this.ACIKLAMA2,
    this.ACIKLAMA3,
    this.DOVIZID,
    this.KUR,
    this.BORC,
    this.ALACAK,
    this.DOVIZBORC,
    this.DOVIZALACAK,
    this.MIKTAR,
    this.KDVVARMI,
    this.KDVDAHILMI,
    this.KDVORAN,
    this.KDVTUTAR,
    this.BFORMU,
    this.DEPOID,
    this.MUHASEBEID,
    this.TEXTYEDEK1,
    this.TEXTYEDEK2,
    this.SAYISALYEDEK1,
    this.SAYISALYEDEK2,
    this.TARIHYEDEK1,
    this.TARIHYEDEK2,
    this.KARTID,
    this.HIZMETID,
    this.KAYITTIPI,
    this.ALTHESAPID,
    this.DONEM,
    this.PROJEID,
    this.TAKSIT,
    this.HIZMETKATEGORIID,
    this.ISLEMTIPI,
    this.GUID,
    this.BANKAHESAPTIP,
    this.VADETARIHI,
    this.KASAID,
    this.CARIKARTID,
  });

  DekontKayitHarModel.empty()
      : this(
          ID: 0,
          UUID: "",
          MAHSUPID: 0,
          SIRA: 0,
          BELGENO: "",
          TARIH: DateFormat("yyyy-MM-dd").format(DateTime.now()),
          TIP: 0,
          CARIID: 0,
          BANKAID: 0,
          STOKID: 0,
          MUHASEBEKODID: 0,
          PERSONELID: 0,
          MASRAFID: 0,
          ACIKLAMA1: "",
          ACIKLAMA2: "",
          ACIKLAMA3: "",
          DOVIZID: 0,
          KUR: 0.0,
          BORC: 0.0,
          ALACAK: 0.0,
          DOVIZBORC: 0.0,
          DOVIZALACAK: 0.0,
          MIKTAR: 0.0,
          KDVVARMI: "H",
          KDVDAHILMI: "H",
          KDVORAN: 0.0,
          KDVTUTAR: 0.0,
          BFORMU: "H",
          DEPOID: 0,
          MUHASEBEID: 0,
          TEXTYEDEK1: "",
          TEXTYEDEK2: "",
          SAYISALYEDEK1: 0.0,
          SAYISALYEDEK2: 0.0,
          TARIHYEDEK1: DateFormat("yyyy-MM-dd").format(DateTime.now()),
          TARIHYEDEK2: DateFormat("yyyy-MM-dd").format(DateTime.now()),
          KARTID: 0,
          HIZMETID: 0,
          KAYITTIPI: 0,
          ALTHESAPID: 0,
          DONEM: 0,
          PROJEID: 0,
          TAKSIT: 0,
          HIZMETKATEGORIID: "",
          ISLEMTIPI: 0,
          GUID: "",
          BANKAHESAPTIP: 0,
          VADETARIHI: DateFormat("yyyy-MM-dd").format(DateTime.now()),
          KASAID: 0,
          CARIKARTID: 0,
        );

  DekontKayitHarModel.fromJson(Map<String, dynamic> json) {
    ID = int.parse(json['ID'].toString());
    UUID = json['UUID'];
    MAHSUPID = int.parse(json['MAHSUPID'].toString());
    SIRA = int.parse(json['SIRA'].toString());
    BELGENO = json['BELGENO'];
    TARIH = json['TARIH'];
    TIP = int.parse(json['TIP'].toString());
    CARIID = int.parse(json['CARIID'].toString());
    BANKAID = int.parse(json['BANKAID'].toString());
    STOKID = int.parse(json['STOKID'].toString());
    MUHASEBEKODID = int.parse(json['MUHASEBEKODID'].toString());
    PERSONELID = int.parse(json['PERSONELID'].toString());
    MASRAFID = int.parse(json['MASRAFID'].toString());
    ACIKLAMA1 = json['ACIKLAMA1'];
    ACIKLAMA2 = json['ACIKLAMA2'];
    ACIKLAMA3 = json['ACIKLAMA3'];
    DOVIZID = int.parse(json['DOVIZID'].toString());
    KUR = double.parse(json['KUR'].toString());
    BORC = double.parse(json['BORC'].toString());
    ALACAK = double.parse(json['ALACAK'].toString());
    DOVIZBORC = double.parse(json['DOVIZBORC'].toString());
    DOVIZALACAK = double.parse(json['DOVIZALACAK'].toString());
    MIKTAR = double.parse(json['MIKTAR'].toString());
    KDVVARMI = json['KDVVARMI'];
    KDVDAHILMI = json['KDVDAHILMI'];
    KDVORAN = double.parse(json['KDVORAN'].toString());
    KDVTUTAR = double.parse(json['KDVTUTAR'].toString());
    BFORMU = json['BFORMU'];
    DEPOID = int.parse(json['DEPOID'].toString());
    MUHASEBEID = int.parse(json['MUHASEBEID'].toString());
    TEXTYEDEK1 = json['TEXTYEDEK1'];
    TEXTYEDEK2 = json['TEXTYEDEK2'];
    SAYISALYEDEK1 = double.parse(json['SAYISALYEDEK1'].toString());
    SAYISALYEDEK2 = double.parse(json['SAYISALYEDEK2'].toString());
    TARIHYEDEK1 = json['TARIHYEDEK1'];
    TARIHYEDEK2 = json['TARIHYEDEK2'];
    KARTID = int.parse(json['KARTID'].toString());
    HIZMETID = int.parse(json['HIZMETID'].toString());
    KAYITTIPI = int.parse(json['KAYITTIPI'].toString());
    ALTHESAPID = int.parse(json['ALTHESAPID'].toString());
    DONEM = int.parse(json['DONEM'].toString());
    PROJEID = int.parse(json['PROJEID'].toString());
    TAKSIT = int.parse(json['TAKSIT'].toString());
    HIZMETKATEGORIID = json['HIZMETKATEGORIID'];
    ISLEMTIPI = int.parse(json['ISLEMTIPI'].toString());
    GUID = json['GUID'];
    BANKAHESAPTIP = int.parse(json['BANKAHESAPTIP'].toString());
    VADETARIHI = json['VADETARIHI'];
    KASAID = int.parse(json['KASAID'].toString());
    CARIKARTID = int.parse(json['CARIKARTID'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = ID;
    data['UUID'] = UUID;
    data['MAHSUPID'] = MAHSUPID;
    data['SIRA'] = SIRA;
    data['BELGENO'] = BELGENO;
    data['TARIH'] = TARIH;
    data['TIP'] = TIP;
    data['CARIID'] = CARIID;
    data['BANKAID'] = BANKAID;
    data['STOKID'] = STOKID;
    data['MUHASEBEKODID'] = MUHASEBEKODID;
    data['PERSONELID'] = PERSONELID;
    data['MASRAFID'] = MASRAFID;
    data['ACIKLAMA1'] = ACIKLAMA1;
    data['ACIKLAMA2'] = ACIKLAMA2;
    data['ACIKLAMA3'] = ACIKLAMA3;
    data['DOVIZID'] = DOVIZID;
    data['KUR'] = KUR;
    data['BORC'] = BORC;
    data['ALACAK'] = ALACAK;
    data['DOVIZBORC'] = DOVIZBORC;
    data['DOVIZALACAK'] = DOVIZALACAK;
    data['MIKTAR'] = MIKTAR;
    data['KDVVARMI'] = KDVVARMI;
    data['KDVDAHILMI'] = KDVDAHILMI;
    data['KDVORAN'] = KDVORAN;
    data['KDVTUTAR'] = KDVTUTAR;
    data['BFORMU'] = BFORMU;
    data['DEPOID'] = DEPOID;
    data['MUHASEBEID'] = MUHASEBEID;
    data['TEXTYEDEK1'] = TEXTYEDEK1;
    data['TEXTYEDEK2'] = TEXTYEDEK2;
    data['SAYISALYEDEK1'] = SAYISALYEDEK1;
    data['SAYISALYEDEK2'] = SAYISALYEDEK2;
    data['TARIHYEDEK1'] = TARIHYEDEK1;
    data['TARIHYEDEK2'] = TARIHYEDEK2;
    data['KARTID'] = KARTID;
    data['HIZMETID'] = HIZMETID;
    data['KAYITTIPI'] = KAYITTIPI;
    data['ALTHESAPID'] = ALTHESAPID;
    data['DONEM'] = DONEM;
    data['PROJEID'] = PROJEID;
    data['TAKSIT'] = TAKSIT;
    data['HIZMETKATEGORIID'] = HIZMETKATEGORIID;
    data['ISLEMTIPI'] = ISLEMTIPI;
    data['GUID'] = GUID;
    data['BANKAHESAPTIP'] = BANKAHESAPTIP;
    data['VADETARIHI'] = VADETARIHI;
    data['KASAID'] = KASAID;
    data['CARIKARTID'] = CARIKARTID;

    return data;
  }
}