import 'package:flutter/material.dart';

class DrawerMenu {
  String text;
  IconData icon;
  String route;

  DrawerMenu({required this.text, required this.icon, required this.route});
}

class WorkingHoursModel {
  String workingDays;
  String isClosed;

  WorkingHoursModel({
    required this.isClosed,
    required this.workingDays,
  });
}
