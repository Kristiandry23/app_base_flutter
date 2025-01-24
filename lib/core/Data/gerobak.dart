class Gerobak {
  final int id;
  final String noGerobak;
  final String kodeArea;
  final String prodDemand;
  final String userId;
  final String kodeAreaDetail;
  final DateTime tglUpdate;

  Gerobak({
    required this.id,
    required this.noGerobak,
    required this.kodeArea,
    required this.prodDemand,
    required this.userId,
    required this.kodeAreaDetail,
    required this.tglUpdate,
  });

  factory Gerobak.fromJson(Map<String, dynamic> json) {
    return Gerobak(
        id: json['id'],
        noGerobak: json['no_gerobak'],
        kodeArea: json['kode_area'],
        prodDemand: json['prod_demand'],
        userId: json['userid'],
        kodeAreaDetail: json['kode_area_detail'],
        tglUpdate: DateTime.parse(json['tgl_update']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'no_gerobak': noGerobak,
      'kode_area': kodeArea,
      'prod_demand': prodDemand,
      'userid': userId,
      'kode_area_detail': kodeAreaDetail,
      'tgl_update': tglUpdate.toIso8601String()
    };
  }
}
