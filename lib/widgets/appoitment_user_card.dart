// ignore_for_file: must_be_immutable

import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/models/shared_class.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppoitmentUserCard extends StatelessWidget {
  AppoitmentUserCard(
      {super.key,
      required this.drName,
      required this.price,
      required this.date,
      required this.onpressed,
      required this.onpressedDelete});
  String drName, price, date;
  VoidCallback onpressed, onpressedDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.mainColor, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: AppColors.mainColor),
              ),
              const SizedBox(
                width: 24,
              ),
              Text(
                drName == tr("Free appoitment")
                    ? drName
                    : (SharedClass.roleId == '3')
                        ? "${tr("User Name")} : $drName"
                        : "${tr("Dr Name")} : $drName",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: "Playfair Display",
                ),
              ),
            ],
          ),
          Text(
            tr("Date"),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Playfair Display",
            ),
          ),
          Text(
            "${date} UAE",
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: "Playfair Display",
            ),
          ),
          Text(
            "${tr("Price")} : $price\$",
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: "Playfair Display",
            ),
          ),
          SharedClass.roleId != '3'
              ? ElevatedButton(
                  onPressed: onpressed,
                  child: Text(
                    tr("Chat"),
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 18,
                      fontFamily: "Playfair Display",
                    ),
                  ))
              : ElevatedButton(
                  onPressed: onpressedDelete,
                  child: Text(
                    tr("Delete"),
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 18,
                      fontFamily: "Playfair Display",
                    ),
                  ))
        ],
      ),
    );
  }
}
