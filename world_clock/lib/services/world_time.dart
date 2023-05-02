import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for the UI
  String time = ""; //the time in location
  String flag; //url to asset flag icon
  String url; //location url for api endpoint
  bool? isDaytime = false;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);
      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);

      //create DateTime Object
      DateTime now = DateTime.parse(datetime);
      now = now.subtract(Duration(hours: int.parse(offset)));
      //set time property
      time = DateFormat.jm().format(now);
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
    } catch (e) {
      print('caught error: $e');
      time = 'Could not get time data';
    }
  }
}

WorldTime instance =
    WorldTime(location: 'Berlin', flag: 'germany.png', url: 'europe/berlin');
