// the files in the assistant package coverts the location codes to readable format


import 'package:deliverymap/Assistant/request_assistant.dart';
import 'package:deliverymap/DataHandler/app_data.dart';
import 'package:deliverymap/Models/address.dart';
import 'package:deliverymap/configurations/Configmaps.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class AssistantMethods
{

  static Future<String> searchCoordinateAddress(Position position ,context) async{
  String placeAddress ='';
  String st1, st2,st3,st4;
  String url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey';

  var response = await RequestAssistant.getRequest(url);

  if(response != 'failed')
  {
    // placeAddress = response['results'][0]['formatted_address'];
   st1= response['results'][0]['address_components'][0]['long_name'];
   st2= response['results'][0]['address_components'][1]['long_name'];
   st3= response['results'][0]['address_components'][5]['long_name'];
   st4= response['results'][0]['address_components'][6]['long_name'];
   placeAddress = st1 + ',' + st2 + ','+ st3 + ',' +st4 + ',';


    // ignore: file_names
    Address userPickUpAddress = new  Address();
   userPickUpAddress.longitude = position.longitude;
   userPickUpAddress.latitude = position.latitude;
   userPickUpAddress.placeName = placeAddress;


    Provider.of<AppData>(context, listen: false).updatePickUpLocation(userPickUpAddress);

  }

  return placeAddress;
}

}
