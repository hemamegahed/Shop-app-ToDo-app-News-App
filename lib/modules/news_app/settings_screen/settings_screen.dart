import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('settings',style: TextStyle(
        fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue),));
  }
}
