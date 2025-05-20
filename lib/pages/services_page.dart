import 'package:GermAc/core/ustils.dart';
import 'package:GermAc/pages/courses_page.dart';
import 'package:GermAc/pages/medical_tourism.dart';
import 'package:GermAc/pages/online_cosulutions.dart';
import 'package:GermAc/pages/developing_page.dart';
import 'package:GermAc/widgets/services_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServicesPage extends StatefulWidget {
  static const String id = 'services';
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ServicesCard(
            useMarquee: false,
            width: MediaQuery.of(context).size.width / 1.1,
            heigh: 400.h,
            icon: Icons.palette,
            title: 'Education',
            desc: 'Sections and courses in our website',
            onTap: () => Navigator.of(context)
                .push(Utils.createRoute(const DevelopingPage())),
            dimage: const DecorationImage(
                image: AssetImage("assets/images/service_back3.jpg"),
                fit: BoxFit.cover),
          ),
          const SizedBox(
            height: 10,
          ),
          ServicesCard(
            useMarquee: false,
            width: MediaQuery.of(context).size.width / 1.1,
            heigh: 400.h,
            icon: Icons.air_rounded,
            title: ' Online Cosulution ',
            desc:
                ' we offer you medical consultations online, and you must now select the specialty for this medical consultation by clicking on the consultation and follow-up. ',
            onTap: () => Navigator.of(context)
                .push(Utils.createRoute(const OnlineConclusionsPage())),
            dimage: const DecorationImage(
                image: AssetImage("assets/images/service_back3.jpg"),
                fit: BoxFit.cover),
          ),
          const SizedBox(
            height: 10,
          ),
          ServicesCard(
            useMarquee: false,
            width: MediaQuery.of(context).size.width / 1.1,
            heigh: 400.h,
            icon: Icons.pin,
            title: 'Human side ',
            desc:
                ' We are team of talented doctors and We have a human side that we would like you to know ',
            onTap: () => Navigator.of(context)
                .push(Utils.createRoute(const CoursesPage())),
            dimage: const DecorationImage(
                image: AssetImage("assets/images/service_back3.jpg"),
                fit: BoxFit.cover),
          ),
          const SizedBox(
            height: 10,
          ),
          ServicesCard(
            useMarquee: false,
            width: MediaQuery.of(context).size.width / 1.1,
            heigh: 400.h,
            icon: Icons.palette,
            title: tr('Medical Tourism'),
            desc:
                ' we provides medical tourism services to receive treatment abroad for all medical cases in the best and most prestigious universities and hospitals in the world.  ',
            onTap: () => Navigator.of(context)
                .push(Utils.createRoute(const MedicalTourism())),
            dimage: const DecorationImage(
                image: AssetImage("assets/images/service_back3.jpg"),
                fit: BoxFit.cover),
          ),
          const SizedBox(
            height: 10,
          ),
          ServicesCard(
            useMarquee: false,
            width: MediaQuery.of(context).size.width / 1.1,
            heigh: 400.h,
            icon: Icons.air_rounded,
            title: 'Medical facilities medical facilities',
            desc: '',
            onTap: () => Navigator.of(context)
                .push(Utils.createRoute(const DevelopingPage())),
            dimage: const DecorationImage(
                image: AssetImage("assets/images/service_back3.jpg")),
          ),
        ],
      ),
    );
  }
}
