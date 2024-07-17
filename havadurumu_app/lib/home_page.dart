import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:havadurumu_app/search_page.dart';

import 'daily_weather_card.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String location ='Ankara';
  double? temperature;
  final String key = '3aa03f4b9c6f957d04182107c7fc60a7';
  dynamic locationData;
  String code = 'c';
  String? icon;
  List<String> icons = ['01d','01d','01d','01d','01d'];
  List<double> temperatures = [20,20,20,20,20];
  List<String> dates = ['P.tesi','Salı','Çarşamba','Perşembe','Cuma'];

  Future <void> getLocationData () async {
     locationData=await  http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$key&units=metric'));

     final locationDataParsed=jsonDecode(locationData.body);

     setState(() {
       location = locationDataParsed['name'];
       temperature=locationDataParsed['main']['temp'];
       code = locationDataParsed['weather'][0]['main'];
       icon=locationDataParsed ['weather'][0]['icon'];
     });

  }
  @override
  void initState() {
    getLocationData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/$code.jpg'),
          fit: BoxFit.cover
        ),

      ),
      child:  (temperature ==null)
      ? Center(child: CircularProgressIndicator())




      :Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 150,child: Image.network('https://openweathermap.org/img/wn/$icon@4x.png'),),
            Text('$temperature C',style: TextStyle(fontSize: 70),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(location,style: TextStyle(fontSize: 30),),
                IconButton(onPressed: ()async {
                  final selectedCity=await Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));

                  location=selectedCity;
                  getLocationData();

                  }, icon: Icon(Icons.search))
              ],
            ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    DailyWeatherCard(icon: icons[0], dates: dates[0], temperature: temperatures[0],),
                    DailyWeatherCard(icon: icons[1], dates: dates[1], temperature: temperatures[1],),
                    DailyWeatherCard(icon: icons[2], dates: dates[2], temperature: temperatures[2],),
                    DailyWeatherCard(icon: icons[3], dates: dates[3], temperature: temperatures[3],),
                    DailyWeatherCard(icon: icons[4], dates: dates[4], temperature: temperatures[4],),
                  ],
                ),

              ),


          ],),
        ),
      ),

    );
  }
}
