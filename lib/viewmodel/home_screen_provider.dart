import 'package:flutter/cupertino.dart';

class HomeScreenProvider extends ChangeNotifier{

  int selectedIndex = 0;
  onBottomNavIndexChanged(int index){
    selectedIndex = index;
    notifyListeners();
  }
}