import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/ustils.dart';
import 'package:GermAc/pages/section_detailes.dart';
import 'package:GermAc/widgets/error_page.dart';
import 'package:GermAc/widgets/loading_widget.dart';
import 'package:GermAc/widgets/section_card.dart';
import 'package:GermAc/providers/sections_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionsPage extends StatefulWidget {
  static const String id = 'sections';

  const SectionsPage({super.key});

  @override
  State<SectionsPage> createState() => _SectionsPageState();
}

class _SectionsPageState extends State<SectionsPage> {
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
          title: Text(
            tr('sections'),
            style: const TextStyle(fontFamily: "Playfair Display"),
          ),
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
                    tr('Ops! No Courses'),
                    style: const TextStyle(fontFamily: "Playfair Display"),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: ListView.builder(
                      itemBuilder: (context, index) => SectionCard(
                        title: sectionProvider.sectionModels[index].name,
                        imagePath: 'assets/images/about.jpg',
                        onTap: () {
                          Navigator.push(
                              context,
                              Utils.createRoute(SectionDetailedPage(
                                sectionId:
                                    sectionProvider.sectionModels[index].id,
                              )));
                          // await sectionProvider.getSectionDetails(
                          //     context, sectionProvider.sectionModels[index].id);
                        },
                      ),
                      itemCount: sectionProvider.sectionModels.length,
                    ),
                  ),
          ),
        );

      default:
        return const LoadingWidget();
    }
  }
}
