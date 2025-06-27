// ignore_for_file: use_build_context_synchronously

import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/models/shared_class.dart';
import 'package:GermAc/core/network/data_loader.dart';
import 'package:GermAc/core/services/shared_preference_manager.dart';
import 'package:GermAc/core/ustils.dart';
import 'package:GermAc/pages/about_us_page.dart';
import 'package:GermAc/pages/auth/login.dart';
import 'package:GermAc/pages/courses_page.dart';
import 'package:GermAc/pages/feedback_page.dart';
import 'package:GermAc/pages/home_page.dart';
import 'package:GermAc/pages/human_side.dart';
import 'package:GermAc/pages/medical_tourism.dart';
import 'package:GermAc/pages/online_cosulutions.dart';
import 'package:GermAc/pages/developing_page.dart';
import 'package:GermAc/pages/partners.dart';
import 'package:GermAc/pages/sections_page.dart';
import 'package:GermAc/pages/user_profile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:one_context/one_context.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomNavigationDrawer extends StatefulWidget {
  const CustomNavigationDrawer({super.key});

  @override
  State<CustomNavigationDrawer> createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          buildMenuItems(context),
        ],
      )),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      color: const Color(0xff243253),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50,
            backgroundImage: AssetImage('assets/images/logo.png'),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(tr('GermAc'),
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontFamily: "Playfair Display",
              )),
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      child: Wrap(
        runSpacing: 16,
        children: [
          SharedClass.email == ''
              ? ListTile(
                  leading: const Icon(Icons.login_outlined),
                  title: Text(
                    tr('login'),
                    style: const TextStyle(
                      fontFamily: "Playfair Display",
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context, Utils.createRoute(const LoginPage()));
                  },
                )
              : ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: Text(
                    tr('profile'),
                    style: const TextStyle(
                      fontFamily: "Playfair Display",
                    ),
                  ),
                  onTap: () {
                    launchUrl(Uri.parse(DataLoader.profile));
                    // Navigator.push(
                    //     context, Utils.createRoute(const UserProfilePage()));
                  },
                ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: Text(
              tr('home'),
              style: const TextStyle(
                fontFamily: "Playfair Display",
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                  context, Utils.createRoute(const HomePage()));
            },
          ),
          ExpansionTile(
            leading: Image.asset(
              'assets/images/logo.png',
              width: 30,
              height: 30,
            ),
            title: Text(
              tr('GermAc Services'),
              style: const TextStyle(
                fontFamily: "Playfair Display",
              ),
            ),
            childrenPadding: const EdgeInsets.only(left: 60),
            children: [
              ListTile(
                title: SizedBox(
                  height: 30,
                  width: 30,
                  child: Marquee(
                    text: ' ${tr("Online Consultation from Germany")} ',
                    style: const TextStyle(
                      fontFamily: "Playfair Display",
                    ),
                  ),
                ),
                onTap: () {
                  launchUrl(Uri.parse(DataLoader.onlineConsulution));
                  // Navigator.of(context)
                  //     .push(Utils.createRoute(const OnlineConclusionsPage()));
                },
              ),
              ListTile(
                title: SizedBox(
                  height: 30,
                  width: 30,
                  child: Marquee(
                    text:
                        " ${tr(' Online courses and training from Germany ')}  ",
                    style: const TextStyle(
                      fontFamily: "Playfair Display",
                    ),
                  ),
                ),
                onTap: () {
                  // Navigator.of(context)
                  //     .push(Utils.createRoute(const CoursesPage()));
                  launchUrl(Uri.parse(DataLoader.onlineCourses));
                },
              ),
              ListTile(
                // leading: const Icon(Icons.tour_outlined),
                title: Text(
                  tr('Medical Tourism Worldwide'),
                  style: const TextStyle(
                    fontFamily: "Playfair Display",
                  ),
                ),
                onTap: () {
                  launchUrl(Uri.parse(DataLoader.medicalToursimWorldwide));
                  // Navigator.of(context)
                  //     .push(Utils.createRoute(const MedicalTourism()));
                },
              ),
              ListTile(
                // leading: const Icon(Icons.tour_outlined),
                title: Text(
                  tr('Medical Tourism'),
                  style: const TextStyle(
                    fontFamily: "Playfair Display",
                  ),
                ),
                onTap: () {
                  launchUrl(Uri.parse(DataLoader.medicalToursim));
                  // Navigator.of(context)
                  //     .push(Utils.createRoute(const MedicalTourism()));
                },
              ),
              ListTile(
                title: SizedBox(
                  height: 30,
                  width: 30,
                  child: Marquee(
                    text:
                        "  ${tr('Developing Medical and Educational Facilities')}  ",
                    style: const TextStyle(
                      fontFamily: "Playfair Display",
                    ),
                  ),
                ),
                onTap: () {
                  // Navigator.of(context)
                  //     .push(Utils.createRoute(const DevelopingPage()));
                  launchUrl(Uri.parse(DataLoader.developingMedical));
                },
              ),
              // ListTile(
              //   title: Text(
              //     tr("sections"),
              //     style: const TextStyle(
              //       fontFamily: "Playfair Display",
              //     ),
              //   ),
              //   onTap: () {
              //     launchUrl(Uri.parse(DataLoader.sections));
              //     // Navigator.of(context)
              //     //     .push(Utils.createRoute(const SectionsPage()));
              //   },
              // ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.medical_information_outlined),
            title: Text(
              tr('Human Side'),
              style: const TextStyle(
                fontFamily: "Playfair Display",
              ),
            ),
            onTap: () {
              launchUrl(Uri.parse(DataLoader.humanSide));
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) {
              //     return const HumanSide();
              //   },
              // ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.handshake),
            title: Text(
              tr("become_a_partner"),
              style: const TextStyle(
                fontFamily: "Playfair Display",
              ),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PartnerPage()),
            ),
          ),

          // ListTile(
          //   leading: const Icon(Icons.chat),
          //   title: const Text('Test Chat'),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => TestChat(),
          //         ));
          //   },
          // ),
          const GoLive(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.book_online),
            title: Text(
              tr('about_us'),
              style: const TextStyle(
                fontFamily: "Playfair Display",
              ),
            ),
            onTap: () {
              launchUrl(Uri.parse(DataLoader.aboutUs));
              //Navigator.of(context).push(Utils.createRoute(const AboutUs()));
            },
          ),
          ExpansionTile(
            leading: const Icon(
              Icons.translate,
              size: 32,
              color: Color(0xff222222),
            ),
            title: Text(
              tr('language'),
              style: const TextStyle(
                fontFamily: "Playfair Display",
              ),
            ),
            children: [
              ListTile(
                title: Text(
                  tr('english'),
                  style: const TextStyle(
                    fontFamily: "Playfair Display",
                  ),
                ),
                onTap: () async {
                  EasyLocalization.of(context)!.setLocale(const Locale('en'));
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.setString('locale', 'en');
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
              ListTile(
                title: Text(
                  tr('arabic'),
                  style: const TextStyle(
                    fontFamily: "Playfair Display",
                  ),
                ),
                onTap: () async {
                  EasyLocalization.of(context)!.setLocale(const Locale('ar'));
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.setString('locale', 'ar');
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.contact_support_outlined),
            title: Text(
              tr('ContactUs'),
              style: const TextStyle(
                fontFamily: "Playfair Display",
              ),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FeedbackPage()),
            ),
          ),
          SharedClass.userId == ''
              ? Container()
              : ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: Text(
                    tr('logout'),
                    style: const TextStyle(
                      fontFamily: "Playfair Display",
                    ),
                  ),
                  onTap: () async {
                    await logout(context);
                  },
                )
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    //String responseMessage = '';
    // OneContext()
    //     .showProgressIndicator(builder: (_) => Utils.showLoadingWidget());
    // final response =
    //     await DataLoader.postRequest(url: DataLoader.logoutURL, headers: {
    //   'Authorization': 'Bearer ${SharedClass.userToken}',
    //   'Content-Type': 'application/json',
    //   "Accept-Charset": "application/json",
    // }, body: {});

    // if (response.code == SUCCESS_CODE) {
    //   responseMessage = response.message;
    //   // OneContext().hideProgressIndicator();
    //   Utils.showSuccessSnackBar(context, responseMessage);
    await SharedPreferenceManager().delete();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("key");
    pref.remove("id");
    pref.remove("roleId");
    pref.remove("name");
    pref.remove("email");
    pref.remove("work");
    pref.remove("fcm_token");
    pref.remove("token");
    Navigator.pushAndRemoveUntil(
      context,
      Utils.createRoute(const HomePage()),
      (route) => false,
    );
    // } else {
    //   OneContext().hideProgressIndicator();

    //   responseMessage = response.message;

    //   Utils.showErrorSnackBar(context, tr(responseMessage));
    // }
  }
}

Future<int?> getroleid() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt("roleId");
}

class GoLive extends StatelessWidget {
  const GoLive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getroleid(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == 3) {
            return ListTile(
              leading: const Icon(Icons.live_tv),
              title: Text(
                tr('Go Live'),
                style: const TextStyle(
                  fontFamily: "Playfair Display",
                ),
              ),
              onTap: () {
                launchUrl(Uri.parse("https://germ-ac.com/streaming"));
              },
            );
          } else {
            return const SizedBox();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
