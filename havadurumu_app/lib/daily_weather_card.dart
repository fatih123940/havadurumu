import 'package:flutter/material.dart';
class DailyWeatherCard extends StatelessWidget {

  final String? icon ;
  final double? temperature ;
  final String? dates;
  DailyWeatherCard({this.dates, this.temperature, this.icon});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: SizedBox(
        width: 140,
        child: Column(children: [
          Image.network('https://openweathermap.org/img/wn/$icon.png'),
          Text('$temperature C'),
          Text(dates!),
        ],),
      ),
    );
  }
}
