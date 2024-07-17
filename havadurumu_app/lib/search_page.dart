import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? selectedCity;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/search.jpg'),
            fit: BoxFit.cover
        ),

      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  onChanged: (value){
                    selectedCity=value;
                  },
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Şehir seçiniz',
                    border: OutlineInputBorder(borderSide: BorderSide.none),

                  ),
                ),

              ),
              ElevatedButton(onPressed: () async {
                var response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$selectedCity&appid=3aa03f4b9c6f957d04182107c7fc60a7'));
                if(response.statusCode == 200){
                  Navigator.pop(context,selectedCity);
                }else {
                 _showMyDialog();
                }

              }, child: Text('Select City'))
            ],),
        ),
      ),

    );
  }


  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location not Found'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Select other locaiton'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
