import 'package:flutter/material.dart';

class drawerItem {
  late final String title;
  late final IconData icon;
  final String route;

  drawerItem({required this.route, required this.title, required this.icon});
}