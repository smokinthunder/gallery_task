import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

AppBar customAppBar() {
  return AppBar(
    leading: Icon(Icons.menu_rounded),
    centerTitle: true,
    title: Text("ente", style: TextStyle(fontWeight: FontWeight.w600)),
    actions: [Icon(Icons.add_photo_alternate_outlined), Gap(10)],
  );
}
