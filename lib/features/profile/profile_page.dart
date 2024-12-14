import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_controller.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text(profileController.profileData),
      ),
    );
  }
}