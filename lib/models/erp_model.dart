class ErpModel {
  String code;
  String gejala;
  String creationuser;
  String dept;
  String kodeMesin;
  String namaMesin;
  String descMesin;
  String status;
  String jamBuat;

  ErpModel({
    required this.code,
    required this.gejala,
    required this.creationuser,
    required this.dept,
    required this.kodeMesin,
    required this.namaMesin,
    required this.descMesin,
    required this.status,
    required this.jamBuat,
  });

  factory ErpModel.fromJson(Map<String, dynamic> json) {
    return ErpModel(
      code: json['code'] ?? '',
      gejala: json['gejala'] ?? '',
      creationuser: json['creationuser'] ?? '',
      dept: json['dept'] ?? '',
      kodeMesin: json['kode_mesin'] ?? '',
      namaMesin: json['nama_mesin'] ?? '',
      descMesin: json['desc_mesin'] ?? '',
      status: json['status'] ?? '',
      jamBuat: json['jam_buat'] ?? '',
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
    };
  }
}
