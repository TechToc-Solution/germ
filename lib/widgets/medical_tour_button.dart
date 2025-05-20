import 'package:flutter/material.dart';

class MedicalTourismButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final MaterialStateProperty? backgroundColor;
  const MedicalTourismButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(224, 255, 255, 255)),
        foregroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.primary),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>(const Size(150, 50)),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: "Playfair Display"),
      ),
    );
  }
}
