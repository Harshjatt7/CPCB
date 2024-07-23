// import 'package:flutter/material.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   Set<String> selected = {};

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(selected.isEmpty
//             ? 'Select'
//             : selected.reduce((a, b) => '$a , $b')),
//         Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: DropdownButtonFormField(
//             onChanged: (x) {},
//             items: ['a', 'b', 'c', 'd', 'e']
//                 .map(
//                   (e) => DropdownMenuItem(
//                     value: e,
//                     child: Row(
//                       children: [
//                         Checkbox(
//                             value: selected.contains(e),
//                             onChanged: (isSelected) {
//                               if (isSelected == null) {
//                                 return null;
//                               }
//                               if (isSelected) {
//                                 selected.add(e);
//                               } else {
//                                 selected.remove(e);
//                               }
//                               setState(() {});
//                             }),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(e)
//                       ],
//                     ),
//                   ),
//                 )
//                 .toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }
