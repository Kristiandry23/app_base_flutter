// import 'package:cart_loc/core/external/localDb/database_helper.dart';
// import 'package:cart_loc/core/external/sharedPreferance/SharedPreferences.dart';
// import 'package:cart_loc/main/pages/login.dart';
// import 'package:flutter/material.dart';
// import 'package:quickalert/models/quickalert_type.dart';
// import 'package:quickalert/widgets/quickalert_dialog.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert'; // Untuk json.decode


// class ProfilPage extends StatefulWidget {
//   @override
//   _ProfilPageState createState() => _ProfilPageState();
// }

// class _ProfilPageState extends State<ProfilPage> {
//   String? _userName;
//   String? _userDivision;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   // Memuat data pengguna dari SharedPreferences
//   Future<void> _loadUserData() async {
//     Map<String, dynamic>? userData = await SharedPreferencesHelper.getUserData();
//     if (userData != null) {
//       setState(() {
//         _userName = userData['nama']; // Nama pengguna
//         _userDivision = userData['ket']; // Divisi pengguna
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueGrey,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 40, // Ukuran avatar
//                       backgroundColor: Colors.blue, // Warna latar belakang avatar
//                       child: Icon(
//                         Icons.person, // Ikon untuk profil
//                         size: 40,
//                         color: Colors.white,
//                       ),
//                     ),
//                     SizedBox(width: 16), // Memberi jarak antara avatar dan teks
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           _userName ?? 'Nama Pengguna', // Menampilkan nama pengguna atau placeholder
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           _userDivision ?? 'Divisi', // Menampilkan divisi atau placeholder
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Spacer(),
//                     // Card untuk logout
//                     Card(
//                       color: Colors.red[100],
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: InkWell(
//                         onTap: () async {
//                           QuickAlert.show(
//                             context: context,
//                             type: QuickAlertType.confirm,
//                             text: 'Do you want to logout',
//                             confirmBtnText: 'Yes',
//                             cancelBtnText: 'No',
//                             confirmBtnColor: Colors.green,
//                             onConfirmBtnTap: ()async{
                              
//                               await SharedPreferencesHelper.clearToken();
//                               await SharedPreferencesHelper.clearUserData();
//                               await DatabaseHelper().deleteLocalDatabase();

//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text('Anda telah logout')),
//                               );

//                               Navigator.pushAndRemoveUntil(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => LoginPage()),
//                                 (route) => false,
//                               );
//                             },
//                             onCancelBtnTap: () {
//                               Navigator.pop(context);
//                             },
//                           );
//                         },
//                         borderRadius: BorderRadius.circular(8),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.exit_to_app,
//                                 color: Colors.red,
//                               ),
//                               SizedBox(width: 8),
//                               Text(
//                                 'Logout',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.red,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             // Elemen lainnya bisa ditambahkan di sini
//           ],
//         ),
//       ),
//     );
//   }
// }
