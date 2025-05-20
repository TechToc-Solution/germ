// ignore_for_file: must_be_immutable

import 'package:GermAc/core/constant.dart';
import 'package:GermAc/providers/home_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class AboutUs extends StatelessWidget {
  static const String id = 'ABOUT_US';

  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Color(0xff243253)),
        padding: const EdgeInsets.all(6),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Text(
                tr('Who We Are'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Playfair Display",
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              )
                  .animate()
                  .fadeIn(duration: 200.ms)
                  .moveY(duration: 400.ms, end: -10),
              const SizedBox(
                height: 30,
              ),
              // Image.asset(
              //   width: 450.w,
              //   height: 600.h,
              //   'assets/images/about.jpg',
              //   fit: BoxFit.cover,
              // ),
              // SizedBox(
              //   width: 10,
              // ),
              Column(
                children: [
                  Text(
                    tr('GermAc, the German Academy, is considered the first registered academic consulting and training center in the Middle East, located in Dubai. It offers unique services directly from Germany and through the most skilled German doctors and academics. Our services include:'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Playfair Display",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 200.ms)
                      .moveY(duration: 400.ms, end: -10),
                ],
              ),

              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  aspectRatio: 16 / 9,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
                items:
                    context.read<HomeProvider>().sliderImagesPath.map((path) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Image.asset(
                            path,
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 150,
                          ));
                    },
                  );
                }).toList(),
              ),

              const SizedBox(
                height: 12,
              ),
              Text(
                tr("Medical Fields"),
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "Playfair Display",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomContainerAboutUs(
                  first: tr("First"),
                  second: tr(
                      "Providing remote medical consultations directly to patients from Germany through a select group of top doctors located in prestigious German hospitals, using the latest visual and audio communication technologies that the Center has prepared for this purpose.")),
              const SizedBox(
                height: 12,
              ),
              CustomContainerAboutUs(
                  first: tr("Second"),
                  second: tr(
                      "Providing medical consultations to medical centers in order to participate in developing diagnostic and treatment plans for medical conditions present in these centers.")),
              const SizedBox(
                height: 12,
              ),
              CustomContainerAboutUs(
                  first: tr("Third"),
                  second: tr(
                      "Providing training courses for doctors and medical students on the latest findings in medical science and technology.")),
              const SizedBox(
                height: 12,
              ),
              CustomContainerAboutUs(
                  first: tr("Fourth"),
                  second: tr(
                      "Continuously providing contracting medical centers in the Gulf region with the latest diagnostic and treatment protocols and modern medical technologies.")),
              const SizedBox(
                height: 12,
              ),
              CustomContainerAboutUs(
                  first: tr("Fifth"),
                  second: tr(
                      "Providing training courses in the fields of artificial intelligence and its medical applications, presented by the most important experts in this field in Germany.")),
              const SizedBox(
                height: 12,
              ),
              Image.asset("assets/images/about-2.jpg"),
              const SizedBox(
                height: 24,
              ),

              Text(
                tr("The center also aims to provide the following services within the Gulf countries:"),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Playfair Display",
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomContainerAboutUs(
                  first: tr("First"),
                  second: tr(
                      "Organizing regular short visits to German medical committees to medical centers and hospital in the Gulf region to provide medical advisory services for difficult and complex cases that require direct communication between the doctor and the patient, in addition to performing surgical operations and applying the latest innovative treatment methods.")),
              const SizedBox(
                height: 12,
              ),
              CustomContainerAboutUs(
                  first: tr("Second"),
                  second: tr(
                      "Organizing short and periodic visits for doctors, academics and technicians from Germany to conduct training courses for doctors and medical students in medical centers, hospitals and universities in the Gulf countries.")),
              const SizedBox(
                height: 12,
              ),
              CustomContainerAboutUs(
                  first: tr("Third"),
                  second: tr(
                      "Proposing a new strategy for medical tourism for cases that require travelling to Germany for the purpose of treatment, and it depends on reducing the financial burdens and stress resulting from travelling of patients as much as possible after exhausting all treatment attempts and performing surgical operations by German consultants within the medical centers contracted with the German Academy (GermAc) in the Gulf region.")),
              const SizedBox(
                height: 24,
              ),
              Text(
                tr("Non-Medical Fields"),
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "Playfair Display",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                tr("The German Academy (GermAc) seeks to provide training courses and educational programs in various technical, administrative and media fields by experts and academics from Germany."),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Playfair Display",
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Image.asset("assets/images/about-3.jpg")
            ],
          ),
        ),
      ),
    );
  }
}

class CustomContainerAboutUs extends StatelessWidget {
  CustomContainerAboutUs(
      {super.key, required this.first, required this.second});
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
