// ignore_for_file: must_be_immutable

import 'package:GermAc/core/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HumanSide extends StatelessWidget {
  const HumanSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("Human Side"),
          style: const TextStyle(fontFamily: "Playfair Display"),
        ),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: const Color(0xff243253),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  tr("Why Choose Our Team ?"),
                  style: const TextStyle(
                      fontFamily: "Playfair Display",
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  tr("GermAc seeks to cooperate with the humanitarian team of the International German Academy of Medicine and Research (IGAMR), which in turn seeks, through a large number of doctors, donors and teams working with it, to provide humanitarian services that include sponsoring orphans, treating patients with medications, and performing surgical operations within a new mechanism that does not include the presence of intermediaries, but rather provide aid and assistance from the donor to the beneficiaries immediately."),
                  style: const TextStyle(
                      fontFamily: "Playfair Display",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomContainer(
                  first: "${tr("First:")}\n",
                  second:
                      tr("IGAMR facilitates donors access to beneficiaries."),
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomContainer(
                    first: "${tr("Second:")}\n",
                    second: tr(
                        "Present cases that need assistance to its donors so that they can be contacted directly.")),
                const SizedBox(
                  height: 12,
                ),
                CustomContainer(
                    first: "${tr("Third:")}\n",
                    second: tr("IGAMR does not receive any money.")),
                const SizedBox(
                  height: 24,
                ),
                Image.asset("assets/images/human.jpg"),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  tr("Guarantee Mechanism:"),
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Playfair Display",
                      color: Colors.white),
                ),
                Text(
                  tr("Our teams work in afflicted and poor areas, performing their humanitarian duty, and the work mechanism depends on the following:"),
                  style: const TextStyle(
                      fontFamily: "Playfair Display",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomContainerSecond(
                    first: tr("First"),
                    second: tr(
                        "Collecting data on orphans and patients and ensuring their status through visits by our team to eligible cases where they are located and photocopying documents that prove the actual need of those who deserve eligible for assistance.")),
                const SizedBox(
                  height: 12,
                ),
                CustomContainerSecond(
                    first: tr("Second"),
                    second: tr(
                        "We present reliable cases with documents to sponsors located in Germany and abroad in general.")),
                const SizedBox(
                  height: 12,
                ),
                CustomContainerSecond(
                    first: tr("Third"),
                    second: tr(
                        "If the sponsor chooses to help a specific case, we contact the sponsor and determine his identity if he is not known to us before.")),
                const SizedBox(
                  height: 12,
                ),
                CustomContainerSecond(
                    first: tr("Fourth"),
                    second: tr(
                        "We connect the donor to the recipient directly under our supervision.")),
                const SizedBox(
                  height: 12,
                ),
                CustomContainerSecond(
                    first: tr("Fifth"),
                    second: tr(
                        "The sponsor transfers the aid to the recipient directly and without intermediaries, and communicates with him throughout the period of sponsorship or treatment.")),
                const SizedBox(
                  height: 12,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  CustomContainer({super.key, required this.first, required this.second});
  String first, second;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 64,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColors.mainColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            first,
            style: const TextStyle(
                color: Colors.white, fontFamily: "Playfair Display"),
          ),
          Text(
            second,
            style: const TextStyle(
                color: Colors.white, fontFamily: "Playfair Display"),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class CustomContainerSecond extends StatelessWidget {
  CustomContainerSecond({super.key, required this.first, required this.second});
  String first, second;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 64,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColors.mainColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check,
                color: Colors.white,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                first,
                style: const TextStyle(
                    color: Colors.white, fontFamily: "Playfair Display"),
              ),
            ],
          ),
          Text(
            second,
            style: const TextStyle(
                color: Colors.white, fontFamily: "Playfair Display"),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
