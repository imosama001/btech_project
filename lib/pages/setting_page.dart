import 'package:b_tech_project/pages/login_page.dart';
import 'package:b_tech_project/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          UserRepository().logout();
        },
        child: const Text("Logout"),
      ),
    );
  }
}
