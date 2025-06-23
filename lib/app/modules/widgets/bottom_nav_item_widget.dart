// import 'package:flutter/material.dart';
//
//
// class BottomNavItemWidget extends StatelessWidget {
//   final String selectedIcon;
//   final String unSelectedIcon;
//   final String title;
//   final Function? onTap;
//   final bool isSelected;
//   const BottomNavItemWidget({super.key, this.onTap, this.isSelected = false, required this.title, required this.selectedIcon, required this.unSelectedIcon});
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: InkWell(
//         onTap: onTap as void Function()?,
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//
//           Image.asset(
//             isSelected ? selectedIcon : unSelectedIcon, height: 25, width: 25,
//             color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium!.color!,
//           ),
//
//           SizedBox(height: isSelected ? 5 : 10),
//
//           Text(
//             title,
//             style: TextStyle(color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium!.color!, fontSize: 12),
//           ),
//
//         ]),
//       ),
//     );
//   }
// }
