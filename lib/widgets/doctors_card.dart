import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/theme/palette.dart';
import 'package:GermAc/models/doctor_model.dart';
import 'package:GermAc/providers/sections_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctorModel;

  final Function()? onPressedStartConversation;
  final Function()? onPressedShowAppointment;
  const DoctorCard(
      {super.key,
      required this.doctorModel,
      this.onPressedStartConversation,
      this.onPressedShowAppointment});

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Provider.of<SectionProvider>(context).state == LOADING_STATE,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.mainColor,
            width: 2.0, // Adjust the width as desired
          ),
          borderRadius: BorderRadius.circular(16.0), // Adjust the border radius
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 5, // Spread radius
              blurRadius: 7, // Blur radius
              offset: const Offset(0, 3), // Offset
            ),
          ],
        ),
        child: Column(
          children: [
            EasyLocalization.of(context)?.currentLocale == const Locale("en")
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 30,
                        child: Image(
                          image: NetworkImage(
                            doctorModel.image,
                          ),
                          errorBuilder: (context, error, stackTrace) =>
                              CircleAvatar(
                            backgroundColor: AppColors.mainColor,
                            child:
                                const Icon(Icons.person, color: Colors.white),
                          ),
                          width: 100,
                          height: 100,
                        ),
                      ),
                      // Image.network(imagePath),

                      Expanded(
                        child: Text(
                          doctorModel.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Playfair Display",
                              color: Color(0xff2C4964)),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          doctorModel.name,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Playfair Display",
                              color: Color(0xff2C4964)),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 30,
                        child: Image(
                          image: NetworkImage(
                            doctorModel.image,
                          ),
                          errorBuilder: (context, error, stackTrace) =>
                              CircleAvatar(
                            backgroundColor: AppColors.mainColor,
                            child:
                                const Icon(Icons.person, color: Colors.white),
                          ),
                          width: 100,
                          height: 100,
                        ),
                      ),
                      // Image.network(imagePath),
                    ],
                  ),

            /*Center(
              child: Text(
                doctorModel.email,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),*/

            const Divider(
              color: Color(0xff2C4964),

              // endIndent: 50,
              // indent: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: primaryColor,
                  onPressed: onPressedShowAppointment,
                  child: Text(
                    tr('See Details'),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Playfair Display",
                        color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
