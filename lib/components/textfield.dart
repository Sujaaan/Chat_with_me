import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String hinttext;
  final bool obscure;
  final TextEditingController controller;
  final FocusNode? focusnode;
  const MyTextfield({
    super.key,
    required this.hinttext,
    required this.obscure,
    required this.controller,
    this.focusnode
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        focusNode: focusnode,
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            )
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hinttext,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}