import 'package:GermAc/pages/about_us_page.dart';
import 'package:GermAc/pages/all_courses_page.dart';
import 'package:GermAc/pages/contact_us_page.dart';
import 'package:GermAc/pages/courses_page.dart';
import 'package:GermAc/pages/home_page.dart';
import 'package:GermAc/pages/medical_tourism.dart';
import 'package:GermAc/pages/developing_page.dart';
import 'package:GermAc/pages/services_page.dart';
import 'package:GermAc/pages/top_courses_page.dart';
import 'package:GermAc/pages/tourism_request.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRouter(RouteSettings routerSettings) {
    switch (routerSettings.name) {
      case HomePage.id:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case ServicesPage.id:
        return MaterialPageRoute(builder: (_) => const ServicesPage());
      case DevelopingPage.id:
        return MaterialPageRoute(builder: (_) => const DevelopingPage());
      case AllCoursesPage.id:
        return MaterialPageRoute(builder: (_) => const AllCoursesPage());
      case TopCoursesPage.id:
        return MaterialPageRoute(builder: (_) => const TopCoursesPage());
      case ContactUs.id:
        return MaterialPageRoute(builder: (_) => const ContactUs());
      case AboutUs.id:
        return MaterialPageRoute(builder: (_) => const AboutUs());
      case MedicalTourism.id:
        return MaterialPageRoute(builder: (_) => const MedicalTourism());
      case TourismRequest.id:
        return MaterialPageRoute(builder: (_) => const TourismRequest());

      case CoursesPage.id:
        return MaterialPageRoute(builder: (_) => const CoursesPage());
//       case CheckGSM.id:
//         return MaterialPageRoute(builder: (_) => CheckGSM());
//       case App.id:
//         return MaterialPageRoute(builder: (_) => App());
//       case Register.id:
//         return MaterialPageRoute(builder: (_) => Register());
//       case Verification.id:
//         return MaterialPageRoute(builder: (_) => Verification());
//       case SignIn.id:
//         return MaterialPageRoute(builder: (_) => SignIn());
//       case ResetPassword.id:
//         return MaterialPageRoute(builder: (_) => ResetPassword());
//       case CheckUpdateUI.id:
//         return MaterialPageRoute(builder: (_) => CheckUpdateUI());
//       case TermsOfUseAndPrivacyPolicy.id:
//         return MaterialPageRoute(builder: (_) => TermsOfUseAndPrivacyPolicy());
//       case AlaKefakPage.id:
//         return MaterialPageRoute(builder: (_) => AlaKefakPage());
//       // case AlakefakHistoryPage.id:
//       //   return MaterialPageRoute(builder: (_) => AlakefakHistoryPage(isAcitvated: ,));
//       case AlaKefakGift.id:
//         return MaterialPageRoute(builder: (_) => AlaKefakGift());
//       case AlaKefakVerificationPage.id:
//         return MaterialPageRoute(builder: (_) => AlaKefakVerificationPage());
//       case AlaKefakSendToPage.id:
//         return MaterialPageRoute(builder: (_) => AlaKefakSendToPage());
//       case AlakefakScaleUpPage.id:
//         return MaterialPageRoute(builder: (_) => AlakefakScaleUpPage());
//       case MyBillsPage.id:
//         return MaterialPageRoute(builder: (_) => MyBillsPage());

// //////////////////////////////////
//       case BalanceGiftingPage.id:
//         final args = routerSettings.arguments as Map;
//         return MaterialPageRoute(
//             builder: (_) => BalanceGiftingPage(
//                   serviceDesc: args['desc'],
//                   shareLink: args['share_link'],
//                   serviceCode: args['serviceID'],
//                 ));

//       case BalanceGiftingHistoryPage.id:
//         return MaterialPageRoute(builder: (_) => BalanceGiftingHistoryPage());

//       case BalanceGiftingVerificationPage.id:
//         return MaterialPageRoute(
//             builder: (_) => BalanceGiftingVerificationPage());

//       case JokerLinePage.id:
//         final args = routerSettings.arguments as Map;
//         return MaterialPageRoute(
//             builder: (_) => JokerLinePage(
//                   activateStatus: args['isLockServiceActivated'],
//                   price: args['price'],
//                   serviceDesc: args['desc'],
//                   shareLink: args['share_link'],
//                   serviceCode: args['serviceID'],
//                 ));

//       case MyNewNumbersPage.id:
//         final args = routerSettings.arguments as Map;
//         return MaterialPageRoute(
//             builder: (_) => MyNewNumbersPage(
//                   duration: args['duration'],
//                   price: args['price'],
//                   serviceDesc: args['desc'],
//                   shareLink: args['share_link'],
//                   serviceCode: args['serviceID'],
//                 ));

//       case FriendsAndFamilyPage.id:
//         final args = routerSettings.arguments as Map;
//         return MaterialPageRoute(
//             builder: (_) => FriendsAndFamilyPage(
//                   serviceDesc: args['desc'],
//                   shareLink: args['share_link'],
//                   serviceCode: args['serviceID'],
//                 ));

//       case MyNumbersPage.id:
//         final args = routerSettings.arguments as Map;
//         return MaterialPageRoute(
//             builder: (_) => MyNumbersPage(
//                   serviceDesc: args['desc'],
//                   shareLink: args['share_link'],
//                   serviceCode: args['serviceID'],
//                 ));

//       case MyNumbersVerificationPage.id:
//         final args = routerSettings.arguments as Map;
//         return MaterialPageRoute(
//             builder: (_) => MyNumbersVerificationPage(
//                   serviceDesc: args['desc'],
//                   shareLink: args['share_link'],
//                   serviceCode: args['serviceID'],
//                 ));
//       ///////////////////////////////////////
//       case SpecialServicesList.id:
//         return MaterialPageRoute(builder: (_) => SpecialServicesList());
//       case GuestApp.id:
//         return MaterialPageRoute(builder: (_) => GuestApp());

//       case LoyalityHomeUI.id:
//         return MaterialPageRoute(builder: (_) => LoyalityHomeUI());
//       case ServiceListUI.id:
//         return MaterialPageRoute(builder: (_) => ServiceListUI());
//       case PointsHistoryUI.id:
//         return MaterialPageRoute(builder: (_) => PointsHistoryUI());
//       case NotificationStatusUI.id:
//         return MaterialPageRoute(builder: (_) => NotificationStatusUI());
//       case PageIndicator.id:
//         return MaterialPageRoute(builder: (_) => PageIndicator());
//       case ServicesAndBundlesList.id:
//         return MaterialPageRoute(builder: (_) => ServicesAndBundlesList());
//       case ServicesAndBundlesPage.id:
//         return MaterialPageRoute(builder: (_) => ServicesAndBundlesPage());
//       case ManageGSMsPage.id:
//         return MaterialPageRoute(builder: (_) => ManageGSMsPage());
//       case DataGiftingPage.id:
//         return MaterialPageRoute(builder: (_) => DataGiftingPage());
//       case FreeSMSPage.id:
//         return MaterialPageRoute(builder: (_) => FreeSMSPage());
//       case ManageBlackListPage.id:
//         final args = routerSettings.arguments as Map;
//         return MaterialPageRoute(
//             builder: (_) => ManageBlackListPage(
//                   serviceDesc: args['desc'],
//                   shareLink: args['share_link'],
//                   serviceCode: args['serviceCode'],
//                 ));
//       case CallMeBackPage.id:
//         final args = routerSettings.arguments as Map;
//         return MaterialPageRoute(
//             builder: (_) => CallMeBackPage(
//                   desc: args['desc'],
//                   shareLink: args['share_link'],
//                   serviceCode: args['serviceCode'],
//                 ));

//       case BlackListService.id:
//         return MaterialPageRoute(builder: (_) => BlackListService());

//       case MePage.id:
//         return MaterialPageRoute(builder: (_) => MePage());

//       case EditMyProfilePage.id:
//         return MaterialPageRoute(builder: (_) => EditMyProfilePage());

//       case ActivityLogPage.id:
//         return MaterialPageRoute(builder: (_) => ActivityLogPage());

//       case ChangeTextPage.id: // for testing bloc statement
//         return MaterialPageRoute(builder: (_) => ChangeTextPage());

//       default:
//         return null;
    }
    return null;
  }
}
