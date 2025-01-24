import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notifikasi/Shared/widgets/text_content_modal.dart';
import 'package:notifikasi/core/utils/SharedPreferences.dart';
import 'package:notifikasi/Main/Controller/ControllerAppNotif/itSuppController.dart';
import 'package:notifikasi/models/itSupp_model.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ItSuppListPage extends StatelessWidget {
  const ItSuppListPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ItSuppListController>(
      builder: (context, listController, child) {
        if (listController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (listController.errorMessage != null) {
          return Center(child: Text(listController.errorMessage!));
        }

        final items = listController.filteredItems;

        if (items.isEmpty) {
          return const Center(child: Text('No data available.'));
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final itSuppModel item = items[index];
            return Card(
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
                            style: const TextStyle(fontSize: 18, color: Colors.black),
                            children: [
                              TextSpan(
                                text: '${item.code} ',
                              ),
                              TextSpan(
                                text: '(${item.status})',
                                style: TextStyle(
                                  color: _getStatusColor(item.status),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('${item.code}  (${item.status})'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextContentModal(label: "User",isi: item.creationuser),
                                      TextContentModal(label: "Dept",isi: item.dept),
                                      TextContentModal(label: "Kode Mesin",isi: item.kodeMesin),
                                      TextContentModal(label: "Nama Mesin",isi: item.namaMesin),
                                      TextContentModal(label: "Desc Mesin",isi: item.descMesin),
                                      TextContentModal(label: "Tanggal",isi: _formatDate(item.jamBuat)),
                                      TextContentModal(label: "Gejala",isi: item.gejala),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0XFF1B7F02),
                            foregroundColor: Colors.white,
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                          ),
                          child: const Text('Detail'),
                        ),
                      ],
                    ),
                    Text('${item.creationuser} (${_formatDate(item.jamBuat)})'),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return Colors.green;
      case 'in progress':
        return Colors.grey;
      case 'close':
        return Colors.black;
      default:
        return Colors.red; // Warna default jika status tidak dikenal
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