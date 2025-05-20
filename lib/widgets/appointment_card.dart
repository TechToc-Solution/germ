import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String date;
  final int price;
  final Function() onPressed;
  const AppointmentCard(
      {super.key,
      required this.date,
      required this.onPressed,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Appointment Date',
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Playfair Display",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4.0),
            Text(
              date + " UAE",
              style: const TextStyle(
                  fontSize: 16.0,
                  fontFamily: "Playfair Display",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              "price :",
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Playfair Display",
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "${price.toString()}\$",
              style: const TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Playfair Display",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4.0),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text(
                'Book',
                style: TextStyle(
                  fontFamily: "Playfair Display",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
