import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notifikasi/Core/Utils/SharedPreferences.dart';
import 'package:notifikasi/Main/Controller/ControllerAppNotif/appController.dart';
import 'package:notifikasi/Main/Controller/ControllerAppNotif/erpController.dart';
import 'package:notifikasi/Main/Controller/ControllerAppNotif/itSuppController.dart';
import 'package:notifikasi/Main/Controller/ControllerAppNotif/mtcController.dart';
import 'package:notifikasi/main.dart';
import 'package:provider/provider.dart';
import 'notification_service.dart';

Future<void> initializeFirebase() async {
  await Firebase.initializeApp();
  String? userRole = await SharedPreferencesHelper.getRole();
  String? userBagian = await SharedPreferencesHelper.getBagian();

  if(userRole == '1'){
    await FirebaseMessaging.instance.subscribeToTopic('Management');
  }else if(userRole == '2'){
    await FirebaseMessaging.instance.subscribeToTopic('approval');
  }else if(userRole == '3'){
    if(userBagian == 'IT'){
      await FirebaseMessaging.instance.subscribeToTopic('it');
    }else if(userBagian == 'ERP'){
      await FirebaseMessaging.instance.subscribeToTopic('erp');
    }else {
      await FirebaseMessaging.instance.subscribeToTopic('mtc');
    }
  }else {
    await FirebaseMessaging.instance.subscribeToTopic('Management');
  }
}

void setupFirebaseListeners() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.data['topic'] == 'approval') {
      showNotification(message);
      navigatorKey.currentState?.context.read<AppListController>().fetchItems();
    } else if (message.data['topic'] == 'mtc') {
      showNotification(message);
      navigatorKey.currentState?.context.read<MtcListController>().fetchItems();
    } else if (message.data['topic'] == 'erp') {
      showNotification(message);
      navigatorKey.currentState?.context.read<ErpListController>().fetchItems();
    } else if (message.data['topic'] == 'it') {
      showNotification(message);
      navigatorKey.currentState?.context.read<ItSuppListController>().fetchItems();
    } else if (message.data['topic'] == 'management') {
      showNotification(message);
      navigatorKey.currentState?.context.read<AppListController>().fetchItems();
      navigatorKey.currentState?.context.read<MtcListController>().fetchItems();
      navigatorKey.currentState?.context.read<ErpListController>().fetchItems();
      navigatorKey.currentState?.context.read<ItSuppListController>().fetchItems();
    } else {
      showNotification(message);
    }
  });

  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
}

Future<void> _backgroundHandler(RemoteMessage message) async {
  if (message.data['topic'] == 'approval') {
    showNotification(message);
  } else if (message.data['topic'] == 'mtc') {
    showNotification(message);
  } else if (message.data['topic'] == 'erp') {
    showNotification(message);
  } else if (message.data['topic'] == 'it') {
    showNotification(message);
  } else if (message.data['topic'] == 'management') {
    showNotification(message);
  }
}