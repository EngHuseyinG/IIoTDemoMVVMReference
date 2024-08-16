import 'package:demo/models/drawerItems.dart';
import 'package:flutter/material.dart';


class drawerViewModel  extends ChangeNotifier {
  int _selectedIndex = 0;

  final List<drawerItem> _drawerItems = [
    drawerItem(title: 'Anasayfa', icon: Icons.home_outlined, route: '/anasayfa'),
    drawerItem(title: 'İzlenebilirlik', icon: Icons.live_tv, route: '/izlenebilirlik/anasayfa'),
    drawerItem(title: 'Raporlama', icon: Icons.document_scanner_outlined, route: ''),
    drawerItem(title: 'Cihaz Yönetimi', icon: Icons.device_hub, route: ''),
    drawerItem(title: 'Modül Yönetimi', icon: Icons.sim_card, route: ''),
    drawerItem(title: 'Hakkında', icon: Icons.info_outline, route: ''),
  ];


  List<drawerItem> get drawerItems => _drawerItems;

  int get selectedIndex => _selectedIndex;

  void selectItem(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  String get currentRoute => _drawerItems[_selectedIndex].route;

}