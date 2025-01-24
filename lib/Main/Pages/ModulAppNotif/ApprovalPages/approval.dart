import 'package:flutter/material.dart';
import 'package:notifikasi/models/tiket_model.dart';

class ApprovalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final Tiket? item = arguments?['item'];
    final String? status = arguments?['status'];

    if (item == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Approve Page")),
        body: const Center(child: Text('No data received')),
      );
    }

    // Tentukan judul appBar dan konten body berdasarkan status
    String appBarTitle = status == 'approve' ? 'Approve Page' : 'Reject Page';
    Widget bodyContent;

    if (status == 'approve') {
      bodyContent = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${item.headercode}'),
          Text('${item.applicantcode}'),
          Text('${item.creationdatetime}'),
          Text('${double.parse(item.orderuserprimaryquantity).toInt()} ${item.orderbaseprimaryuomcode}'),
          Text('${item.longdescription}'),
          Text('${item.remark}'),
          const SizedBox(height: 20),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              // Logika untuk approve
              print('Approve action for ${item.headercode}');
            },
           style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: const Size(double.infinity, 60),
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
            child: const Text('Approve'),
          ),
        ],
      );
    } else {
      bodyContent = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Header Code: ${item.headercode}'),
          Text('Applicant Code: ${item.applicantcode}'),
          Text('Date: ${item.creationdatetime}'),
          Text('Quantity: ${double.parse(item.orderuserprimaryquantity).toInt()} ${item.orderbaseprimaryuomcode}'),
          Text('Detail: ${item.longdescription}'),
          Text('Remark: ${item.remark}'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Logika untuk reject
              print('Reject action for ${item.headercode}');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Warna tombol reject
            ),
            child: const Text('Reject'),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        backgroundColor: Colors.blueGrey[100],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              appBarTitle, // Judul dinamis berdasarkan status
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: bodyContent, // Konten dinamis berdasarkan status
          ),
        ),
      ),
    );
  }
}
