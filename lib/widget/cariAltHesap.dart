import 'package:flutter/material.dart';

class CariAltHesap {
  String? KOD = "";
  String? ALTHESAP = "";
  int? ALTHESAPID = 0;
  int? DOVIZID;
  String? VARSAYILAN =""; 
  String? ZORUNLU ="";

  CariAltHesap({required this.KOD, required this.ALTHESAP,required this.DOVIZID,required this.VARSAYILAN});

  CariAltHesap.fromJson(Map<String, dynamic> json) {
    KOD = json['KOD'];
    ALTHESAP = json['ALTHESAP'];
    ALTHESAPID = int.parse(json['ALTHESAPID'].toString());
    DOVIZID = int.parse(json['DOVIZID'].toString());
    VARSAYILAN = json['VARSAYILAN'];
    ZORUNLU = json['ZORUNLU'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['KOD'] = KOD;
    data['ALTHESAP'] = ALTHESAP;
    data['ALTHESAPID'] = ALTHESAPID;
    data['DOVIZID'] = DOVIZID;
    data['VARSAYILAN'] = VARSAYILAN;
    data['ZORUNLU'] = ZORUNLU;
    return data;
  }
}
