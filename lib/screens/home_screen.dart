import 'package:flutter/material.dart';
import '../responsive/uiComponanets/infowidget.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Infowidget(
      builder: (context, deviceInfo) {
        return Scaffold(
          appBar: AppBar(
            title: Text('الصفحة الرئيسية'),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await _authService.signOut();
                  Navigator.pushReplacementNamed(context, 'sign_in');
                },
              ),
            ],
          ),
//re
        );
      },
    );
  }
}
