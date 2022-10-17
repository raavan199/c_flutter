import 'dart:core';



///This model calss is used for managing sync api call

class ApiSync{

  String apiName,icon;
  bool apiCallStatus=false;

  ApiSync({required this.apiName, required this.icon,required this.apiCallStatus});
}