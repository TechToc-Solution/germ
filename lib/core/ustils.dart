import 'package:GermAc/core/theme/palette.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Utils {
  static PageRouteBuilder createRoute(Widget secondScreen) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Slide from right to left
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return secondScreen;
      },
    );
  }

  static Widget showLoadingWidget() {
    return Center(
      child: LoadingAnimationWidget.flickr(
        // color: primaryColor,
        leftDotColor: primaryColor,
        rightDotColor: const Color(0xfff9e8b8),
        size: 80,
      ),
    );
  }

  static Widget showErrorWidget(String errorMessage, Function()? callBack) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            color: primaryColor,
            size: 60,
          ),
          Text(
            errorMessage,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 16)),
          MaterialButton(
              onPressed: callBack,
              color: primaryColor,
              child: Text(tr('retry'))),
        ],
      ),
    );
  }

  static showErrorSnackBar(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(message: message),
    );
  }

  static showSuccessSnackBar(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(message: message),
    );
  }

  static bool isEmailValid(String email) {
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}

// Widget customAvatarBuilder(
//   BuildContext context,
//   Size size,
//   ZegoUIKitUser? user,
//   Map<String, dynamic> extraInfo,
// ) {
//   return CachedNetworkImage(
//     imageUrl: 'https://robohash.org/${user?.id}.png',
//     imageBuilder: (context, imageProvider) => Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         image: DecorationImage(
//           image: imageProvider,
//           fit: BoxFit.cover,
//         ),
//       ),
//     ),
//     progressIndicatorBuilder: (context, url, downloadProgress) =>
//         CircularProgressIndicator(value: downloadProgress.progress),
//     errorWidget: (context, url, error) {
//       ZegoLoggerService.logInfo(
//         '$user avatar url is invalid',
//         tag: 'live audio',
//         subTag: 'live page',
//       );
//       return ZegoAvatar(user: user, avatarSize: size);
//     },
//   );
// }
