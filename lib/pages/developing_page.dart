import 'package:GermAc/core/constant.dart';
import 'package:GermAc/widgets/error_page.dart';
import 'package:GermAc/widgets/loading_widget.dart';
import 'package:GermAc/providers/sections_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DevelopingPage extends StatefulWidget {
  static const String id = 'sections';

  const DevelopingPage({super.key});

  @override
  State<DevelopingPage> createState() => _DevelopingPageState();
}

class _DevelopingPageState extends State<DevelopingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SectionProvider>().getSections(context);
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
            await sectionProvider.getSections(context);
          },
        );
      case SUCCESS_STATE:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(color: Color(0xff243253)),
          child: Center(
            child: sectionProvider.sectionModels.isEmpty
                ? Text(
                    tr('Ops! No Content'),
                    style: const TextStyle(fontFamily: "Playfair Display"),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          NewCard(
                            text: tr(
                                "The German Academy of Consulting and Training (GermAc), offers Its services in developing universities and innovative educational facilities that meet the highest quality standards and represents a turning point in education and health in the Arab region."),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          NewCard(
                              text: tr(
                                  "We aim at the German Academy of Consulting and Training to contribute to the formation of the future of education and health in the region by supervising the establishment of educational and medical facilities under construction, new or list that can interact with all technological and educational developments and be a center for innovation quality and modernity in education and health. These enterprises follow strict German quality guidance and will provide high-quality German standards in collaboration with universities, scientific and prestigious German medical centers.")),
                          const SizedBox(
                            height: 24,
                          ),
                          NewCard(
                              text:
                                  "The German Academy (GermAc) will be scientific and development supervisor on medical and educational facilities, which provides guarantee German quality standards and manage all operations that will lead to the recognition and accreditation of German credit."),
                          const SizedBox(
                            height: 24,
                          ),
                          NewCard(
                              text:
                                  "The German Academy (GermAc) with its consulting unity is the central scientific engine of newly established projects. Our consultants will consult with the owner and other teams in their quest for the construction framework for the project and will implement all the necessary steps to make the project compatible with German and international standards."),
                          const SizedBox(
                            height: 24,
                          ),
                          NewCard(
                              text:
                                  "The German Academy (GermAc) will oversee the quality of every step of the project to ensure that the hospital, school and university will eventually agree to German standards and get international accreditation by a German dependence."),
                          const SizedBox(
                            height: 24,
                          ),
                          NewCard(
                              text:
                                  "The German Academy (GermAc) will provide its wide networks in the German university environment, scientific and medical centers and will coordinate with German academic exchange service (DAAD) with a prestigious global reputation. The Academy will also provide consultants and experts with high competencies in medical, administrative and academic fields whenever needed."),
                          const SizedBox(
                            height: 24,
                          ),
                          NewCard(
                              text:
                                  "Whatever step is taken, it aims to achieve maximum quality standards according to the owner's vision for the project."),
                          const SizedBox(
                            height: 24,
                          ),
                          NewCard(
                              text:
                                  "The German Academy (GermAc) is working with a group of the best universities, hospitals and German companies and with a selection of senior German doctors and consultants Germans specialized in the development and management of educational and health facilities in accordance with the full global German standers in terms of efficiency and quality."),
                          const SizedBox(
                            height: 24,
                          )
                        ],
                      ),
                    )),
          ),
        );

      default:
        return const LoadingWidget();
    }
  }
}

// ignore: must_be_immutable
class NewCard extends StatelessWidget {
  NewCard({super.key, required this.text});
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.mainColor, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          const Icon(
            Icons.shield,
            color: Colors.white,
          ),
          Text(
            tr(
              text,
            ),
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: "Playfair Display"),
          ),
        ],
      ),
    );
  }
}
