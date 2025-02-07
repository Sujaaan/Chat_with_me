import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? ontap;
  const MyButton({
    super.key,
    required this.text,
    required this.ontap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8)
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Text(text,style: TextStyle(color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}