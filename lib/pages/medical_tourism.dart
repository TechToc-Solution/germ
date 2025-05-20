// ignore_for_file: must_be_immutable

import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/ustils.dart';
import 'package:GermAc/pages/tourism_request.dart';
import 'package:GermAc/widgets/medical_tour_button.dart';
import 'package:GermAc/providers/home_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class MedicalTourism extends StatefulWidget {
  static const String id = 'MEDICALTOURISM';

  const MedicalTourism({super.key});

  @override
  State<MedicalTourism> createState() => _MedicalTourismState();
}

class _MedicalTourismState extends State<MedicalTourism> {
  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Color(0xff243253)),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Container(
                      padding: const EdgeInsets.only(top: 20),
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                            color: Color.fromARGB(218, 255, 82, 82), width: 4),
                      )),
                      child: Text(
                        tr('Medical Tourism'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: "Playfair Display",
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                  .animate()
                  .fadeIn(duration: 200.ms)
                  .moveY(duration: 400.ms, end: -10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  tr('The German Academy (GermAc) adopts a new strategy in the field of medical tourism that aims to reduce the financial burdens and efforts required for medical travel for patients whenever possible. This strategy is based on the following:'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Playfair Display",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 200.ms)
                    .moveY(duration: 400.ms, end: -10),
              ),
              const SizedBox(
                height: 30,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 150,
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
                height: 20,
              ),
              MedicalTourismButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(Utils.createRoute(const TourismRequest()));
                  },
                  title: tr('Book Now')),
              const SizedBox(
                height: 24,
              ),
              CustomContainerSecondTourism(
                first: tr("First"),
                icon: const Icon(
                  Icons.announcement,
                  color: Colors.white,
                ),
                second: tr(
                    "Communication between the patient or the medical centers responsible for the patient with consultants and experts in Germany directly through virtual reality or through visits made by doctors to the Gulf region."),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomContainerSecondTourism(
                first: tr("Second"),
                second: tr(
                    "Consultant doctors in Germany review the complete medical reports and may request additional tests if necessary."),
                icon: const Icon(
                  Icons.assignment_outlined,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomContainerSecondTourism(
                  first: tr("Third"),
                  second: tr(
                      "After reviewing the reports on the patient's condition in detail, the consultant doctors study the procedure of treatment and surgical operations within the medical centers and hospitals contracted with GermAc in the Gulf region during the visits made by medical committees to these centers according to the agreed upon dates."),
                  icon: const Icon(
                    Icons.medical_information,
                    color: Colors.white,
                  )),
              const SizedBox(
                height: 12,
              ),
              CustomContainerSecondTourism(
                  first: tr("Fourth"),
                  second: tr(
                      "If the patient's condition requires traveling to Germany due to the lack of the required equipment or techniques, the consulting physician informs the patients or the medical center about this decision and works to determine the dates of treatment, surgical operations and the schedule for that in Germany."),
                  icon: const Icon(
                    Icons.heart_broken,
                    color: Colors.white,
                  )),
              const SizedBox(
                height: 12,
              ),
              CustomContainerSecondTourism(
                  first: tr("Fifth"),
                  second: tr(
                      "GermAc team sends the medical reports issued by the consultants, which specify the need for medical travel, to the German embassies to issue medical visas when needed."),
                  icon: const Icon(
                    Icons.local_pharmacy_outlined,
                    color: Colors.white,
                  )),
              const SizedBox(
                height: 12,
              ),
              CustomContainerSecondTourism(
                  first: tr("Sixth"),
                  second: tr(
                      "The German Academy (GermAc) team helps patients and their families in providing other services for accommodation in Germany, such as hotel reservations, providing translators, companions and other services based on the patient's needs and requirements."),
                  icon: const Icon(
                    Icons.hourglass_empty_outlined,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
        // Replace `YourContentWidget` with your actual content
      ),
    );
  }
}

class CustomContainerSecondTourism extends StatelessWidget {
  CustomContainerSecondTourism(
      {super.key,
      required this.first,
      required this.second,
      required this.icon});
  String first, second;
  Icon icon;
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
              icon,
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
