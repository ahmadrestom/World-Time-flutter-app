import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  late String location; //location name for the UI
  late String time; //time in that location
  late String flag; //url to an asset flag icon
  late String url; //location url for api endpoint
  late bool isDaytime;

  WorldTime({ required this.location, required this.flag, required this.url });

  Future<void> getTime() async{
    await Future.delayed(const Duration(seconds: 3), () {}); //for the loading animation
    try{
      //fetching the data and storing it inside a Response object
      Response response = await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body); //changes the response body to a Map (since response.body is a json)
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //create datetime object
      DateTime now = DateTime.parse(datetime); //convert to DateTime object
      now = now.add(Duration(hours: int.parse(offset))); //adds a duration to a datetime object

      //set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false; //check if it's daytime or nighttime
      time = DateFormat.jm().format(now); //formats the date using intl package
    }
    catch(e){
      print('Caught Error: $e');
      time = 'could not get time data';
    }
  }
}