import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device_imei/flutter_device_imei.dart';
import 'package:notifikasi/Core/Connection/api_constants.dart';
import 'package:notifikasi/core/constants.dart';
import 'package:notifikasi/Main/Pages/ModulUniversal/home.dart';

class InputPin extends StatefulWidget {
  final String kodeDipilih;
  final String type;
  final String reasonCode;

  const InputPin({
    Key? key,
    required this.kodeDipilih,
    required this.type,
    required this.reasonCode,
  }) : super(key: key);

  @override
  _InputPinState createState() => _InputPinState();
}

class _InputPinState extends State<InputPin> {
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Text(
            'Masukkan PIN untuk kode: ${widget.kodeDipilih}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          OtpForm(controllers: _otpControllers),
          const SizedBox(height: 35),
          ElevatedButton(
            onPressed: submitPin,
            child: const Text("Send"),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xFFFF7643),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void submitPin() async {
    String deviceId = await FlutterDeviceImei.instance.getIMEI() ?? 'Unknown platform version';
    await Constants.checkConnection();

    if (!Constants.isConnect) {
      showMessageFail("Tidak ada koneksi internet!", isError: true);
      return;
    }

    String pin = _otpControllers.map((controller) => controller.text).join();
    if (pin.isEmpty || pin.length != 6) {
      showMessageFail("PIN harus terdiri dari 6 angka!", isError: true);
      return;
    }

    var response = await ApiConstants.postRequest('bpp/cekpin', {
      'ID_DEVICE': deviceId,
      'PIN': pin,
    });

    if (response['message'] == "Data Available") {
      if (widget.type == "Approved") {
        response = await ApiConstants.postRequest('bpp/approved', {
          'HEADERCODE': widget.kodeDipilih,
          'ID_DEVICE': deviceId,
        });
        closeLoadingDialog(context); 
        if (response['status'] == true) {
          showMessageSuccess("Berhasil Approved!");
        } else {
          showMessageFail("Gagal Approved!", isError: true);
        }
      } else {
        response = await ApiConstants.postRequest('bpp/rejected', {
          'HEADERCODE': widget.kodeDipilih,
          'TEMPLATEREQUISITIONRESULTCODE': widget.reasonCode,
          'ID_DEVICE': deviceId,
        });

        if (response['status'] == true) {
          showMessageSuccess("Data berhasil ditolak!");
        } else {
          showMessageFail("Gagal menolak data atau data tidak ada!", isError: true);
        }
      }
    } else {
      showMessageFail("Pin yang ada masukan salah.", isError: true);
    }
    return;
  }

  void showMessageFail(String message, {bool isError = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isError ? 'Error' : 'Information'),
          content: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showMessageSuccess(String message, {bool isError = false}) {
    Navigator.pop(context);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isError ? 'Error' : 'Information'),
          content: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Loading'),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              const Text('Please wait...'),
            ],
          ),
        );
      },
    );
  }

  void closeLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }
}

class OtpForm extends StatelessWidget {
  final List<TextEditingController> controllers;

  const OtpForm({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(6, (index) {
          return SizedBox(
            height: 54,
            width: 54,
            child: TextFormField(
              controller: controllers[index],
              onChanged: (pin) {
                if (pin.isNotEmpty && index < 5) {
                  FocusScope.of(context).nextFocus();
                } else if (pin.isEmpty) {
                  FocusScope.of(context).previousFocus();
                } else {
                  FocusScope.of(context).unfocus();
                }
              },
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              obscureText: true,
              obscuringCharacter: '*',
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "*",
                hintStyle: const TextStyle(color: Color(0xFF757575)),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF757575)),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFF7643)),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
