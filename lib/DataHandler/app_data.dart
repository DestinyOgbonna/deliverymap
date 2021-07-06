import 'package:deliverymap/models/address.dart';
import 'package:flutter/cupertino.dart';



class AppData extends ChangeNotifier
{

  Address userpickUpLocation;

  void updatePickUpLocation (Address pickUpAddress)

  {
    userpickUpLocation = pickUpAddress;
    notifyListeners();
  }


}