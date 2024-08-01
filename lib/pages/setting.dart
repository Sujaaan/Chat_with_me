import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey.shade500,
        title: Text("Settings",style: TextStyle(color: Theme.of(context).colorScheme.tertiary),),
      ),
    );
  }
}