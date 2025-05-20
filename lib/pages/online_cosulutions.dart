import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/models/shared_class.dart';
import 'package:GermAc/core/ustils.dart';
import 'package:GermAc/pages/auth/login.dart';
import 'package:GermAc/pages/doctors_conclusions.dart';
import 'package:GermAc/widgets/error_page.dart';
import 'package:GermAc/widgets/loading_widget.dart';
import 'package:GermAc/widgets/section_card.dart';
import 'package:GermAc/providers/sections_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class OnlineConclusionsPage extends StatefulWidget {
  const OnlineConclusionsPage({super.key});

  @override
  State<OnlineConclusionsPage> createState() => _OnlineConclusionsPageState();
}

class _OnlineConclusionsPageState extends State<OnlineConclusionsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SectionProvider>().getOnlineConclusionsSections(context);
  }

  @override
  Widget build(BuildContext context) {
    final sectionProvider = Provider.of<SectionProvider>(context);
    // final sectionProvider = context.watch<SectionProvider>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          foregroundColor: Colors.white,
          centerTitle: true,
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
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(color: Color(0xff243253)),
          child: Column(
            children: [
              Text(
                tr(
                  'Online Cosulutions',
                ),
                style: const TextStyle(
                    fontSize: 26,
                    fontFamily: "Playfair Display",
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Text(
                  tr('we offer you medical consultations online, and you must now select the specialty for this medical consultation by clicking on the consultation and follow up.'),
                  style: const TextStyle(
                      fontFamily: "Playfair Display",
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: Center(
                  child: sectionProvider.sectionModels.isEmpty
                      ? Text(
                          tr('Ops! No Section'),
                          style:
                              const TextStyle(fontFamily: "Playfair Display"),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: ListView.builder(
                            itemBuilder: (context, index) => SectionCard(
                              title: sectionProvider.sectionModels[index].name,
                              imagePath: 'assets/images/about.jpg',
                              onTap: () async {
                                if (SharedClass.userToken != '') {
                                  Navigator.of(context).push(Utils.createRoute(
                                    DoctorConclusionsPage(
                                      sectionId: sectionProvider
                                          .sectionModels[index].id,
                                    ),
                                  ));
                                } else {
                                  Navigator.of(context).push(
                                      Utils.createRoute(const LoginPage()));
                                }
                              },
                            ),
                            itemCount: sectionProvider.sectionModels.length,
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
