import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/ustils.dart';
import 'package:GermAc/pages/doctor_details_appointment.dart';
import 'package:GermAc/widgets/doctors_card.dart';
import 'package:GermAc/widgets/error_page.dart';
import 'package:GermAc/widgets/loading_widget.dart';
import 'package:GermAc/providers/sections_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorConclusionsPage extends StatefulWidget {
  final String sectionId;
  const DoctorConclusionsPage({super.key, required this.sectionId});

  @override
  State<DoctorConclusionsPage> createState() => _DoctorConclusionsPageState();
}

class _DoctorConclusionsPageState extends State<DoctorConclusionsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<SectionProvider>()
        .getDoctorsInSection(context, widget.sectionId);
  }

  @override
  Widget build(BuildContext context) {
    final sectionProvider = Provider.of<SectionProvider>(context);
    // final sectionProvider = context.watch<SectionProvider>();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            tr('Online Cosulutions'),
            style: const TextStyle(
              fontFamily: "Playfair Display",
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
          foregroundColor: Colors.white,
        ),
        body: getBody(sectionProvider, context));
  }

  Widget getBody(SectionProvider sectionProvider, BuildContext context) {
    switch (sectionProvider.state) {
      case ERROR_STATE:
        return ErrorPage(
          errorMessage: sectionProvider.errorMessage,
          callBack: () async {
            setState(() {
              sectionProvider.state = LOADING_STATE;
            });
            await sectionProvider.getOnlineConclusionsSections(context);
          },
        );
      case SUCCESS_STATE:
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(color: Color(0xff243253)),
          child: Column(
            children: [
              Text(
                tr('Doctors'),
                style: const TextStyle(
                    fontFamily: "Playfair Display",
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Text(
                  tr("Our team of highly skilled and experienced doctors is committed to providing exceptional medical care and personalized attention to every patient, utilizing the latest medical technology and evidence-based practices to ensure the best possible outcomes and quality of life for all those under our care."),
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Playfair Display",
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: Center(
                  child: sectionProvider.doctorModels.isEmpty
                      ? Text(tr('Ops! No Doctors'))
                      : SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: ListView.builder(
                            shrinkWrap: false,
                            itemBuilder: (context, index) => DoctorCard(
                              doctorModel:
                                  sectionProvider.doctorModels.elementAt(index),
                              onPressedStartConversation: () {
                                sectionProvider.storeConversation(context,
                                    sectionProvider.doctorModels[index].id);
                              },
                              onPressedShowAppointment: () {
                                Navigator.of(context).push(Utils.createRoute(
                                  DetailsPage(
                                      cur_workplace: "",
                                      specialization: sectionProvider
                                          .doctorModels
                                          .elementAt(index)
                                          .specialization,
                                      experiences: "",
                                      prof_title: "",
                                      doctor_id: sectionProvider.doctorModels
                                          .elementAt(index)
                                          .id),
                                ));
                              },
                            ),
                            itemCount: sectionProvider.doctorModels.length,
                          ),
                        ),
                ),
              ),
            ],
          ),
        );

      default:
        return const LoadingWidget();
    }
  }
}
