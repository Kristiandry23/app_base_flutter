class Tiket {
  String headercode;
  String applicantcode;
  String creationdatetime;
  String longdescription;
  String orderuserprimaryquantity;
  String orderbaseprimaryuomcode;
  String remark;
 
  Tiket({
    required this.headercode,
    required this.applicantcode,
    required this.creationdatetime,
    required this.longdescription,
    required this.orderuserprimaryquantity,
    required this.orderbaseprimaryuomcode,
    required this.remark,
 
  });

  factory Tiket.fromJson(Map<String, dynamic> json) {
    return Tiket(
      headercode: json['headercode'] ?? '',
      applicantcode: json['applicantcode'] ?? '',
      creationdatetime: json['creationdatetime'] ?? '',
      longdescription: json['longdescription'] ?? '',
      orderuserprimaryquantity: json['orderuserprimaryquantity'] ?? '',
      orderbaseprimaryuomcode: json['orderbaseprimaryuomcode'] ?? '',
      remark: json['remark'] ?? '',
     
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'headercode': headercode,
      'applicantcode': applicantcode,
      'creationdatetime': creationdatetime,
      'longdescription': longdescription,
      'orderuserprimaryquantity': orderuserprimaryquantity,
      'orderbaseprimaryuomcode': orderbaseprimaryuomcode,
      'remark': remark,
    };
  }
}

class ApproveTiket {
  String headercode;
  String applicantcode;
  String creationdatetime;
  String longdescription;
  String orderuserprimaryquantity;
  String orderbaseprimaryuomcode;
  String remark;
 
  ApproveTiket({
    required this.headercode,
    required this.applicantcode,
    required this.creationdatetime,
    required this.longdescription,
    required this.orderuserprimaryquantity,
    required this.orderbaseprimaryuomcode,
    required this.remark,
 
  });

  factory ApproveTiket.fromJson(Map<String, dynamic> json) {
    return ApproveTiket(
      headercode: json['headercode'] ?? '',
      applicantcode: json['applicantcode'] ?? '',
      creationdatetime: json['creationdatetime'] ?? '',
      longdescription: json['longdescription'] ?? '',
      orderuserprimaryquantity: json['orderuserprimaryquantity'] ?? '',
      orderbaseprimaryuomcode: json['orderbaseprimaryuomcode'] ?? '',
      remark: json['remark'] ?? '',
     
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'headercode': headercode,
      'applicantcode': applicantcode,
      'creationdatetime': creationdatetime,
      'longdescription': longdescription,
      'orderuserprimaryquantity': orderuserprimaryquantity,
      'orderbaseprimaryuomcode': orderbaseprimaryuomcode,
      'remark': remark,
    };
  }
}
