import 'package:flutter/material.dart';

Widget customAppBar({String text ="",List<Widget>? action}) {
  return AppBar(
    leading: Icon(Icons.arrow_back_ios),
    title: Text(text),
    actions: action,
  );
}
