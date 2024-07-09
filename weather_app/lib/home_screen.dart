import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'weather_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _cityController = TextEditingController();
  bool _isLoading = false;

  void _fetchWeather(String cityName) async {
    setState(() {
      _isLoading = true;
    });

    // Replace with your weather API endpoint
    String apiKey = '7a794d563b06768187d316f41e99b975';
    String apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WeatherDetailsScreen(weatherData: jsonData),
          ),
        );
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.brown,
        backgroundColor: Colors.black,
        title:
            Text('WEATHER APP', style: TextStyle(fontWeight: FontWeight.w900)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  hintText: 'Enter city name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  String cityName = _cityController.text.trim();
                  if (cityName.isNotEmpty) {
                    _fetchWeather(cityName);
                  }
                },
                child: Text('Get Weather'),
              ),
              SizedBox(height: 20.0),
              _isLoading ? CircularProgressIndicator() : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
