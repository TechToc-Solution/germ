import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/theme/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.flickr(
        // color: primaryColor,
        leftDotColor: primaryColor,
        rightDotColor: AppColors.mainColor,
        size: 80,
      ),
    );
  }
}
