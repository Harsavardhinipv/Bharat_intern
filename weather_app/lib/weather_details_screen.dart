import 'package:flutter/material.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final dynamic weatherData;

  WeatherDetailsScreen({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    String cityName = weatherData['name'];
    double temperature = weatherData['main']['temp'];
    String weatherDescription = weatherData['weather'][0]['description'];
    int humidity = weatherData['main']['humidity'];
    double windSpeed = weatherData['wind']['speed'];

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.brown,
        backgroundColor: Colors.black,
        title: Text(
          'WEATHER DETAILS',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              cityName,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              '${temperature.toStringAsFixed(1)} °C',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              weatherDescription,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Icon(
              Icons.wb_sunny, // Replace with actual weather icons
              size: 50.0,
            ),
            SizedBox(height: 10.0),
            Text(
              'Humidity: $humidity%',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Wind Speed: $windSpeed m/s',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
