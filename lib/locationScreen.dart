
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'weather.dart';
import 'cityScreen.dart';
import 'networking.dart';

class LocationScreen extends StatefulWidget {
        LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
   WeatherModel weather = WeatherModel();

  var temperature ;
  var description;
  var country;
  String message;
  int condition;
  String weatherIcon;
  @override
  void initState() {
    super.initState();
    updateUi(widget.locationWeather);
  }

  void updateUi(dynamic watherData){
     double temp =watherData['main']['temp'];
     temperature = temp.toInt();
     description = watherData['weather'][0]['description'];
     country = watherData['sys']['country'];
     condition = watherData['weather'][0]['id'];
     weatherIcon = weather.getWeatherIcon(condition);
     message = weather.getMessage(temperature);



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
           decoration: BoxDecoration(
             image: DecorationImage(
               image: AssetImage('images/backgrount.jpg',
               ),
               fit: BoxFit.cover,
             ),
           ),
         child: SafeArea(
           
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
                 Expanded(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       FlatButton(
                         onPressed: (){

                         },
                         child: Icon(
                           Icons.near_me,
                           size: 50.0,
                         ),
                       ),
                       FlatButton(
                           onPressed:()async {
                            var typeName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                               return CityScreen();
                             },
                            ),
                            );
                                if(typeName!=null){
                                   var data= await weather.getCityWeather(typeName);
                                  updateUi(data);

                                }
                           },
                             child: Icon(
                               Icons.location_city,
                               size: 50.0,
                             ),
                       ),
                     ],
                   ),
                 ),
                 Padding(
                   padding: EdgeInsets.only(bottom: 100.0,left: 15.0),
                   child: Column(
                     children: [
                       Padding(
                         padding: EdgeInsets.only(bottom: 10),
                         child: Row(
                           children: [
                             Text(
                               'You are in $country',
                             style: TextStyle(
                               fontSize: 45,
                               fontWeight: FontWeight.bold,
                             ),
                             ),
                           ],
                         ),
                       ),
                       Row(
                         children: [
                           Text(
                             '$temperature°',
                             style: TextStyle(
                               fontSize: 50,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           Text(
                             '$weatherIcon',
                             style: TextStyle(
                               fontSize: 40,
                             ),
                           ),
                         ],
                       ),
                       Row(
                         children: [
                           Text(
                               '$description',
                             style: TextStyle(
                               fontWeight: FontWeight.w400,
                               fontSize: 15.0,
                             ),
                           ),
                         ],
                       )
                   ],
                   ),
                 ),

                 Padding(
                     padding:EdgeInsets.only(right: 20.0,bottom: 40.0),
                   child: Text(
                     '$message',
                     style: TextStyle(
                       fontSize: 40,
                       fontWeight: FontWeight.bold,
                     ),
                     textAlign: TextAlign.right,

                   ),
                 )
               ],
             ),

         ),
         ),
       );
  }
}
