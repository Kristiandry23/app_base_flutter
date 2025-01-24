import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device_imei/flutter_device_imei.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notifikasi/Core/Utils/SharedPreferences.dart';
import 'package:notifikasi/Main/Pages/ModulUniversal/login.dart';
import 'package:notifikasi/core/utils/tiket_list.dart';
import 'package:notifikasi/Main/Controller/ControllerAppNotif/appController.dart';
import 'package:notifikasi/Main/Controller/homeController.dart';
import 'package:notifikasi/Main/Controller/listController.dart';
import 'package:notifikasi/Main/Pages/ModulAppNotif/appList.dart';
import 'package:notifikasi/Main/Pages/ModulAppNotif/erpList.dart';
import 'package:notifikasi/Main/Pages/ModulAppNotif/itSuppList.dart';
import 'package:notifikasi/Main/Pages/ModulAppNotif/mtcList.dart';
import 'package:notifikasi/models/tiket_model.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final _notchBottomBarController = NotchBottomBarController(index: 0);
  int _selectedIndex = 0;
  bool _isSearching = false;
  final GlobalKey _settingsKey = GlobalKey();
  final TextEditingController _searchController = TextEditingController();

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      AppListPage(),
      MtcListPage(),
      ErpListPage(),
      ItSuppListPage(),
    ];

    String userRole = 'admin';

    switch (userRole) {
      case 'mtc':
        _selectedIndex = 1;
        break;
      case 'erp':
        _selectedIndex = 2;
        break;
      case 'it':
        _selectedIndex = 3;
        break;
      default:
        _selectedIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final listController = Provider.of<AppListController>(context, listen: false);

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
        leading: Image.asset('assets/images/logos/logo.png'),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "App & Notification ITTI",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              _getPageTitle(_selectedIndex),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            key: _settingsKey,
            icon: const Icon(Icons.settings),
            onPressed: () {
              final RenderBox button = _settingsKey.currentContext!.findRenderObject() as RenderBox;
              final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
              final Offset position = button.localToGlobal(Offset.zero, ancestor: overlay);

              showMenu<int>(
                context: context,
                position: RelativeRect.fromLTRB(
                  position.dx,
                  position.dy + button.size.height,
                  position.dx + button.size.width,
                  position.dy,
                ),
                items: [
                  PopupMenuItem(
                    value: 1,
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Profile'),
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                    ),
                  ),
                ],
              ).then((value) {
                if (value == 1) {
                  print('Profile clicked');
                } else if (value == 2) {
                  print('Logout clicked');
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.warning,
                    text: 'Do you want to logout',
                    confirmBtnText: 'Yes',
                    cancelBtnText: 'No',
                    confirmBtnColor: Colors.green,
                    onConfirmBtnTap: ()async{
                      
                      await SharedPreferencesHelper.clearToken();
                      await SharedPreferencesHelper.clearUserData();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Anda telah logout')),
                      );

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                      );
                    },
                    onCancelBtnTap: () {
                      Navigator.pop(context);
                    },
                  );
                }
              });
            },
          ),
        ],
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(_isSearching ? Icons.close : Icons.refresh),
        backgroundColor: Colors.blue,
      ),
      extendBody: true,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    String userRole = 'admin';
    switch (userRole) {
      case 'admin':
      case 'manager':
        return AnimatedNotchBottomBar(
          notchBottomBarController: _notchBottomBarController,
          bottomBarItems: [
            BottomBarItem(
              inActiveItem: const Icon(Icons.approval, color: Colors.grey),
              activeItem: const Icon(Icons.approval_outlined, color: Colors.white),
              itemLabel: 'Approval',
            ),
            BottomBarItem(
              inActiveItem: const Icon(Icons.engineering, color: Colors.grey),
              activeItem: const Icon(Icons.engineering_outlined, color: Colors.white),
              itemLabel: 'MTC Tikets',
            ),
            BottomBarItem(
              inActiveItem: const Icon(Icons.generating_tokens, color: Colors.grey),
              activeItem: const Icon(Icons.generating_tokens_outlined, color: Colors.white),
              itemLabel: 'ERP Tikets',
            ),
            BottomBarItem(
              inActiveItem: const Icon(Icons.terminal, color: Colors.grey),
              activeItem: const Icon(Icons.terminal_outlined, color: Colors.white),
              itemLabel: 'IT Support',
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          kIconSize: 20,
          kBottomRadius: 16,
          notchColor: Colors.blue,
          color: Colors.white,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  String _getPageTitle(int index) {
    switch (index) {
      case 0:
        return 'Approval Tiket';
      case 1:
        return 'MTC Tikets';
      case 2:
        return 'ERP Tikets';
      case 3:
        return 'IT Support Tikets';
      default:
        return 'Daftar Tiket';
    }
  }
}
