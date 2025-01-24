// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// class BarcodeScannerDialog extends StatelessWidget {
//   final TextEditingController textController;

//   BarcodeScannerDialog({required this.textController});

//   void scanBarcode(BuildContext context) async {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Container(
//             width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
//             height: 400, // Fixed height for the scanner dialog
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.blueGrey, // Border color
//                 width: 2.0, // Border thickness
//               ),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Column(
//               children: [
//                 // Header with close button
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 16, vertical: 8),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(16),
//                       topRight: Radius.circular(16),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Scan Barcode",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.close, color: Colors.red),
//                         onPressed: () {
//                           if (Navigator.canPop(context)) {
//                             Navigator.pop(context); // Close the scanner
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Scanner area
//                 Expanded(
//                   child: Container(
//                     margin: const EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: MobileScanner(
//                       onDetect: (capture) {
//                         final List<Barcode> barcodes = capture.barcodes;
//                         final Barcode? barcode =
//                             barcodes.isNotEmpty ? barcodes.first : null;
//                         if (barcode != null && barcode.rawValue != null) {
//                           textController.text = barcode.rawValue!;
//                           Future.delayed(Duration(milliseconds: 500), () {
//                             if (Navigator.canPop(context)) {
//                               Navigator.pop(context); // Close scanner after detecting
//                             }
//                           });
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.qr_code_scanner),
//       onPressed: () => scanBarcode(context),
//     );
//   }
// }
