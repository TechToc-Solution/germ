// import 'dart:math';

// import 'package:GermAc/core/models/shared_class.dart';
// import 'package:GermAc/core/ustils.dart';
// import 'package:flutter/material.dart';

// class LivePageInit extends StatelessWidget {
//   final String liveID;
//   final bool isHost;
//   final liveTextCtrl =
//       TextEditingController(text: Random().nextInt(10000).toString());
//   LivePageInit({Key? key, required this.liveID, this.isHost = false})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final buttonStyle = ElevatedButton.styleFrom(
//       fixedSize: const Size(120, 60),
//       backgroundColor: const Color(0xff2C2F3E).withOpacity(0.6),
//     );
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                     'User ID:${SharedClass.userId == '' ? Random().nextInt(10000).toString() : SharedClass.userId}'),
//                 const Text('Please test with two or more devices'),
//                 TextFormField(
//                   controller: liveTextCtrl,
//                   decoration:
//                       const InputDecoration(labelText: 'join a live by id'),
//                 ),
//                 const SizedBox(height: 20),
//                 // click me to navigate to LivePage
//                 ElevatedButton(
//                   style: buttonStyle,
//                   child: const Text('Start a live'),
//                   onPressed: () => jumpToLivePage(
//                     context,
//                     liveID: liveTextCtrl.text.trim(),
//                     isHost: true,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 // click me to navigate to LivePage
//                 ElevatedButton(
//                   style: buttonStyle,
//                   child: const Text('Watch a live'),
//                   onPressed: () => jumpToLivePage(
//                     context,
//                     liveID: liveTextCtrl.text.trim(),
//                     isHost: false,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void jumpToLivePage(BuildContext context,
//       {required String liveID, required bool isHost}) {
//     Navigator.push(
//         context, Utils.createRoute(LivePage(liveID: liveID, isHost: isHost)));
//   }
// }

// class LivePage extends StatefulWidget {
//   final String liveID;
//   final bool isHost;

//   const LivePage({
//     Key? key,
//     required this.liveID,
//     this.isHost = false,
//   }) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => Container();
//   // State<StatefulWidget> createState() => LivePageState();
// }

// // class LivePageState extends State<LivePage> {
// //   final liveController = ZegoUIKitPrebuiltLiveStreamingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: ZegoUIKitPrebuiltLiveStreaming(
// //         appID: 1186124276 /*input your AppID*/,
// //         appSign:
// //             '6f5dcd86fd33c7c974f9fe4270ec300fb2ab295614c5c97a48fdb0eb263760c7' /*input your AppSign*/,
// //         userID: SharedClass.userId == ''
// //             ? Random().nextInt(10000).toString()
// //             : SharedClass.userId,
// //         userName:
// //             'user_${SharedClass.userId == '' ? Random().nextInt(10000).toString() : SharedClass.userId}',
// //         liveID: widget.liveID,
// //         controller: liveController,
// //         config: (widget.isHost
// //             ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
// //             : ZegoUIKitPrebuiltLiveStreamingConfig.audience())
// //           ..avatarBuilder = customAvatarBuilder,
// //       ),
// //     );
// //   }
// // }
