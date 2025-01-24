import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notifikasi/Main/Controller/ControllerAppNotif/appController.dart';
import 'package:notifikasi/Shared/widgets/text_content_modal.dart';
import 'package:notifikasi/core/utils/SharedPreferences.dart';
import 'package:notifikasi/models/tiket_model.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AppListPage extends StatelessWidget {
  const AppListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppListController>(
      builder: (context, listController, child) {
        if (listController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }   
        if (listController.errorMessage != null) {
          return Center(child: Text(listController.errorMessage!));
        }
        final items = listController.filteredItems;
        return RefreshIndicator(
          onRefresh: () => _refreshData(context),
          child: items.isEmpty
            ? const Center(child: Text('No data available.'))
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final Tiket item = items[index];
                  return InkWell(
                    onTap: () {
                      _showDetailDialog(context, item);
                    },
                    child: Card(
                      color: Colors.white70,
                      margin: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: '${item.headercode} ',
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                ElevatedButton(
                                    onPressed: () {
                                      _showDetailDialog(context, item);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0XFF1B7F02),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 20,
                                      ),
                                    ),
                                    child: const Text('Detail'),
                                  ),
                              ],
                            ),
                            Text('${item.longdescription}'),
                            Text('${item.applicantcode} (${item.creationdatetime})'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
        );
      },
    );
  }


void _showDetailDialog(BuildContext context, Tiket item) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${item.headercode}'),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.redAccent),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextContentModal(label: "User", isi: item.applicantcode),
              TextContentModal(label: "Kode", isi: item.headercode),
              TextContentModal(label: "Tanggal", isi: item.creationdatetime),
              TextContentModal(label: "Quantity",
                isi: (item.orderuserprimaryquantity != null && item.orderuserprimaryquantity.isNotEmpty) 
                  ? '${double.parse(item.orderuserprimaryquantity).toInt()} ${item.orderbaseprimaryuomcode}' 
                  : '0 ${item.orderbaseprimaryuomcode}',
              ),
              TextContentModal(label: "Detail", isi: item.longdescription),
              TextContentModal(label: "Remark", isi: item.remark),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    '/approve',
                    arguments: {'item': item, 'status': 'reject'},
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.amber,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text('Reject'),
              ),
              TextButton(
                onPressed: () {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Enter PIN',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: SizedBox(
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        obscureText: true, // Menyembunyikan input
                        keyboardType: TextInputType.number,
                        maxLength: 1, // Membatasi setiap input hanya 1 digit
                        decoration: InputDecoration(
                          counterText: "", // Menyembunyikan counter karakter
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onChanged: (value) {
                          // Logika untuk memindahkan fokus ke input berikutnya
                          if (value.length == 1 && index < 3) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Logika untuk memverifikasi PIN
                  Navigator.pop(context); // Menutup modal setelah verifikasi
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      );
    },
  );
},

                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.lightGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text('Approve'),
              ),
            ],
          )
        ],
      );
    },
  );
}


  Future<void> _refreshData(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    // Mengambil ulang data dari controller yang sudah ada
    await context.read<AppListController>().fetchItems();

    // Menampilkan snackbar (opsional)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data berhasil diperbarui')),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return Colors.green;
      case 'on progres':
        return Colors.grey;
      case 'close':
        return Colors.black;
      default:
        return Colors.red;
    }
  }

  String _formatDate(String dateTimeString) {
    try {
      String datePart = dateTimeString.substring(0, 10);
      DateTime parsedDate = DateTime.parse(datePart);
      return DateFormat('d-M-y').format(parsedDate);
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
