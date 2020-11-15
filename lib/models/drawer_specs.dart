import 'package:flutter/foundation.dart';

class DrawerSpecs with ChangeNotifier {
  double _drawerValue = 0;

  double get getDrawerValue {
    return _drawerValue;
  }

  incrementDrawerValue(double i) {
    _drawerValue += i;
    notifyListeners();
  }

  decrementDrawerValue(double i) {
    _drawerValue -= i;
    notifyListeners();
  }

  setDrawerValue(double i) {
    _drawerValue = i;
    notifyListeners();
  }
}
