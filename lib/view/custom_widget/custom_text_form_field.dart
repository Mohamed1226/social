import 'package:flutter/material.dart';

// Widget onBoardItem(context) {
//   return Padding(
//     padding: const EdgeInsets.all(30.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Image(
//             image: AssetImage(
//               "${onBoard.image}",
//             ),
//           ),
//         ),
//         Text(
//           "${onBoard.title}",
//           style: Theme.of(context).textTheme.bodyText1,
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Text(
//           "${onBoard.body}",
//           style: Theme.of(context).textTheme.bodyText2,
//         ),
//       ],
//     ),
//   );
// }

Widget customTextFormField(
    {required bool obsure,
    required TextInputType type,
    FormFieldSetter? onSaved,
    FormFieldValidator? validate,
    required String label,
    TextEditingController? controller,
    Widget? prefix,
    Widget? suffix}) {
  return TextFormField(
    controller: controller,
    obscureText: obsure,
    onSaved: onSaved,
    validator: validate,
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      focusColor: Colors.black,
      labelText: label,
      labelStyle: TextStyle(fontSize: 25),
      prefixIcon: prefix,
      suffixIcon: suffix,
    ),
    keyboardType: type,
  );
}
