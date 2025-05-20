import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? callBack;

  const ErrorPage({super.key, this.callBack, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/error.png",
              height: 200.0.sp,
              opacity: const AlwaysStoppedAnimation<double>(0.5)),
          Text(
            errorMessage,
            style: TextStyle(
              fontSize: 40.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "Playfair Display",
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 15.sp)),
          ElevatedButton(
              onPressed: callBack ?? () {}, child: const Text('Retry')),
        ],
      ),
    );
  }
}
