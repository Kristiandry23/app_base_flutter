// import 'package:notifikasi/Main/Controller/homeController.dart';
// import 'package:notifikasi/shared/widgets/input_pin.dart';
// import 'package:notifikasi/shared/widgets/text_content_modal.dart';
// import 'package:notifikasi/Models/tiket_model.dart';
// import 'package:flutter/material.dart';

// class TiketList extends StatefulWidget {
//   final List<Tiket>? data;
//   final Function initializeData;

//   const TiketList({
//     Key? key,
//     required this.data,
//     required this.initializeData,
//   }) : super(key: key);

//   @override
//   State<TiketList> createState() => _TiketListState();
// }

// class _TiketListState extends State<TiketList> {
//   bool isUpdating = false;

//   void _updateData() async {
//     setState(() {
//       isUpdating = true;
//     });
//     await widget.initializeData();
//     setState(() {
//       isUpdating = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         ListView.builder(
//           itemCount: widget.data?.length,
//           itemBuilder: (context, index) {
//             widget.data?[index];
//             return GestureDetector(
//               onTap: () {
//                 showModalBottomSheet(
//                   useSafeArea: true,
//                   isScrollControlled: true,
//                   context: context,
//                   showDragHandle: true,
//                   builder: (BuildContext context) {
//                     return SizedBox(
//                       width: double.infinity,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Center(
//                               child: Text(
//                                 widget.data![index].headercode,
//                                 style: const TextStyle(fontSize: 20.0),
//                               ),
//                             ),
//                             const SizedBox(height: 20.0),
//                             TextContentModal(
//                               label: "User",
//                               isi: widget.data?[index].applicantcode,
//                             ),
//                             TextContentModal(
//                               label: "Detail",
//                               isi: widget.data?[index].longdescription,
//                             ),
//                             TextContentModal(
//                               label: "Quantity",
//                               isi:
//                                   '${double.parse(widget.data![index].orderuserprimaryquantity).toInt()} ${widget.data?[index].orderbaseprimaryuomcode}',
//                             ),
//                             TextContentModal(
//                               label: "Tanggal",
//                               isi: widget.data?[index].creationdatetime,
//                             ),
//                             TextContentModal(
//                               label: "Remark",
//                               isi: widget.data?[index].remark,
//                             ),
//                             const SizedBox(height: 20.0),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.green,
//                                     foregroundColor: Colors.white,
//                                   ),
//                                   child: const Text("Approved"),
//                                   onPressed: () async {
//                                     String kodeDipilih =
//                                         widget.data![index].headercode;
//                                     showPinInputModal(
//                                       context,
//                                       kodeDipilih,
//                                       "0",
//                                       "Approved",
//                                     );
//                                   },
//                                 ),
//                                 ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.red,
//                                     foregroundColor: Colors.white,
//                                   ),
//                                   child: const Text("Tolak"),
//                                   onPressed: () async {
//                                     String kodeDipilih =
//                                         widget.data![index].headercode;
//                                     List<Map<String, String>> alasanList =
//                                         await HomeController.handleRejection(
//                                       'someStatusData',
//                                     );
//                                     String? selectedReason;
//                                     String? selectedCode;

//                                     selectedReason =
//                                         await showModalBottomSheet<String>(
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return Padding(
//                                           padding: const EdgeInsets.all(16.0),
//                                           child: Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'Pilih alasan penolakan',
//                                                 style: const TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                               const SizedBox(height: 10),
//                                               ListView.builder(
//                                                 shrinkWrap: true,
//                                                 itemCount: alasanList.length,
//                                                 itemBuilder: (context, index) {
//                                                   return ListTile(
//                                                     title: Text(
//                                                       alasanList[index]
//                                                           ['longdescription']!,
//                                                     ),
//                                                     onTap: () {
//                                                       selectedCode = alasanList[
//                                                           index]['code'];
//                                                       Navigator.pop(
//                                                         context,
//                                                         alasanList[index]
//                                                             ['longdescription'],
//                                                       );
//                                                     },
//                                                   );
//                                                 },
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       },
//                                     );

//                                     if (selectedReason != null) {
//                                       showDialog(
//                                         context: context,
//                                         builder: (BuildContext context) {
//                                           return AlertDialog(
//                                             title: Text(
//                                               "Anda Menolak $kodeDipilih",
//                                             ),
//                                             content: Text(
//                                               "Karena $selectedReason",
//                                             ),
//                                             actions: <Widget>[
//                                               TextButton(
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: const Text('Cancel'),
//                                               ),
//                                               TextButton(
//                                                 onPressed: () {
//                                                   showPinInputModal(
//                                                     context,
//                                                     kodeDipilih,
//                                                     selectedCode!,
//                                                     "Cancel",
//                                                   );
//                                                 },
//                                                 child: const Text('Oke'),
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       );
//                                     }
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ).then((_) => _updateData()); // Muat ulang data setelah modal ditutup.
//               },
//               child: Card(
//                 elevation: 2,
//                 color: Colors.blueGrey[100],
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: ListTile(
//                   title: RichText(
//                     text: TextSpan(
//                       style: const TextStyle(
//                         color: Colors.black,
//                       ),
//                       text: '${widget.data?[index].headercode} ',
//                     ),
//                   ),
//                   trailing: ElevatedButton(
//                     onPressed: null,
//                     style: ElevatedButton.styleFrom(
//                       disabledBackgroundColor: const Color(0XFF1B7F02),
//                       disabledForegroundColor: Colors.white,
//                       minimumSize: Size.zero,
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 5,
//                         horizontal: 10,
//                       ),
//                     ),
//                     child: const Text('show detail'),
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "${widget.data?[index].applicantcode} (${widget.data?[index].creationdatetime})",
//                         style: const TextStyle(),
//                       ),
//                       Text(
//                         widget.data![index].longdescription,
//                         style: const TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//         if (isUpdating)
//           const Center(
//             child: CircularProgressIndicator(),
//           ),
//       ],
//     );
//   }
  
//   void showPinInputModal(BuildContext context, String kodeDipilih, String reasonCode, String type) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return InputPin(kodeDipilih: kodeDipilih, type: type, reasonCode: reasonCode);
//       },
//     );
//   }
// }