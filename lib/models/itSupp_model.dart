class itSuppModel {
  String code;
  String gejala;
  String creationuser;
  String dept;
  String kodeMesin;
  String namaMesin;
  String descMesin;
  String status;
  String jamBuat;
  String lamaWaktu;


  itSuppModel({
    required this.code,
    required this.gejala,
    required this.creationuser,
    required this.dept,
    required this.kodeMesin,
    required this.namaMesin,
    required this.descMesin,
    required this.status,
    required this.jamBuat,
    required this.lamaWaktu,
  });

  factory itSuppModel.fromJson(Map<String, dynamic> json) {
    return itSuppModel(
      code: json['code'] ?? '',
      gejala: json['gejala'] ?? '',
      creationuser: json['creationuser'] ?? '',
      dept: json['dept'] ?? '',
      kodeMesin: json['kode_mesin'] ?? '',
      namaMesin: json['nama_mesin'] ?? '',
      descMesin: json['desc_mesin'] ?? '',
      status: json['status'] ?? '',
      jamBuat: json['jam_buat'] ?? '',
      lamaWaktu: json['lama_waktu'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'gejala': gejala,
      'creationuser': creationuser,
      'dept': dept,
      'kodeMesin': kodeMesin,
      'namaMesin': namaMesin,
      'descMesin': descMesin,
      'status': status,
      'jamBuat': jamBuat,
      'lamaWaktu': lamaWaktu,
    };
  }
}
