import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'networking.dart';
import 'locationScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


const ApiKey = 'f054d40f4d88a1afe21b05851029c82d';

class LoadingScreen extends StatefulWidget {


  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData()async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     latitude = position.latitude;
     longitude = position.longitude;
     NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$ApiKey&units=metric');
   var watherData = await networkHelper.getData();


    Navigator.push(context,MaterialPageRoute(builder: (context){
      return LocationScreen(
        locationWeather: watherData,
      );
    }
    ));

  }



  @override
  Widget build(BuildContext context) {
    getLocationData();
    return Scaffold(
            body: Center(
              child: SpinKitDualRing(
                color: Colors.white,
                size: 60.0,
              ),
            ),
    );
  }
}
