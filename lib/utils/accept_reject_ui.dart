// import 'package:flutter/material.dart';
// import 'package:system_alert_window/system_alert_window.dart';

// import 'constants.dart';

// SystemWindowHeader uiHeader = SystemWindowHeader(
//     title: SystemWindowText(
//         text: "New Order", fontSize: 13, textColor: Colors.black45),
//     padding: SystemWindowPadding.setSymmetricPadding(12, 12),
//     subTitle: SystemWindowText(
//         text: "#094",
//         fontSize: 14,
//         fontWeight: FontWeight.BOLD,
//         textColor: Colors.black87),
//     decoration: SystemWindowDecoration(startColor: Colors.grey[100]),
//     // button: SystemWindowButton(
//     //   text: SystemWindowText(
//     //       text: "close", fontSize: 12, textColor: Colors.white),
//     //   tag: "close_button",
//     //   width: 0,
//     //   padding: SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
//     //   height: SystemWindowButton.WRAP_CONTENT,
//     // ),
//     // buttonPosition: ButtonPosition.TRAILING,
//     );
// SystemWindowBody uiBody = SystemWindowBody(
//   rows: [
//     EachRow(
//       columns: [
//         EachColumn(
//           text: SystemWindowText(
//               text: "You have a new order!", fontSize: 14, textColor: Colors.grey),
//         ),
//       ],
//       gravity: ContentGravity.CENTER,
//     ),
//     EachRow(columns: [
//       EachColumn(
//           text: SystemWindowText(
//               text: "Check the app to review this order",
//               fontSize: 18,
//               textColor: Colors.black,
//               fontWeight: FontWeight.BOLD,),
//           padding: SystemWindowPadding.setSymmetricPadding(6, 8),
//           decoration: SystemWindowDecoration(
//               startColor: Colors.black12, borderRadius: 25.0),
//           margin: SystemWindowMargin(top: 4)),
//     ], gravity: ContentGravity.CENTER),
//   ],
//   padding: SystemWindowPadding(left: 16, right: 16, bottom: 12, top: 12),
// );
// SystemWindowFooter uiFooter = SystemWindowFooter(
//     buttons: [
//       SystemWindowButton(
//         text: SystemWindowText(
//             text: "REJECT", fontSize: 12, textColor: Colors.white),
//         tag: "reject_button",
//         width: 0,
//         padding: SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
//         height: SystemWindowButton.WRAP_CONTENT,
//         decoration: SystemWindowDecoration(
//             startColor: redColor,
//             // Color.fromRGBO(250, 139, 97, 1),
//             endColor: redColor,
//             // Color.fromRGBO(247, 28, 88, 1),
//             borderWidth: 0,
//             borderRadius: 0.0),
//       ),
//       SystemWindowButton(
//         text: SystemWindowText(
//             text: "ACCEPT", fontSize: 12, textColor: Colors.white),
//         tag: "accept_button",
//         width: 0,
//         padding: SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
//         height: SystemWindowButton.WRAP_CONTENT,
//         decoration: SystemWindowDecoration(
//             startColor: Color.fromRGBO(250, 139, 97, 1),
//             endColor: Color.fromRGBO(247, 28, 88, 1),
//             borderWidth: 0,
//             borderRadius: 0.0),
//       )
//     ],
//     padding: SystemWindowPadding(left: 16, right: 16, bottom: 12),
//     decoration: SystemWindowDecoration(startColor: Colors.white),
//     buttonsPosition: ButtonPosition.CENTER);
